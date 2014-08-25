import dunit;
import DSourceCodeInstrumenter;

import std.algorithm;
import std.traits;
import std.array;
import dunit.diff;
import std.conv;
import dunit.assertion;

/**
 * Asserts that the actual string contains the given substring.
 * Throws: AssertException otherwise
 */
void assertStringContains(T, U)(T substring, U actual, lazy string msg = null,
        string file = __FILE__,
        size_t line = __LINE__)
    if (isSomeString!T)
{
  	if (!find(actual, substring).empty)
        return;

    string header = (msg.empty) ? null : msg ~ "; ";

    fail(header ~ description(substring.to!string, actual.to!string),
            file, line);
}

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

		assertStringContains("new Bar(); static auto new_", instrumentedSourceCode);
		assertStringContains("typeid(TransitiveBaseTypeTuple!", instrumentedSourceCode);
	}

}
