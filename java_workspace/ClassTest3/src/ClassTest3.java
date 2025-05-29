
public class ClassTest3 {
	public static void main(String[] args) {
		// b는 reference 변수. b가 가리키는 곳에 Book 클래스의 instance 존재
		Book b = new Book(); // 2. instance 생성
		// 3. instance명.멤버명 형식으로 사용
		b.author = "홍길동";
		b.title = "홍길동전";
		b.price = 10000;
		b.showInfo();
		Book b1 = new Book();
		b1.showInfo();
		Book b2 = new Book("java의 기초", "이순신", 15000);
		b2.showInfo();
		Book b3 = new Book("객체지향");
		b3.showInfo();
	}
}