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
			subprocessResult.StdoutContent ~= (subprocessResult.StdoutContent != "") ? "\n" ~ line.idup : line.idup;
		foreach (line; processPipes.stderr.byLine)
			subprocessResult.StderrContent ~= (subprocessResult.StderrContent != "") ? "\n" ~ line.idup : line.idup;
		
		return subprocessResult;
	}
	
}
