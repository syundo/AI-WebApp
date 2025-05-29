package Exercize07;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Exercize07 {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		
		HashMap<String, ArrayList<Student>> computerScience = new HashMap<>(); // 컴퓨터공학
		ArrayList<Student> studentList = new ArrayList<Student>();
		
		System.out.println("학생 3명 추가");
		System.out.println("(입력 종료는 'quit'입력)");
		for(int i=0;i<3;i++) {
			System.out.print("이름: ");
			String name = scan.nextLine().trim();
			if (name.equalsIgnoreCase("quit")) {
                System.out.println("입력 종료");
                break;
            }
			studentList.add(new Student(name));
		}
		computerScience.put("컴퓨터공학", studentList);
		
		System.out.println("컴퓨터공학과 학생 목록");
		for(String major:computerScience.keySet()) {
//			System.out.println(major);
			for(Student s:computerScience.get(major)) {
				s.who();
			}
		}
	
		scan.close();
	}
}