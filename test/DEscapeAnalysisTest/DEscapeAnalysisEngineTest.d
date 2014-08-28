import dunit;
import DEscapeAnalysisEngine;
import AdditionalAssertions;

class DEscapeAnalysisEngineTest {
	mixin UnitTest;

	@Test
	public void CompilerError_Success() {
		const string sourceCode = `import std.stdio;

void main() {
  writeln("
}`;
		auto dEscapeAnalysisEngine  = new DEscapeAnalysisEngine(sourceCode);

		StaticAnalysisResult staticAnalysisResult = dEscapeAnalysisEngine.Analyze();

		assertStringContains("Error: unterminated string constant starting at", staticAnalysisResult.CompilerErrors);
	}

	@Test
	public void MemoryLeak_Success() {
		const string sourceCode = `import std.stdio;
import core.memory;

class A {
  string Name;
  int Count;
}

void main() {
  GC.disable();
  A a = new A();
  writeln("Hello, " ~ a.Name);
}`;
		auto dEscapeAnalysisEngine  = new DEscapeAnalysisEngine(sourceCode);

		StaticAnalysisResult staticAnalysisResult = dEscapeAnalysisEngine.Analyze();

		assertEquals(1, staticAnalysisResult.Warnings.length);
	}

}
