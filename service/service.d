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
			string inputSourceCode = GetInputSourceCode();
			//writeln(inputSourceCode);
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
			inputSourceCode = replace(inputSourceCode, "%3D", "=");
			inputSourceCode = replace(inputSourceCode, "%2F", "/");
			inputSourceCode = replace(inputSourceCode, "%3A", ":");

		}
		return inputSourceCode;
	}

}
 
void main()
{
  Service service = new Service();
	service.Main();
}
