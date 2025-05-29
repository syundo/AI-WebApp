
class A {
	int m1,m2,m3,m4;
	A() {
		this.m1=1;
		this.m2=2;
		this.m3=3;
		this.m4=4;
	}
	A(int a) {
		this();
		this.m1=a;
	}
	A(int a, int b) {
		this(a);
		this.m2=b;
	}
	void print() {
		System.out.print(m1+" ");
		System.out.print(m2+" ");
		System.out.print(m3+" ");
		System.out.print(m4);
		System.out.println();
	}
}
public class ThisMethod {
	public static void main(String[] args) {
		A a = new A();
		System.out.println(a.m1);
		a.m1 = 10;
		System.out.println(a.m1);
		A a1 = new A();
		A a2 = new A(10);
		A a3 = new A(10,20);
		a1.print();
		a2.print();
		a3.print();
	}
}