package Exercize04;

public class StudentScore {
	String name;
	int korean;
	int english;
	int math;
	int result;
	
	StudentScore() {
		this.name="이름";
		this.korean=0;
		this.english=0;
		this.math=0;
		this.result=avg();
	}
	StudentScore(String name, int korean, int english, int math) {
		this.name=name;
		this.korean=korean;
		this.english=english;
		this.math=math;
		this.result=avg();
	}
	int avg() {
        return (korean + english + math)/3;
    }
	void print() {
		System.out.println(name+"의 평균은 "+result+"점 입니다.");
	}
}