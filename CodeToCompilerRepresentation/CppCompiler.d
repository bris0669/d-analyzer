import std.file;
import Log;
import std.process;
import std.conv;
import ProcessResult;

class CppCompiler {
	string sourceCode;

	this(string sourceCode) {
		this.sourceCode = sourceCode;
	}

	ProcessResult Compile() {
		string sourceFile = "/tmp/code.cpp";
		std.file.write(sourceFile, sourceCode);
		
		return GetVerboseOutput(sourceFile);
	}

	ProcessResult GetVerboseOutput(string sourceFile) {
		ProcessResult result = new ProcessResult();
		auto process = execute(["/usr/bin/clang", "-v", sourceFile, "-std=c++11", "-S", "-emit-llvm", "-o", "-"]);
		result.ExitStatus = process.status;
		if (process.status != 0) {
			result.StderrContent = process.output;
			LogInfo("Compilation failed. Exit status " ~ to!string(process.status) ~ ". Output:\n" ~ process.output);
		} else {
			result.StdoutContent = process.output;
		}
		return result;
	}

}
