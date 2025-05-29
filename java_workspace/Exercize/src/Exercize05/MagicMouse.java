package Exercize05;

public class MagicMouse extends Mouse {
	MagicMouse() {
		super();
		this.buttonCount = 2;
		this.xPosition = 0;
		this.yPosition = 0;
	}
	public void rightClick() {
        System.out.print("우측 버튼 ");
        super.click();
    }
	public void Expantion() {
        System.out.println("확대!");
    }
    public void Reduction() {
        System.out.println("축소!");
    }
	public void Up() {
        System.out.println("스크롤 업!");
    }
    public void Down() {
        System.out.println("스크롤 다운!");
    }
    public void TurnThePage() {
        System.out.println("페이지 넘기기!");
    }
	@Override
    public void info() {
    	super.info();  // 부모 클래스의 info() 호출
    	System.out.println("추가 기능: rightClick(), Expantion(), Reduction(), Up(), Down(), TurnThePage()");
        System.out.println("\t ※ 우측 클릭을 제외한 기능들은 터치 관련 기능");
    }
}