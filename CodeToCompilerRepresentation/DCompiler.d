import std.file;
import Log;
import std.process;
import std.conv;
import ProcessResult;

class DCompiler {
	string sourceCode;

	this(string sourceCode) {
		this.sourceCode = sourceCode;
	}

	ProcessResult Compile() {
		string sourceFile = "/tmp/code.d";
		std.file.write(sourceFile, sourceCode);
		
		return GetVerboseOutput(sourceFile);
	}

	ProcessResult GetVerboseOutput(string sourceFile) {
		ProcessResult result = new ProcessResult();
		auto process = execute(["/home/cbobby/.usrlocal/bin/ldc2", 
		  "-vv", "-O0", "-output-ll", sourceFile]);
		//if ((process.status != 0) && (process.status != 1)) {
		result.ExitStatus = process.status;
		if ((process.status != 0) && (process.status != 1)) {
			result.StderrContent = process.output;
			LogInfo("Compilation failed. Exit status " ~ to!string(process.status) ~ ". Output:\n" ~ process.output);
		} else {
			result.StdoutContent = process.output;
		}
		const string llvmIRFile = "code.ll";
		if (exists(llvmIRFile))
			std.file.remove(llvmIRFile);
		return result;
	}

}
