import ActionType;

class ActionDispatcher {
	private string sourceCode;
	private ActionType actionType;

	this(ActionType actionType, string sourceCode) {
		this.actionType = actionType;
		this.sourceCode = sourceCode;
	}

	string PerformAction() {
		string result = "";

		return result;
	}

}
