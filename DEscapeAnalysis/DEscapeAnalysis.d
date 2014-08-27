import std.stdio;
import DEscapeAnalysisEngine;

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
	//writeln(subprocessResult.StdoutContent);
}
