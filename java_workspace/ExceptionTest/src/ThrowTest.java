import java.util.Scanner;

public class ThrowTest {

	public static void main(String[] args) throws Exception {
		Scanner s = new Scanner(System.in);
		A a = new A();
		System.out.print("분자: ");
		a.num1 = s.nextInt();
		System.out.print("분모: ");
		a.num2 = s.nextInt();
		try {			
			System.out.print(a.divide());
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("실행?");
		s.close();
	}
}

class A {
	int num1;
	int num2;
	
	int divide() throws Exception {
		return this.num1/this.num2;
	}
}