import std.stdio;
import std.process;
import std.uri;
import std.string;
import std.array;
import LlvmirRepresentation;
import Log;
import std.algorithm;
import std.regex;
import std.conv;

enum ActionType {
	DEscapeAnalysis, CppEscapeAnalysis, CppSafeFormat, 
	DCompilerRepresentation, CppCompilerRepresentation
}

class Service {
	private string urlQuery;

	this() {
	}

	void Main() {
		write("Content-type: text/html\n\n");

		try {
			urlQuery = stdin.readln();
			if (urlQuery is null) {
				writeln("Bad URL.");
				return;
			}
			ActionType actionType = GetActionType(urlQuery);
			string inputSourceCode = GetInputSourceCode(urlQuery);
			LlvmirRepresentation llvmirRepresentation = new LlvmirRepresentation(inputSourceCode);
			writeln(llvmirRepresentation.GetRepresentation());
		} catch(Exception e) {
			writeln(e);
		}

		writeln(GetLogBuffer());
	}

	ActionType GetActionType(string urlQuery) {
		//action=dCompilerRepresentation&isc=import+std.stdio%3B%0A%0Avoid+main()+%7B%0A++++writeln(%22Hello%2C+world!%22)%3B%0A%7D%0A
		ActionType result;
		string actionTypeAsString = matchFirst(urlQuery, regex(`action=(.*)\&`))[1];
		string firstChar = actionTypeAsString[0..1];
		string capitalizedActionType = firstChar.toUpper() ~ actionTypeAsString[1..$];
		result = to!ActionType(capitalizedActionType);
		return result;
	}

	string GetInputSourceCode(string urlQuery) {
		//action=dCompilerRepresentation&isc=import+std.stdio%3B%0A%0Avoid+main()+%7B%0A++++writeln(%22Hello%2C+world!%22)%3B%0A%7D%0A
		string inputSourceCode = "";
		string line = find(urlQuery, "isc=");
		line = line[4..$];
		inputSourceCode = decode(line);
		dchar[dchar] translationTable = ['+' : ' '];
		inputSourceCode = translate(inputSourceCode, translationTable);
		inputSourceCode = replace(inputSourceCode, "%3B", ";");
		inputSourceCode = replace(inputSourceCode, "%2C", ",");
		inputSourceCode = replace(inputSourceCode, "%3D", "=");
		inputSourceCode = replace(inputSourceCode, "%2F", "/");
		inputSourceCode = replace(inputSourceCode, "%3A", ":");

		return inputSourceCode;
	}

}
 
void main()
{
  Service service = new Service();
	service.Main();
}
