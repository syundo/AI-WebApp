
public class StaticInitialBlock {
	public static void main(String[] args) {
		System.out.println(A.b); // 클래스명.필드명 형식
		
		A a = new A();
		System.out.println(a.b);
		
		a.b = 20;
		System.out.println(A.b);
		System.out.println(a.b);
	}
}

class A {
	int a;
	static int b = 10;
	A() {
		this.a = 3;
	}
}