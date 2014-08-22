import std.stdio;
import std.getopt;

enum ProgrammingLanguage { D, CPP }

void main(string[] args) {
	ProgrammingLanguage programmingLanguage;
	getopt(args, "lang", &programmingLanguage);
	
	string sourceCode;
	string line;
	while ((line = stdin.readln()) !is null)
		sourceCode ~= line;

	writeln(sourceCode);
}
