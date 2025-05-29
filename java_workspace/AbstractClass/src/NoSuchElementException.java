
public class NoSuchElementException {

	public static void main(String[] args) {
//		A a = new A(); // A는 instance 생성 불가
		A b = new B(); // upcasting
		b.abc();
	}
}

abstract class A {
	abstract void abc();
}
class B extends A {
	@Override
	void abc() {
		System.out.println("부모의 abc() Overriding");
	}
}