package abc;

public class A {
	public int a;
	protected int b;
	int c;
	private int d;
	void abc() {
		this.a=1;
		this.b=2;
		this.c=3;
		this.d=4;
	}
	public void print() {
		System.out.print(a+" "+b+" "+c+" "+d+"\n");
	}
}