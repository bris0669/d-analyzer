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
