import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

public class Haksa extends JFrame{
	// field. 메서드 입장에서 field는 전역변수 역할.
	JTextField txtId;
	JTextField txtName;
	JTextField txtDept;
	JTextField txtAddress;
	DefaultTableModel model;
	JTable table;
	// CRUD button
	JButton btnInsert; //등록 Create
	JButton btnSelect; //목록 Read
	JButton btnUpdate; //수정 Update
	JButton btnDelete; //삭제 Delete
	//search button
	JButton btnSearch;
	
	public Haksa() {
		this.setTitle("학사관리");
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		// Layout setting
		this.setLayout(new FlowLayout());
		
		this.add(new JLabel("학번"));
		this.txtId=new JTextField(15);
		this.add(this.txtId);
		
		this.btnSearch=new JButton("검색");
		this.btnSearch.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent a) {
				try {
					// oracle jdbc driver load
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kim","bluesky");
					System.out.println("연결완료");
					//statement 객체 생성
					Statement stmt=conn.createStatement();					
					//serch
					ResultSet rs=stmt.executeQuery("select * from student2 where id='"+txtId.getText()+"'");
					//JTable초기화
					model.setNumRows(0);// model의 행의수를 0으로 설정
					while(rs.next()) {
						String[] row=new String[3]; //행
						row[0]=rs.getString("id");
						row[1]=rs.getString("name");
						row[2]=rs.getString("dept");
						model.addRow(row); //모델에 추가
						txtId.setText(rs.getString("id"));
						txtName.setText(rs.getString("name"));
						txtDept.setText(rs.getString("dept"));
					}
					rs.close();
					stmt.close();
					conn.close();
				}catch(Exception e) { e.printStackTrace(); }
			}});
		this.add(this.btnSearch);
		
		this.add(new JLabel("이름"));
		this.txtName=new JTextField(20);
		this.add(this.txtName);
		
		this.add(new JLabel("학과"));
		this.txtDept=new JTextField(20);
		this.add(this.txtDept);
		
		this.add(new JLabel("주소"));
		this.txtAddress=new JTextField(20);
		this.add(this.txtAddress);
		
		// 테이블 생성
		String[] colname= {"학번","이름","학과"}; //컬럼명
		this.model=new DefaultTableModel(colname,0); //모델생성
		this.table=new JTable(model); //table에 model 바인딩
		this.table.setPreferredScrollableViewportSize(new Dimension(250,270)); //테이블크기
//		this.add(this.table); // scroll 없는 table
		JScrollPane sp=new JScrollPane(this.table);//스크롤생성
		this.table.addMouseListener(new MouseListener() {
			@Override
			public void mouseClicked(MouseEvent e) {
//				table=(JTable)e.getComponent();
				model=(DefaultTableModel)table.getModel();
				txtId.setText((String)model.getValueAt(table.getSelectedRow(), 0));
				txtName.setText((String)model.getValueAt(table.getSelectedRow(), 1));
				txtDept.setText((String)model.getValueAt(table.getSelectedRow(), 2));
			}
			@Override
			public void mousePressed(MouseEvent e) { }
			@Override
			public void mouseReleased(MouseEvent e) { }
			@Override
			public void mouseEntered(MouseEvent e) { }
			@Override
			public void mouseExited(MouseEvent e) { }
		});
		this.add(sp);
		
		this.btnInsert=new JButton("등록");
		this.btnInsert.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent a) {
				try {
					// oracle jdbc driver load
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kim","bluesky");
					System.out.println("연결완료");
					//statement 객체 생성
					Statement stmt=conn.createStatement();
					//insert
					stmt.executeUpdate("insert into student2 values('"+txtId.getText()+"','"+txtName.getText()+"','"+txtDept.getText()+"')");
					//select
					ResultSet rs=stmt.executeQuery("select * from student2");
					while(rs.next()) {
						System.out.println(rs.getString("id"));
						System.out.println(rs.getString("name"));
						System.out.println(rs.getString("dept"));
					}
					rs.close();
					stmt.close();
					conn.close();
					list();
					resetTextField();
				}catch(Exception e) { e.printStackTrace(); }
			}});
		this.add(this.btnInsert);
		
		this.btnUpdate=new JButton("수정");
		this.btnUpdate.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent a) {
				try {
					// oracle jdbc driver load
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kim","bluesky");
					System.out.println("연결완료");
					//statement 객체 생성
					Statement stmt=conn.createStatement();
					
					stmt.executeUpdate("update student2 set name='"+txtName.getText()+"',dept='"+txtDept.getText()+"' where id='"+txtId.getText()+"'");
					
					//select
					ResultSet rs=stmt.executeQuery("select * from student2");
					while(rs.next()) {
						System.out.println(rs.getString("id"));
						System.out.println(rs.getString("name"));
						System.out.println(rs.getString("dept"));
					}
					rs.close();
					stmt.close();
					conn.close();
					list();
					resetTextField();
				}catch(Exception e) { e.printStackTrace(); }
			}});
		this.add(this.btnUpdate);
		
		this.btnDelete=new JButton("삭제");
		this.btnDelete.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent a) {
				int result=JOptionPane.showConfirmDialog(null, "삭제하시겠습니까?", "confirm", JOptionPane.YES_NO_OPTION);
				// yes를 클릭했을 때
				if(result==JOptionPane.YES_OPTION) {
					try {
						// oracle jdbc driver load
						Class.forName("oracle.jdbc.driver.OracleDriver");
						Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kim","bluesky");
						System.out.println("연결완료");
						//statement 객체 생성
						Statement stmt=conn.createStatement();						
						//delete
						stmt.executeUpdate("delete from student2 where id='"+txtId.getText()+"'");
						//select
						ResultSet rs=stmt.executeQuery("select * from student2");
						while(rs.next()) {
							System.out.println(rs.getString("id"));
							System.out.println(rs.getString("name"));
							System.out.println(rs.getString("dept"));
						}
						rs.close();
						stmt.close();
						conn.close();
						list();
						resetTextField();
					}catch(Exception e) { e.printStackTrace(); }
				}
			}});
		this.add(this.btnDelete);
		
		this.btnSelect=new JButton("목록");
		this.btnSelect.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent a) {
				list();
			}});
		this.add(this.btnSelect);
		
		this.setSize(300,500);
		this.setVisible(true);
	}

	public void list() {
		Connection conn=null;
		try {
			// oracle jdbc driver load
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kim","bluesky");
			System.out.println("연결완료");
			//statement 객체 생성
			Statement stmt=conn.createStatement();					
			//select
			ResultSet rs=stmt.executeQuery("select * from student2");
			//JTable초기화
			model.setNumRows(0);// model의 행의수를 0으로 설정
			while(rs.next()) {
				String[] row=new String[3]; //행
				row[0]=rs.getString("id");
				row[1]=rs.getString("name");
				row[2]=rs.getString("dept");
				model.addRow(row); //모델에 추가
			}
			rs.close();
			stmt.close();
			conn.close();
		}catch(Exception e) { e.printStackTrace(); }
	}
	
	public void resetTextField() {
		this.txtId.setText("");
		this.txtName.setText("");
		this.txtDept.setText("");
	}
	
	public static void main(String[] args) {
		new Haksa();
	}
}