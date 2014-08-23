import std.stdio;
import std.getopt;
import DCompiler;
import CppCompiler;

enum ProgrammingLanguage { D, CPP }

void main(string[] args) {
	ProgrammingLanguage programmingLanguage;
	getopt(args, "lang", &programmingLanguage);
	
	string sourceCode;
	string line;
	while ((line = stdin.readln()) !is null)
		sourceCode ~= line;

	string compilerRepresentation;
	if (programmingLanguage == ProgrammingLanguage.D) {
		DCompiler dCompiler = new DCompiler(sourceCode);
		compilerRepresentation = dCompiler.Compile();
	} else if (programmingLanguage == ProgrammingLanguage.CPP) {
		CppCompiler cppCompiler = new CppCompiler(sourceCode);
		compilerRepresentation = cppCompiler.Compile();
	}

	writeln(compilerRepresentation);
}
