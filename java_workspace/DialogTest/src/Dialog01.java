import java.awt.FlowLayout;
import java.awt.TextField;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

class MyDialog extends JDialog{
	private TextField tf=new TextField(10);
	private JButton okButton=new JButton("OK");
	
	public MyDialog(JFrame frame,String title) {
		super(frame,title,true);//모달
		this.setLayout(new FlowLayout());
		this.add(tf);
		this.add(okButton);
		this.setSize(300, 200);
	}
}

public class Dialog01 extends JFrame {
	private MyDialog dialog;

	public Dialog01() {
		this.setTitle("다이얼로그");
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setLayout(new FlowLayout());

		JButton btn1=new JButton("커스텀다이얼로그");
		this.add(btn1);

		dialog=new MyDialog(this,"Test Dialog");
		btn1.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				dialog.setVisible(true);
			}});

		JButton btn2=new JButton("Confirm다이얼로그");
		btn2.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				int result=JOptionPane.showConfirmDialog(null,"삭제하시겠습니까?","Confirm",JOptionPane.YES_NO_OPTION);
				if(result==JOptionPane.YES_OPTION) {
					//삭제처리
					System.out.println("삭제처리");
				}
			}});
		this.add(btn2);

		JButton btn3=new JButton("Message다이얼로그");
		btn3.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				JOptionPane.showMessageDialog(null, "ID를 입력하세요","알림",JOptionPane.INFORMATION_MESSAGE);
			}});
		this.add(btn3);
		
		this.setSize(500,500);
		this.setVisible(true);
	}

	public static void main(String[] args) {
		new Dialog01();
	}
}