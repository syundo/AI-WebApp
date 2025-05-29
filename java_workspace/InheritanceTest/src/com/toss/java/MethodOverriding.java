package com.toss.java;

public class MethodOverriding {
	public static void main(String[] args) {
		A aa = new A();
		aa.print();
		B bb = new B();
		bb.print();
		// upcasting 시 override된 메서드를 호출하면
		// 자식클래스가 override한 메서드가 호출
		A ab = new B();
		ab.print();
		// 클래스의 배열
		Animal[] animals = new Animal[3];
		animals[0] = new Bird();
		animals[1] = new Cat();
		animals[2] = new Dog();
		for(Animal animal:animals) {
			animal.cry();
		}
		Animal[] animals2 = new Animal[] {new Bird(),new Cat(),new Dog()};
		for(Animal animal:animals2) {
			animal.cry();
		}
	}
}

class A {
	void print() {
		System.out.println("A 클래스");
	}
}
class B extends A{
	@Override
	void print() {
		System.out.println("B 클래스");
	}
}

class Animal {
	void cry() {
	}
}
class Bird extends Animal {
	@Override
	void cry() {
		System.out.println("짹짹");
	}
}
class Cat extends Animal {
	@Override
	void cry() {
		System.out.println("야용");
	}
}
class Dog extends Animal {
	@Override
	void cry() {
		System.out.println("멍멍");
	}
}