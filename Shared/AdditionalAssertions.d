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
