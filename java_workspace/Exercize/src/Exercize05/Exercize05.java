package Exercize05;

import java.util.Scanner;

public class Exercize05 {
    public static void main(String[] args) {
    	Scanner scan = new Scanner(System.in);
    	AddressBook[] addressList = new AddressBook[15];
    	
    	System.out.println("실행 가능 프로그램 목록");
    	System.out.println("1. 전화번호부");
    	System.out.println("2. 마우스 제작");
    	System.out.println("(종료를 원하는 경우 'end' 입력)");
    	System.out.println();
    	while(true) {
    		System.out.print("원하는 프로그램 입력: ");
    		String program = scan.nextLine().trim();
    		if (program.equalsIgnoreCase("end")) {
    			scan.close();
    			break;
    		}
    		else if(program.equals("전화번호부") || program.equals("1")) {
    			manageAddressBook(scan,addressList);
    	        System.out.println();
    		}
    		else if(program.equals("마우스제작") || program.equals("2")) {
    			madeMouse();
    	        System.out.println();
    		}
    		else {
    			System.out.println("다시 입력");
    		}
    	}
    	System.out.println("시스템 종료");
    }

    public static void manageAddressBook(Scanner scan, AddressBook[] addressList) {
        int no = 0;

        System.out.print("전화번호부 입력 시작");
        System.out.println("(입력 종료를 원하는 경우 'quit' 입력)");
        while (no < 15) {
            System.out.print("이름: ");
            String name = scan.nextLine().trim();
            if (name.equalsIgnoreCase("quit")) {
                System.out.println("종료");
                break;
            }
            System.out.print("전화번호: ");
            String number = scan.nextLine().trim();
            if (number.equalsIgnoreCase("quit")) {
                System.out.println("종료");
                break;
            }
            System.out.print("이메일: ");
            String email = scan.nextLine().trim();
            if (email.equalsIgnoreCase("quit")) {
                System.out.println("입력 완료");
                break;
            }
            addressList[no] = new AddressBook(no + 1, name, number, email);
            no++;
        }
        if (no == 15) {
            System.out.println("추가 입력 불가");
        }

        System.out.print("입력된 전화번호부 내용 확인(Y/N): ");
        String print = scan.nextLine().trim();
        if (print.equalsIgnoreCase("y")) {
            if (no == 0) {
                System.out.println("비어있음");
            } else {
                for (int i = 0; i < no; i++) {
                    addressList[i].print();
                }
            }
        }
        System.out.println("전화번호부 프로그램 종료");
    }
    public static void madeMouse() {
    	System.out.println("마우스 제작 결과");
    	Mouse m = new Mouse();
    	System.out.println("마우스");
    	m.info();
    	System.out.println("---------------------------------------------------------------------------");
    	System.out.println("휠마우스");
    	WheelMouse wm = new WheelMouse();
    	wm.info();
    	System.out.println("---------------------------------------------------------------------------");
    	MagicMouse mm = new MagicMouse();
    	System.out.println("매직마우스");
    	mm.mouseMove(500, 300);
    	mm.Position();
    	mm.info();
    }
}