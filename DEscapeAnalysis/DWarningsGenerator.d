import StaticAnalysisWarning;
import std.regex;
import std.stdio;
import std.file;

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

	this(string instrumentedSourceCode, string compilerRepresentation) {
		this.instrumentedSourceCode = instrumentedSourceCode;
		this.compilerRepresentation = compilerRepresentation;
	}

	StaticAnalysisWarning[] GenerateWarnings() {
		StaticAnalysisWarning[] result;

		TypeAllocation[] typeAllocations = GetTypeAllocations();
		foreach (typeAllocation; typeAllocations) {
			StaticAnalysisWarning warning = GetWarning(typeAllocation);
			if (warning !is null)
				result ~= warning;
		}

		return result;
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

		return result;
	}

}
