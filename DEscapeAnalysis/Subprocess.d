import std.process;

class SubprocessResult {
	int ExitStatus;
	string StdoutContent;
	string StderrContent;
}

class Subprocess {

	SubprocessResult Run(string commandLine, string stdinContent) {
		SubprocessResult subprocessResult = new SubprocessResult();

		ProcessPipes processPipes = pipeProcess(commandLine);
		scope(exit) wait(processPipes.pid);

		processPipes.stdin.write(stdinContent);
		processPipes.stdin.close;

		foreach (line; processPipes.stdout.byLine)
			subprocessResult.StdoutContent ~= line.idup;
		foreach (line; processPipes.stderr.byLine)
			subprocessResult.StderrContent ~= line.idup;
		
		return subprocessResult;
	}
	
	// SubprocessResult subprocessResult = subprocess.Run("./CodeToCompilerRepresentation", sourceCode);

	// writeln(subprocessResult.Stdout);
}
