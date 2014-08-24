import dunit;
import DSourceCodeInstrumenter;

class DSourceCodeInstrumenterTest {
	mixin UnitTest;

	@Test
	public void NoAllocationOrDeallocation_Success() {
		const string sourceCode = `import std.io; void main() { writeln("Hello"); } `;
		auto dSourceCodeInstrumenter = new DSourceCodeInstrumenter(sourceCode);

		assertEquals(sourceCode, dSourceCodeInstrumenter.Instrument());
	}

	@Test
	public void Allocation_Success() {
		const string sourceCode = `import std.io; void main() { Bar bar = new Bar(); } `;
		auto dSourceCodeInstrumenter = new DSourceCodeInstrumenter(sourceCode);

		string instrumentedSourceCode = dSourceCodeInstrumenter.Instrument();
		assertEquals(sourceCode, instrumentedSourceCode);
	}

}
