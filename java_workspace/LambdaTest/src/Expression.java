
public class Expression {
	public static void main(String[] args) {
		A a = new Achild();
		a.method1();
		// Anonymous class
		A a1 = new A() {
			@Override
			public void method1() {
				System.out.println("method1() Overriding(Anonymous class)");
			}
		};
		a1.method1();
		// lambda expression
		A a2 = () -> {System.out.println("method1() Overriding(lambda expression)");};
		a2.method1();
	}
}

interface A {
	void method1();
}

interface B {
	void method2(int a);
}

interface C {
	int method3();
}

interface D {
	double method4();
}

class Achild implements A {
	@Override
	public void method1() {
		System.out.println("method1() Overriding");
	}
}