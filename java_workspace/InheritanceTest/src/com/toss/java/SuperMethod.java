package com.toss.java;

public class SuperMethod {
	public static void main(String[] args) {
		// C2 c2 = new C2();
		// C3 c3 = new C3();
	}
}

class C1 {
	C1() {
		System.out.println("C1 생성자");
	}
	C1(int a) {
		System.out.println("C1 생성자"+a);
	}
}

class C2 extends C1 {
	C2() {
		super(10);
		System.out.println("C2 생성자");
	}
}

class C3 extends C2 {
	C3() {
		System.out.println("C3 생성자");
	}
}