import StaticAnalysisWarning;
import std.regex;
import std.stdio;
import std.file;
import std.conv;
import std.string;

class TypeAllocation {
	string TypeName;
	string SuperTypes;
	int LineOfFirstAllocation;
	int AllocationCount;
	int DeallocationCount;
}

class DWarningsGenerator {
	string instrumentedSourceCode;
	string compilerRepresentation;
	bool isGCDisabled;

	this(string instrumentedSourceCode, string compilerRepresentation) {
		this.instrumentedSourceCode = instrumentedSourceCode;
		this.compilerRepresentation = compilerRepresentation;
	}

	StaticAnalysisWarning[] GenerateWarnings() {
		StaticAnalysisWarning[] result;

		isGCDisabled = GetIsGCDisabled();
		TypeAllocation[] typeAllocations = GetTypeAllocations();
		foreach (typeAllocation; typeAllocations) {
			StaticAnalysisWarning warning = GetWarning(typeAllocation);
			if (warning !is null)
				result ~= warning;
		}

		return result;
	}

	bool GetIsGCDisabled() {
		auto c = matchFirst(instrumentedSourceCode, `GC.disable\(\)`); 
		return (!c.empty);
	}

	TypeAllocation[] GetTypeAllocations() {
		TypeAllocation[] result;

		//std.file.write("/tmp/regex.txt", compilerRepresentation);

		auto r = regex(`DeclarationExp::toElem: static string new_.*";`);
		foreach(c; matchAll(compilerRepresentation, r))
			result = PutAllocation(result, c.hit);
		//append("/tmp/regex.txt", c.hit ~ "\n");
		
		r = regex(`DeclarationExp::toElem: alias \(.*\) new_super.*;`);
		foreach(c; matchAll(compilerRepresentation, r))
			result = PutSuperTypes(result, c.hit);
			//append("/tmp/regex.txt", c.hit ~ "\n");

		return result;
	}

	StaticAnalysisWarning GetWarning(TypeAllocation typeAllocation) {
		StaticAnalysisWarning result;

		if (typeAllocation.AllocationCount > typeAllocation.DeallocationCount) {
			result = new StaticAnalysisWarning();
			result.Line = typeAllocation.LineOfFirstAllocation;
			if (isGCDisabled) {
				result.Level = StaticAnalysisWarningLevel.Error;
				result.Text = format("Possible memory leak. Type '%s' was allocated %d times and was deallocated %d times",
														 typeAllocation.TypeName, typeAllocation.AllocationCount,
														 typeAllocation.DeallocationCount);
			}
		}
		return result;
	}

	TypeAllocation[] PutAllocation(TypeAllocation[] typeAllocations, string compilerRepresentationLine) {
		//DeclarationExp::toElem: static string new_A_10 = "code.A";
		string typeName = matchFirst(compilerRepresentationLine, regex(`_(.*)_`))[1];
		int sourceCodeLine = to!int(matchFirst(compilerRepresentationLine, regex(`_([0-9]*) =`))[1]);
		//append("/tmp/regex.txt", typeName ~ " " ~ sourceCodeLine ~ "\n");

		bool wasFound;
		foreach (typeAllocation; typeAllocations) {
			if (typeAllocation.TypeName == typeName) {
				typeAllocation.AllocationCount++;
				wasFound = true;
				break;
			}
		}

		if (!wasFound) {
			auto typeAllocation = new TypeAllocation();
			typeAllocation.TypeName = typeName;
			typeAllocation.LineOfFirstAllocation = sourceCodeLine;
			typeAllocation.AllocationCount++;
			typeAllocations ~= typeAllocation;
		}

		return typeAllocations;
	}

	TypeAllocation[] PutSuperTypes(TypeAllocation[] typeAllocations, string compilerRepresentationLine) {
		//DeclarationExp::toElem: alias (Object) new_super_A_10;
		return typeAllocations;
	}
}
