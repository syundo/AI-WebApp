
public class UpcastingTest {
	static void paint(Shape p) {
		p.draw();
	}
	public static void main(String[] args) {
		Shape line = new Line(); // upcasting
		paint(line);
		Shape rectangle = new Rectangle();
		paint(rectangle);
		Shape triangle = new Triangle();
		paint(triangle);
	}
}

interface Shape {
	public void draw() ;
}

class Line implements Shape {
	@Override
	public void draw() {
		System.out.println("Line");
	}
}

class Rectangle implements Shape {
	@Override
	public void draw() {
		System.out.println("Rectangle");
	}
}

class Triangle implements Shape {
	@Override
	public void draw() {
		System.out.println("Triangle");
	}
}