import dunit;
import Subprocess;
import AdditionalAssertions;
import std.uuid;
import std.file;
import std.process;
import std.path;

class TemporaryShellScript {
	string Filename;

	this(string sourceCode) {
		Filename = buildPath(tempDir(), randomUUID().toString());
		std.file.write(Filename, sourceCode);
		executeShell("chmod 777 " ~ Filename);
	}

	~this() {
		if (exists(Filename))
			remove(Filename);
	}

}

class SubprocessTest {
	mixin UnitTest;

	@Test
	public void StdoutStderr_Success() {
		const string sourceCode = `#!/usr/bin/env bash
VALUE=$(cat)

echo "$VALUE"
echo "STDOUT"
echo "STDERR" > /dev/stderr
`;
		scope temporaryShellScript = new TemporaryShellScript(sourceCode);

		auto subprocess = new Subprocess();
		SubprocessResult subprocessResult = subprocess.Run(temporaryShellScript.Filename, "STDIN\n");

		assertEquals("STDIN\nSTDOUT", subprocessResult.StdoutContent);
		assertEquals("STDERR", subprocessResult.StderrContent);
	}

}
