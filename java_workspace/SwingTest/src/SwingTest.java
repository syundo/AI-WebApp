import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;

public class SwingTest {
	public static void main(String[] args) {
		new MyFrame();
	}
}

class MyFrame extends JFrame{
	MyFrame(){
		setTitle("채팅");
		
		setLayout(new FlowLayout());
		
		// button
		JButton btn1 = new JButton("send");
		// event(use anonymous class)
		btn1.addActionListener(new ActionListener() {
			// click the button 하면 action event 발생
			// 그리고 ActionListener에 의해서 actionPerformed
			@Override
			public void actionPerformed(ActionEvent e) {
				System.out.println("Click");
			}
		});
		add(btn1);
		
		setSize(300,300);
		setVisible(true);
	}
}