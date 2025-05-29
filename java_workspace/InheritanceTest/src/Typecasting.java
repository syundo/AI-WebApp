
public class Typecasting {
	public static void main(String[] args) {
		A aa = new A();
		A ab = new B();
		System.out.println(aa instanceof A);
		System.out.println(ab instanceof A);
		System.out.println(aa instanceof B);
		System.out.println(ab instanceof B);
	}
}

class A {}
class B extends A{}