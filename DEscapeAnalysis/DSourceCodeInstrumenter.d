import std.file;
import Log;
import std.process;
import std.conv;
import std.regex;
import std.string;

class DSourceCodeInstrumenter {
	string sourceCode;

	this(string sourceCode) {
		this.sourceCode = sourceCode;
	}

	string Instrument() {
		string result;

		foreach (int lineNumber, line; splitLines(sourceCode))
			result ~= InstrumentLine(lineNumber, line) ~ "\n";

		return result;
	}

	string InstrumentLine(int lineNumber, string line) {
		string result = replaceFirst(line, 
			regex(r"\bnew\b\s*([_a-zA-Z][_0-9a-zA-Z]*)\s*\(\)\;"), 
		  "$& static auto new_$1_" ~ to!string(lineNumber) ~ " = typeid(TransitiveBaseTypeTuple!$1);");

		result = replaceFirst(result, 
			regex(r"\bdelete\b\s*([_a-zA-Z][_0-9a-zA-Z]*)\s*\;"), 
		  "$& static auto delete_$1_" ~ to!string(lineNumber) ~ " = fullyQualifiedName!(typeof($1));");
							
		if (0 == lineNumber)
			result = "import std.traits;\n" ~ result;

		return result;
	}

}
