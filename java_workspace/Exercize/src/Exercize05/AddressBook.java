package Exercize05;

public class AddressBook {
	int no;
	String name;
	String firstNumber;
	String secondNumber;
	String thirdNumber;
	String email;
	
	AddressBook() {
		this.no=0;
		this.name="알수없음";
		this.firstNumber="000";
		this.secondNumber="0000";
		this.thirdNumber="0000";
		this.email="unknown@email.com";
	}
	
	AddressBook(int no, String name, String number, String email) {
		this();
		String cleanedNumber = number.replaceAll("[^0-9]", ""); 

		this.no=no;
		this.name=name;
	    if (cleanedNumber.length() == 11) {
	        this.firstNumber = cleanedNumber.substring(0, 3);
	        this.secondNumber = cleanedNumber.substring(3, 7);
	        this.thirdNumber = cleanedNumber.substring(7, 11);
	    }
	    else if (cleanedNumber.length() == 10) { // 지역번호
	        this.firstNumber = cleanedNumber.substring(0, 2);
	        this.secondNumber = cleanedNumber.substring(2, 6);
	        this.thirdNumber = cleanedNumber.substring(6, 10);
	    }
	    else {
	    	System.out.println("잘못된 형식의 전화번호");
	    }
		this.email=email;
	}
	
	String number() {
	    return firstNumber + "-" + secondNumber + "-" + thirdNumber;
	}
	
	void print() {
        System.out.println(no + "." + name + "\t" + number() + "\t" + email);
    }
}