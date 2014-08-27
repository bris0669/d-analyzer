import std.stdio;
import std.getopt;
import DCompiler;
import CppCompiler;
import ProcessResult;

enum ProgrammingLanguage { D, CPP }

void main(string[] args) {
	ProgrammingLanguage programmingLanguage;
	getopt(args, "lang", &programmingLanguage);
	
	string sourceCode;
	string line;
	while ((line = stdin.readln()) !is null)
		sourceCode ~= line;

	ProcessResult processResult;
	if (programmingLanguage == ProgrammingLanguage.D) {
		DCompiler dCompiler = new DCompiler(sourceCode);
		processResult = dCompiler.Compile();
	} else if (programmingLanguage == ProgrammingLanguage.CPP) {
		CppCompiler cppCompiler = new CppCompiler(sourceCode);
		processResult = cppCompiler.Compile();
	}

	if (processResult.StderrContent != "") {
		writeln(processResult.StderrContent);
		return;
	}
	writeln(processResult.StdoutContent);
}
