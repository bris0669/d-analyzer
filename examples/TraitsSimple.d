// Traits:

import std.stdio;
import core.memory;
import std.traits;

class A {
	int x;
	float f;
	int a;
	int b;
	int c;
}

class B : A {
	int m;
	int n;
	float ff;
}

void main() {
	GC.disable();
	A a = new A(); static auto new_234245 = fullyQualifiedName!(A);
	delete a; static auto delete_134245 = fullyQualifiedName!(typeof(A));
}
