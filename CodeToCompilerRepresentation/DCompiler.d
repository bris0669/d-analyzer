import std.file;
import Log;
import std.process;
import std.conv;

class DCompiler {
	string sourceCode;

	this(string sourceCode) {
		this.sourceCode = sourceCode;
	}

	string Compile() {
		string sourceFile = "/tmp/code.d";
		std.file.write(sourceFile, sourceCode);
		
		return GetVerboseOutput(sourceFile);
	}

	string GetVerboseOutput(string sourceFile) {
		string result;
		auto process = execute(["/home/cbobby/.usrlocal/bin/ldc2", 
		  "-vv", "-O0", "-output-ll", sourceFile]);
		if ((process.status != 0) && (process.status != 1)) {
			LogInfo("Compilation failed. Exit status " ~ to!string(process.status) ~ ". Output:\n" ~ process.output);
		} else {
			result = process.output;
		}
		return result;
	}

}
