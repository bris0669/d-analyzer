import std.stdio;
import std.process;
import std.uri;
import std.string;
import std.array;

class Service {
	this() {
	}

	void Main() {
		write("Content-type: text/html\n\n");
		//auto dmd = execute(["ldc2", "myapp.d"]);
		//if (dmd.status != 0) writeln("Compilation failed:\n", dmd.output);

    //writeln("Hello, world!");
		//writeln(environment.toAA());

		string logBuffer = "";

		string line;
    if ((line = stdin.readln()) !is null) {
			line = line[4..$];
      //writeln(line);
			string inputSourceCode = decode(line);
			dchar[dchar] translationTable = ['+' : ' '];
			inputSourceCode = translate(inputSourceCode, translationTable);
			inputSourceCode = replace(inputSourceCode, "%3B", ";");
			writeln(inputSourceCode);
		}

		writeln(logBuffer);

	}
}
 
void main()
{
  Service service = new Service();
	service.Main();
}
