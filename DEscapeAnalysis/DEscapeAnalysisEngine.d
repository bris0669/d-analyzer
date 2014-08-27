import DSourceCodeInstrumenter;
import Subprocess;

enum StaticAnalysisWarningLevel {
	Hint,
	Warning,
	Error
}

class StaticAnalysisWarning {
	int Line;
	int Column;
	StaticAnalysisWarningLevel Level;
	string Text;
}

class StaticAnalysisResult {
	StaticAnalysisWarning[] Warnings;
	string CompilerErrors;
}

class DEscapeAnalysisEngine {
	private string sourceCode;

	this(string sourceCode) {
		this.sourceCode = sourceCode;
	}

	StaticAnalysisResult Analyze() { 
		StaticAnalysisResult result = new StaticAnalysisResult();

		DSourceCodeInstrumenter dSourceCodeInstrumenter = new DSourceCodeInstrumenter(sourceCode);
		string instrumentedSourceCode = dSourceCodeInstrumenter.Instrument();

		Subprocess subprocess = new Subprocess();
		ProcessResult processResult = subprocess.Run("./CodeToCompilerRepresentation", sourceCode);

		if (processResult.StderrContent != "") {
			result.CompilerErrors = processResult.StderrContent;
			return result;
		}

		return result;
	}

}
