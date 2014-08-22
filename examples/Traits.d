// Traits:
// auto b = [ __traits(allMembers, D) ];
//  __traits( classInstanceSize, B ); //__traits( classInstanceSize, B!int ); 

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
	A a = new A();

	static auto new12123 = __traits(classInstanceSize, A);
	writeln(new12123);
	static auto newmemb1232 = [__traits(allMembers, A)];
  writeln(newmemb1232);
	//
	delete a;

	A a1 = cast(A)new B(); 
	static auto new1234321 = __traits(classInstanceSize, B);
	writeln(new1234321);
	static auto newmemb3232 = [__traits(allMembers, B)];
	writeln(newmemb3232);
	static auto newmemb2232 = [__traits(allMembers, typeof(a1))];
  writeln(newmemb2232);
	static s234245 = fullyQualifiedName!(typeof(a1));
	writeln(s234245);
	//
	//delete a; static i121212 = __traits( classInstanceSize, typeof(a) ); //a.sizeof;
}
