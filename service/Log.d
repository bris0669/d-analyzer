string logBuffer;

void LogInfo(string text) {
	logBuffer ~= text ~ "\n";
}

string GetLogBuffer() {
	return logBuffer;
}
