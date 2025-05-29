package Exercize05;

class WheelMouse extends Mouse {
	WheelMouse() {
		super();
		this.buttonCount = 2;
		this.xPosition = 0;
		this.yPosition = 0;
	}
	@Override
	public void click() {
		System.out.print("좌측 버튼 ");
	    super.click();
    }
    // 우측 클릭
    public void rightClick() {
        System.out.print("우측 버튼 ");
        super.click();
    }
    @Override
	public void doubleClick() {
		System.out.print("좌측 버튼 ");
        super.doubleClick();
    }
	@Override
	public void longClick() {
		System.out.print("좌측 버튼 ");
        super.longClick();
    }
	@Override
	void mouseMove(int x, int y) {
		super.mouseMove(x, y);
	}
	public void scrollUp() {
        System.out.println("스크롤 업!");
    }

    public void scrollDown() {
        System.out.println("스크롤 다운!");
    }
    @Override
    public void info() {
    	super.info();  // 부모 클래스의 info() 호출
    	System.out.println("추가 기능: rightClick(), scrollUp(), scrollDown()");
        System.out.println("\t ※ Click관련 기능은 전부 좌측 버튼에서 사용 가능");
        System.out.println("\t   우측 버튼은 추가된 기능만 사용 가능");
    }
}