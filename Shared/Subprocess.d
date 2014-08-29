import std.process;
import ProcessResult;

class Subprocess {

	ProcessResult Run(string commandLine, string stdinContent) {
		ProcessResult result = new ProcessResult();

		ProcessPipes processPipes = pipeProcess(commandLine);
		scope(exit) wait(processPipes.pid);

		processPipes.stdin.write(stdinContent);
		processPipes.stdin.close;

		foreach (line; processPipes.stdout.byLine)
			result.StdoutContent ~= (result.StdoutContent != "") ? "\n" ~ line.idup : line.idup;
		foreach (line; processPipes.stderr.byLine)
			result.StderrContent ~= (result.StderrContent != "") ? "\n" ~ line.idup : line.idup;
		
		return result;
	}
	
}
