package Exercize06;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Exercize06 {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		
		HashMap<String, ArrayList<Book>> bookList = new HashMap<>();
		ArrayList<Book> philosophyBooks = new ArrayList<Book>();	  // 철학
		ArrayList<Book> languageBooks = new ArrayList<Book>();		  // 언어
		ArrayList<Book> computerScienceBooks = new ArrayList<Book>(); // 컴퓨터공학
		
		System.out.println("책 목록 작성");
		System.out.println("(입력 종료는 'quit'입력)");
		while(true) {
			System.out.print("제목: ");
			String title = scan.nextLine().trim();
			if (title.equalsIgnoreCase("quit")) {
                System.out.println("입력 종료");
                break;
            }
			System.out.print("저자: ");
			String author = scan.nextLine().trim();
			System.out.print("출판사: ");
			String publisher = scan.nextLine().trim();
			System.out.print("가격: ");
			int price = Integer.parseInt(scan.nextLine().trim());
			
			System.out.print("해당 분야 지정(철학/언어/컴퓨터공학 중 택1): ");
			String sector = scan.nextLine().trim();
			if (sector.equalsIgnoreCase("철학")) {
			    philosophyBooks.add(new Book(title, author, publisher, price));
			} else if (sector.equalsIgnoreCase("언어")) {
			    languageBooks.add(new Book(title, author, publisher, price));
			} else if (sector.equalsIgnoreCase("컴퓨터공학")) {
			    computerScienceBooks.add(new Book(title, author, publisher, price));
			}
			else {
				System.out.println("저장 불가능");
			}
		}
		System.out.println("==================================================");
		bookList.put("철학", philosophyBooks);
		bookList.put("언어", languageBooks);
		bookList.put("컴퓨터공학", computerScienceBooks);
		System.out.println("저장된 책 목록");
		for(String sector:bookList.keySet()) {
			System.out.println(sector);
			for(Book b:bookList.get(sector)) {
				b.info();
			}
			System.out.println("----------------------------------------");
		}
		
		scan.close();
	}
}