
public class RefOfClassConstructor {

	public static void main(String[] args) {
		// Anonymous class
		A1 a1 = new A1() {
			@Override
			public B1 abc() {
				return new B1();
			}
		};
		a1.abc();
		// lambda expression
		A1 a2 = () -> new B1();
		a2.abc();
		// reference of constructor
		A1 a3 = B1::new;
		a3.abc();
	}
}

interface A1 {
	B1 abc();
}

class B1 {
	B1() {
		System.out.println("first constructor");
	}
	B1(int i) {
		System.out.println("second constructor");
	}
}