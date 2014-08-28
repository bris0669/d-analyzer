import dunit;
import DSourceCodeInstrumenter;
import AdditionalAssertions;

class DSourceCodeInstrumenterTest {
	mixin UnitTest;

	@Test
	public void NoAllocationOrDeallocation_Success() {
		const string sourceCode = `import std.io; void main() { writeln("Hello"); }
`;
		auto dSourceCodeInstrumenter = new DSourceCodeInstrumenter(sourceCode);

		assertStringContains(sourceCode, dSourceCodeInstrumenter.Instrument());
	}

	@Test
	public void Allocation_Success() {
		const string sourceCode = `import std.io; void main() { Bar bar = new Bar(); }
`;
		auto dSourceCodeInstrumenter = new DSourceCodeInstrumenter(sourceCode);

		string instrumentedSourceCode = dSourceCodeInstrumenter.Instrument();

		assertStringContains("new Bar(); static new_Bar", instrumentedSourceCode);
		assertStringContains("; alias TransitiveBaseTypeTuple!", instrumentedSourceCode);
	}

	@Test
	public void Deallocation_Success() {
		const string sourceCode = `import std.io; void main() { Bar bar = new Bar(); delete bar; }
`;
		auto dSourceCodeInstrumenter = new DSourceCodeInstrumenter(sourceCode);

		string instrumentedSourceCode = dSourceCodeInstrumenter.Instrument();

		assertStringContains("delete bar; static auto delete_", instrumentedSourceCode);
		assertStringContains(" = fullyQualifiedName!(typeof(bar));", instrumentedSourceCode);
	}
}
