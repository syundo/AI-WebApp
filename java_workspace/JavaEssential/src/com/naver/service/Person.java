package com.naver.service;

public class Person {
	public String name="아무개";
	public void sleep() {
		System.out.println("잠을 잡니다.");
	}
	public Person() {}
	public Person(String name) {
		this.name=name;
	}
}