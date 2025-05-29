import java.util.Scanner;

public class TryCatchFinally {
	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		try {
			System.out.print("분자: ");
			int num1 = s.nextInt();
			System.out.print("분모: ");
			int num2 = s.nextInt();
			System.out.println(num1/num2);
		}
		catch(Exception e) {
			e.printStackTrace(); // debugging 용
			System.out.println(e.getMessage());
			System.out.println("에러 발생");
		}
		finally {
			s.close();
		}
		System.out.println("실행?");
	}
}