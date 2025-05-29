package Exercize07;

public class Human {
	String name;
	Human() {}
	Human(String name) {
		this.name = name;
	}
	void speak() {
		System.out.println("말하기");
	}
	void eat() {
		System.out.println("먹기");
	}
	void walk() {
		System.out.println("걷기");
	}
	void sleep() {
		System.out.println("잠자기");
	}
	void who() {
		System.out.println(name);
	}
}