import java.util.Scanner;

public class LoopTest {
	public static void main(String[] args) {
		Scanner s=new Scanner(System.in);
		for(int i=1; i<=10; i++) {
			System.out.println(i);
		}
		for(int i=10; i>=1; i--) {
			System.out.println(i);
		}
		for(;;) {
			System.out.print("점수 입력(0 입력 시 종료): ");
			while(!s.hasNextInt()) { // 정수이면 true
				System.out.println("정수를 올바르게 다시 입력: ");
				s.nextLine(); // 잘못 입력한 값을 문자열로 보고 소멸
			}
			int number=s.nextInt();
			if(number==0) {
				System.out.print("종료");
				break;
			}
			System.out.println(number);
		}
		// 이중 for문. 구구단
		for(int dan=2; dan<=9; dan++) {
			for(int num=1; num<=9; num++) {
				System.out.println(dan+"*"+num+"="+dan*num);
			}
		}
		// 옆으로 출력
		for(int num=1; num<=9; num++) {
			for(int dan=2; dan<=9; dan++) {
				System.out.print(dan+"*"+num+"="+dan*num+"\t");
			}
			System.out.print("\n");
		}
		// break label
		out:
		for(int i=0; i<10; i++) {
			for(int j=0; j<10; j++) {
				if(j==3) {
					break out;
				}
				System.out.println(i+", "+j);
			}
		}
		System.out.println("끝");
		// 전역변수를 활용한 다른 방법
		boolean flag=false;
		for(int i=0; i<10; i++) {
			for(int j=0; j<10; j++) {
				if(j==3) {
					flag=true;
					break;
				}
				System.out.println(i+", "+j);
			}
			if(flag) {
				break;
			}
		}
		System.out.println("끝");
		int z=0;
		while(z<=10) {
			z++;
			if(z%2==1) {
				continue;
			}
			System.out.println(z);
		}
		System.out.println("End");
		
		s.close();
	}
}