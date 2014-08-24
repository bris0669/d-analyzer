import std.stdio;
import DSourceCodeInstrumenter;

void main(string[] args) {
	string sourceCode;
	string line;
	while ((line = stdin.readln()) !is null)
		sourceCode ~= line;

	DSourceCodeInstrumenter dSourceCodeInstrumenter = new DSourceCodeInstrumenter(sourceCode);
	string instrumentedSourceCode = dSourceCodeInstrumenter.Instrument();

	writeln(instrumentedSourceCode);
}
