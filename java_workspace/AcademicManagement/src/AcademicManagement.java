import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;

public class AcademicManagement extends JFrame {
	JMenuBar mb; // 메뉴바
	JMenu studentMenu; // 학생관리 메뉴
	JMenuItem studentInfoMenuItem; // 학생정보 메뉴 아이템
	JMenu bookMenu; // 도서관리 메뉴
	JMenuItem bookInfoMenuItem; // 도서정보 메뉴
	JMenuItem bookRentMenuItem; // 대출현황 메뉴 아이템
	
	JPanel panel; // 메뉴별로 화면이 출력되는 패널
	
	public AcademicManagement() {
		this.setTitle("학사관리");
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		this.mb=new JMenuBar();
		
		this.studentMenu=new JMenu("학생관리");
		this.studentInfoMenuItem=new JMenuItem("학생정보");
		this.studentInfoMenuItem.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				panel.removeAll(); // 모든컴포넌트삭제
				panel.revalidate(); // 다시활성화
				panel.repaint(); // 다시그림
				panel.add(new StudentInfo()); // 학생정보패널을 생성.추가.
				panel.setLayout(null); // 레이아웃은 사용 안함		
			}});
		this.studentMenu.add(this.studentInfoMenuItem);
		this.mb.add(this.studentMenu);
		
		this.bookMenu=new JMenu("도서관리");
		this.bookInfoMenuItem=new JMenuItem("도서정보");
		this.bookInfoMenuItem.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				System.out.println("도서정보 클릭");
			}});
		this.bookMenu.add(this.bookInfoMenuItem);
		this.bookRentMenuItem=new JMenuItem("대출현황");
		this.bookRentMenuItem.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				System.out.println("대출현황 클릭");
			}});
		this.bookMenu.add(this.bookRentMenuItem);
		this.mb.add(this.bookMenu);
		
		this.setJMenuBar(mb);
		
		this.panel=new JPanel();
		this.add(this.panel);
		
		this.setSize(400,500);
		this.setVisible(true);
	}
	
	public static void main(String[] args) {
		new AcademicManagement();
	}
}