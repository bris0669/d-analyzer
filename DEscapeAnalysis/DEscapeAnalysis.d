import std.stdio;
import DSourceCodeInstrumenter;
import Subprocess;

void main(string[] args) {
	string sourceCode;
	string line;
	while ((line = stdin.readln()) !is null)
		sourceCode ~= line;

	DSourceCodeInstrumenter dSourceCodeInstrumenter = new DSourceCodeInstrumenter(sourceCode);
	string instrumentedSourceCode = dSourceCodeInstrumenter.Instrument();

	Subprocess subprocess = new Subprocess();
	SubprocessResult subprocessResult = subprocess.Run("./CodeToCompilerRepresentation", sourceCode);

	writeln(subprocessResult.StdoutContent);
}
