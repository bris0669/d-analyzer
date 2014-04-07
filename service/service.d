import std.stdio;
import std.process;
import std.uri;
import std.string;
import std.array;
import LlvmirRepresentation;
import Log;

class Service {
	this() {
	}

	void Main() {

		write("Content-type: text/html\n\n");
		try {
		string inputSourceCode = ""; //GetInputSourceCode();
		//writeln(inputSourceCode);		
		//auto dmd = execute(["ldc2", "myapp.d"]);
		//if (dmd.status != 0) writeln("Compilation failed:\n", dmd.output);
		//string logBuffer = "";
		//writeln(logBuffer);

		//string inputFilename = GetTemporaryFilename

		LlvmirRepresentation llvmirRepresentation = new LlvmirRepresentation(inputSourceCode);
		writeln(llvmirRepresentation.GetRepresentation());

		} catch(Exception e) {
			writeln(e);
		}

		writeln(GetLogBuffer());
	}

	string GetInputSourceCode() {
		string inputSourceCode = "";
		string line;
    if ((line = stdin.readln()) !is null) {
			line = line[4..$];
			inputSourceCode = decode(line);
			dchar[dchar] translationTable = ['+' : ' '];
			inputSourceCode = translate(inputSourceCode, translationTable);
			inputSourceCode = replace(inputSourceCode, "%3B", ";");
			inputSourceCode = replace(inputSourceCode, "%2C", ",");
		}
		return inputSourceCode;
	}

}
 
void main()
{
  Service service = new Service();
	service.Main();
}
