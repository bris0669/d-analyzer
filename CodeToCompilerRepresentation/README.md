# CodeToCompilerRepresentation

For both D and C++ source code,
we need a way to convert the source code to the verbose output of the compiler.

## Command Line

./CodeToCompilerRepresentation -l[d|c] <<< "import std.stdio; void main() { writeln("Hello, world!"); }"