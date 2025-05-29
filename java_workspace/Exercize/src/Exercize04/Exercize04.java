package Exercize04;

import java.util.Scanner;

public class Exercize04 {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		System.out.print("면적을 구할 원의 반지름: ");
		int r = scan.nextInt();
		Circle c = new Circle(r);
		c.print();
		while(true){
			System.out.print("이름: ");
			String name = scan.next();
			if(name.equals("quit")) {
				System.out.print("종료");
				break;
			}
			System.out.print("국어: ");
			int korean = scan.nextInt();
			System.out.print("영어: ");
			int english = scan.nextInt();
			System.out.print("수학: ");
			int math = scan.nextInt();
			StudentScore sc = new StudentScore(name, korean, english, math);
			sc.print();
		}
		scan.close();
	}
}