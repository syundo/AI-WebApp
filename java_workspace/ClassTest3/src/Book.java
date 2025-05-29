
// 1. class 생성
public class Book {
	String title;
	String author;
	int price;
	
	Book() {
		this.title="미정";
		this.author="미정";
		this.price=0;
	}
	
	Book(String title, String author, int price) {
		this(title);
		this.author=author;
		this.price=price;
	}
	
	Book(String title) {
		this(); // Book() 호출
		this.title=title;
	}
	
	void showInfo() {
		System.out.println(this.title+", "+this.author+", "+this.price);
	}
}