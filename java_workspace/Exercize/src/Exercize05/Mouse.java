package Exercize05;

public class Mouse {
	int buttonCount; // 버튼 수
	int xPosition;    // 마우스 x 좌표
    int yPosition;    // 마우스 y 좌표
	Mouse() {
		this.buttonCount = 1;  // 일반적인 마우스는 3개의 버튼 (왼쪽, 오른쪽)
        this.xPosition = 0;    // 초기 x 위치
        this.yPosition = 0;    // 초기 y 위치
	}
	public Mouse(int buttonCount) {
		this();
        this.buttonCount = buttonCount;
    }
	public void click() {
    System.out.println("클릭!");
    }
	public void doubleClick() {
        System.out.println("더블 클릭!");
    }
	public void longClick() {
        System.out.println("클릭 중...");
    }
	void mouseMove(int x, int y) {
		this.xPosition = x;
        this.yPosition = y;
        System.out.println("(" + x + ", " + y + ")로 이동!");
	}
	public void Position() {
        System.out.println("현재 마우스 위치: (" + xPosition + ", " + yPosition + ")");
    }
	public void info() {
        System.out.println("버튼 수: " + buttonCount);
        System.out.println("현재 마우스 위치: (" + xPosition + ", " + yPosition + ")");
        System.out.println("사용 가능 기능: click(), doubleClick(), longClick(), mouseMove(int x, int y)");
    }
}