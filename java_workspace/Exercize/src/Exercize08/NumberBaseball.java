package Exercize08;

import java.util.Scanner;

public class NumberBaseball {
	Scanner scan;
	byte first;
	byte second;
	byte third;
	byte s = 0;
	byte b = 0;
	boolean[] strike = {false,false,false};
	boolean[] ball   = {false,false,false};
	byte[] numbers   = new byte[3];
	
	NumberBaseball() {
		scan = new Scanner(System.in);
		s = 0;
		b = 0;
		this.first = (byte) (Math.random() * 9 + 1);
		do {
			this.second = (byte) (Math.random() * 9 + 1);
        } while (second == first);
		do {
			this.third = (byte) (Math.random() * 9 + 1);
        } while ((third == first) || (third == second));
	}
	
	void num() {
		System.out.print("첫번째 숫자: ");
		this.numbers[0] = scan.nextByte();
		System.out.print("두번째 숫자: ");
		this.numbers[1] = scan.nextByte();
		System.out.print("세번째 숫자: ");
		this.numbers[2] = scan.nextByte();
		// 초기화
		this.s = 0;
		this.b = 0;
		strike[0] = false;
		strike[1] = false;
		strike[2] = false;
		ball[0] = false;
		ball[1] = false;
		ball[2] = false;
	}
	
	void strike(byte x, byte y, byte z) {
		// 검사
		if(x==first)  { this.strike[0] = true; }
		if(y==second) { this.strike[1] = true; }
		if(z==third)  { this.strike[2] = true; }
		// s 개수 확인
		this.s = 0;
		for (boolean count : strike) {
		    if (count) {
		        this.s += 1;
		    }
		}
	}
	
	void ball(byte x, byte y, byte z) {
		// 검사
		if(x==second || x==third)  { this.ball[0] = true; }
		if(y==first  || y==third)  { this.ball[1] = true; }
		if(z==first  || z==second) { this.ball[2] = true; }
		// b 개수 확인
		this.b = 0;
		for (boolean count : ball) {
		    if (count) {
		        this.b += 1;
		    }
		}
	}
	void check(byte x, byte y, byte z) {	
			System.out.println("########정상 작동 확인########");
			System.out.println("랜덤 난수: "+first+""+second+""+third);
			System.out.println("입력 숫자: "+x+""+y+""+z);
			System.out.print("Strike : ");
			System.out.println(strike[0]+" "+strike[1]+" "+strike[2]);
			System.out.print("Ball   : ");
			System.out.println(ball[0]+" "+ball[1]+" "+ball[2]);
			System.out.println("###########################");
	}
	
	void game() {
		System.out.println("Game Start!");
		do {
			num(); // 숫자 입력 받기
			byte x = numbers[0];
			byte y = numbers[1];
			byte z = numbers[2];
			if(x==0 || y==0 || z==0) {break;}
			strike(x,y,z); // S 확인
			ball(x,y,z);   // B 확인
			System.out.println("B: "+b+"\t"+"S: "+s);
//			check(x,y,z); // 오류 점검용
		}while(s!=3);
		System.out.println("END");
		scan.close();
	}
}