#!/usr/bin/env sh

./DEscapeAnalysis <<EOF
import std.stdio;
import core.memory;

class A {
  string Name;
  int Count;
}

void main() {
  GC.disable();
  A a = new A();
  writeln("Hello, " ~ a.Name);
  delete a;
}
EOF
