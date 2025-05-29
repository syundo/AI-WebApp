package Exercize06;

public class Book {
	String title;
	String author;
	String publisher;
	int price;
	Book() {
		this.title = "제목 미정";
		this.author = "작자 미상";
		this.publisher = "알수없음";
		this.price = 0;
	}
	Book(String title, String author, String publisher, int price) {
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.price = price;
	}
	void info() {
		System.out.print("제 목: "+title);
		System.out.print("  \t저 자: "+author);
		System.out.print("\t출판사: "+publisher);
		System.out.println("\t가 격: "+price);
	}
}