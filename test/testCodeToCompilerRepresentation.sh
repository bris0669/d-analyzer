#!/usr/bin/env sh

../bin/CodeToCompilerRepresentation --lang=D <<EOF
import std.stdio;

void main() {
    writeln("Hello, world!");
}
EOF

../bin/CodeToCompilerRepresentation --lang=CPP <<EOF
#include <iostream>

int main() {
    std::cout << "Hello, world!" << std::endl;
}
EOF
