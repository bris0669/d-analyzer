import std.stdio;
import std.process;

class Service {
	this() {
	}

	void Main() {
		write("Content-type: text/html\n\n");
		//auto dmd = execute(["ldc2", "myapp.d"]);
		//if (dmd.status != 0) writeln("Compilation failed:\n", dmd.output);

		
    writeln("Hello, world!");
		writeln(environment.toAA());


		string line;
    while ((line = stdin.readln()) !is null)
        write(line);

	}
}
 
void main()
{
  Service service = new Service();
	service.Main();
}
