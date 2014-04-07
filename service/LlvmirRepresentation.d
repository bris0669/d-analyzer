import std.file;
import Log;
import std.process;

class LlvmirRepresentation {
	string sourceCode = "";

	this(string sourceCode) {
		this.sourceCode = sourceCode;
	}

	string GetRepresentation() {
		string result = "";
		string sourceFile = GetTemporarySourceFileName();
		//std.file.write(sourceFile, sourceCode);
		LogInfo("test");
		string resultFile = GetTemporaryResultFileName();
		Compile(sourceFile, resultFile);
		result = readText(resultFile);
		return result;
	}

	string GetTemporarySourceFileName() {
		return "/tmp/tmp.d";
	}

	string GetTemporaryResultFileName() {
		return "/tmp/tmp.out";
	}

	void Compile(string sourceFile, string resultFile) {
		auto dmd = execute(["/home/cbobby/.usrlocal/bin/ldc2", 
												"-O0", "-output-ll", "-of=" ~ resultFile, sourceFile]);
		//ldc2 -O0 -output-ll -of=a.ll a.d
		if (dmd.status != 0) {
			LogInfo("Compilation failed:\n" ~ dmd.output);
		}
	}

}
