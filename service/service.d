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
import ActionDispatcher;
import ActionType;

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
			string sourceCode = GetSourceCode(urlQuery);

			auto actionDispatcher = new ActionDispatcher(actionType, sourceCode);
			string actionResultAsString = actionDispatcher.PerformAction();
			//LlvmirRepresentation llvmirRepresentation = new LlvmirRepresentation(inputSourceCode);
			//writeln(llvmirRepresentation.GetRepresentation());
			writeln(actionResultAsString);
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

	string GetSourceCode(string urlQuery) {
		//action=dCompilerRepresentation&isc=import+std.stdio%3B%0A%0Avoid+main()+%7B%0A++++writeln(%22Hello%2C+world!%22)%3B%0A%7D%0A
		string sourceCode = "";
		string line = find(urlQuery, "isc=");
		line = line[4..$];
		sourceCode = decode(line);
		dchar[dchar] translationTable = ['+' : ' '];
		sourceCode = translate(sourceCode, translationTable);
		sourceCode = replace(sourceCode, "%3B", ";");
		sourceCode = replace(sourceCode, "%2C", ",");
		sourceCode = replace(sourceCode, "%3D", "=");
		sourceCode = replace(sourceCode, "%2F", "/");
		sourceCode = replace(sourceCode, "%3A", ":");

		return sourceCode;
	}

}
 
void main()
{
  Service service = new Service();
	service.Main();
}
