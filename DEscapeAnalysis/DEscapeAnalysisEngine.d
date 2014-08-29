import DSourceCodeInstrumenter;
import Subprocess;
import std.file;
import DWarningsGenerator;

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
		//write("/tmp/int/instrumented.txt", instrumentedSourceCode);
		Subprocess subprocess = new Subprocess();
		ProcessResult processResult = subprocess.Run("./CodeToCompilerRepresentation", instrumentedSourceCode);

		if (processResult.StderrContent != "") {
			result.CompilerErrors = processResult.StderrContent;
			return result;
		}

		//write("/tmp/int/compout.txt", processResult.StdoutContent);
		DWarningsGenerator dWarningsGenerator = new DWarningsGenerator(instrumentedSourceCode, processResult.StdoutContent);
		result.Warnings ~= dWarningsGenerator.GenerateWarnings(); 

		return result;
	}

}
