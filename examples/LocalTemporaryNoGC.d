import std.stdio;
import core.memory;

class A {
	int x;
	float f;
}

void main() {
	GC.disable();
	A a = new A();
	//
	delete a;
}
