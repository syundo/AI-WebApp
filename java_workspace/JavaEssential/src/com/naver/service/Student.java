package com.naver.service;

public class Student extends Person {
	public String department;
	void study() {
		System.out.println("공부를 합니다.");
	}
	@Override
	public void sleep() {
		System.out.println("잠을 적게 잡니다.");
	}
	public Student() {}
	public Student(String name, String department) {
//		this.name=name;
		super(name);
		this.department=department;
	}
}