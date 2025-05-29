package Exercize07;

public class Student extends Human {
	Student() {}
	Student(String name) {
		this.name = name;
	}
	void study() {
		System.out.println("공부하기");
	}
}