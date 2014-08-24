import dunit;

class HelloTest {
	mixin UnitTest;

	@Test
	public void Add_Success() {
		assertEquals(3, 1 + 2);
	}
}

mixin Main;
