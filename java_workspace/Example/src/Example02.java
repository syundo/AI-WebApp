import java.util.Scanner;

public class Example02 {
	public static void main(String[] args) {
		// scanner
		Scanner scan=new Scanner(System.in);
		int snum;
		String sname;
		String smajor;
        while (true) {
        	System.out.println("학번, 이름, 학과를 엔터로 구분하여 입력(종료는 exit):");
            String input = scan.nextLine(); // 한 줄 입력 받기
            if (input.equals("exit")) {
            	System.out.println("종료");
            	break;
            }
            snum = Integer.parseInt(input);
            sname = scan.next();
            smajor = scan.next();
            scan.nextLine(); // 개행 문자 제거
            System.out.println(snum+", "+sname+", "+smajor);
        }
		// 트리 별 찍기
		for(int i=0; i<5; i++) {
			for(int j=0; j<5; j++) {
				if(j<(4-i)) {
					System.out.print(" "); // 4-3-2-1-0
				}
				else {
					System.out.print("*"); // 1-2-3-4-5
				}
			}
			System.out.print("\n");
		}
		// 누운 트리 별 찍기
		for(int i=0; i<9; i++) {
			for(int j=0; j<5; j++) {
				if(i<5) {
					if(j>i) {
						System.out.print(" ");
					}
					else {
						System.out.print("*"); // 1-2-3-4-5
					}
				}
				else {
					if(j>(8-i)) {
						System.out.print(" ");
					}
					else {
						System.out.print("*"); // 4-3-2-1
					}
				}
			}
			System.out.print("\n");
		}
		scan.close();
	}
}