import java.awt.FlowLayout;
import java.awt.TextField;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;

public class IDDialog extends JDialog{
	TextField idField=new TextField(10);
	JButton okButton=new JButton("OK");
	String id;
	
	public IDDialog(JFrame frame,String title) {
		super(frame,title,true);//모달
		this.setLayout(new FlowLayout());
		this.add(idField);
		this.add(okButton);
		this.setSize(300, 200);
	}
}