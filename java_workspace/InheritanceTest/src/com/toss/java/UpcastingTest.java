package com.toss.java;

public class UpcastingTest {
	static void paint(Shape p) {
		p.draw();
	}
	public static void main(String[] args) {
		Line line = new Line();
		paint(line);
		paint(new Rectangle());
		paint(new Triangle());
		paint(new Shape());
	}
}

class Shape {
	public void draw() {
		System.out.println("Shape");
	}
}

class Line extends Shape {
	@Override
	public void draw() {
		System.out.println("Line");
	}
}

class Rectangle extends Shape {
	@Override
	public void draw() {
		System.out.println("Rectangle");
	}
}

class Triangle extends Shape {
	@Override
	public void draw() {
		System.out.println("Triangle");
	}
}