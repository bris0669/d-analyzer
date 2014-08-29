import ActionType;
import Subprocess;
import std.process;
import std.stdio;
import std.conv;
import std.file;

class ActionDispatcher {
	private string sourceCode;
	private ActionType actionType;

	this(ActionType actionType, string sourceCode) {
		this.actionType = actionType;
		this.sourceCode = sourceCode;
	}

	string PerformAction() {
		string result;
		if (ActionType.ActionType.DCompilerRepresentation == actionType)
			result = PerformDCompilerRepresentation();
		return result;
	}

	string PerformDCompilerRepresentation() {
		string result;

		std.file.chdir("../../bin");
		
		Subprocess subprocess = new Subprocess();
		ProcessResult processResult = subprocess.Run("./CodeToCompilerRepresentation", sourceCode);

		if (processResult.StderrContent != "") {
			result = processResult.StderrContent;
			return result;
		}
		result = processResult.StdoutContent;
		return result;
	}

}
