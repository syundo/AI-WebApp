package Exercize04;

public class Circle {
	int r;
	double result;
	Circle() {
		this.r=10;
		this.result=circleResult();
	}
	Circle(int r) {
		this.r=r;
		this.result=circleResult();
	}
	double circleResult() {
		return (this.r*this.r*Math.PI);
	}
	void print() {
		System.out.println(result);
	}
}