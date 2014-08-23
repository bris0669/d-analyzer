import std.file;
import Log;
import std.process;
import std.conv;

class CppCompiler {
	string sourceCode;

	this(string sourceCode) {
		this.sourceCode = sourceCode;
	}

	string Compile() {
		string sourceFile = "/tmp/code.cpp";
		std.file.write(sourceFile, sourceCode);
		
		return GetVerboseOutput(sourceFile);
	}

	string GetVerboseOutput(string sourceFile) {
		string result;
		auto process = execute(["/usr/bin/clang", "-v", sourceFile, "-std=c++11", "-S", "-emit-llvm", "-o", "-"]);
		if ((process.status != 0) && (process.status != 1)) {
			LogInfo("Compilation failed. Exit status " ~ to!string(process.status) ~ ". Output:\n" ~ process.output);
		} else {
			result = process.output;
		}
		return result;
	}

}
