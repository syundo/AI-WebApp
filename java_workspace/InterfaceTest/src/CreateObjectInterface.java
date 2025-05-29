
public class CreateObjectInterface {
	public static void main(String[] args) {
		A b1 = new B();
		B b2 = new B();
		b1.abc();
		b2.xyz();
	}
}

interface A {
	static final int a = 3; // 상수
	abstract void abc(); // 추상메서드
	void xyz();
}

class B implements A {
	@Override
	public void abc() {
		System.out.println("abc() Overriding");
	}
	@Override
	public void xyz() {
		System.out.println("xyz() Overriding."+a);
	}
}