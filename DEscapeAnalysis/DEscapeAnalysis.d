import std.stdio;
import DEscapeAnalysisEngine;
import std.string;
import std.conv;

void main(string[] args) {
	string sourceCode;
	string line;
	while ((line = stdin.readln()) !is null)
		sourceCode ~= line;

	DEscapeAnalysisEngine dEscapeAnalysisEngine = new DEscapeAnalysisEngine(sourceCode);
	StaticAnalysisResult staticAnalysisResult = dEscapeAnalysisEngine.Analyze();
	if (staticAnalysisResult.CompilerErrors != "") {
		writeln(staticAnalysisResult.CompilerErrors);
		return;
	}
	
	foreach(warning; staticAnalysisResult.Warnings) {
		string warningLine = format("Line %d. %s: %s", warning.Line,
																to!string(warning.Level), warning.Text);
		writeln(warningLine);
	}
}
