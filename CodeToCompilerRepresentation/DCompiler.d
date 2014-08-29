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
		string sourceFile = "/tmp/int/code.d";
		std.file.write(sourceFile, sourceCode);
		
		return GetVerboseOutput(sourceFile);
	}

	ProcessResult GetVerboseOutput(string sourceFile) {
		ProcessResult result = new ProcessResult();

		string currentDir = executeShell("pwd").output;

		string commandLine = "cd /tmp/int && /home/cbobby/.usrlocal/bin/ldc2 -vv -O0 " ~ sourceFile;
		auto process = executeShell(commandLine);
		//append("/tmp/int/lll.txt", currentDir ~ "ldc2 " ~ commandLine ~ " returned " ~ to!string(process.status) ~ "\n");
		result.ExitStatus = process.status;
		if (process.status != 0) {
			result.StderrContent = process.output;
			LogInfo("Compilation failed. Exit status " ~ to!string(process.status) ~ ". Output:\n" ~ process.output);
		} else {
			result.StdoutContent = process.output;
		}
		const string llvmIRFile = "code.ll";
		if (exists(llvmIRFile))
			std.file.remove(llvmIRFile);

		executeShell("cd " ~ currentDir);
		return result;
	}

}
