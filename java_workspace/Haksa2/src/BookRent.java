import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class BookRent extends JPanel{
	DefaultTableModel model=null;
	JTable table=null;	
	
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	
	String query; //sql문
	
	public BookRent() {
		query="select s.id,s.name,b.title,br.rdate "
				+ " from student2 s,books b,bookrent br "
				+ " where s.id=br.id and b.no=br.bookno";
		setLayout(null);
		
		JLabel l_dept=new JLabel("학과");
	    l_dept.setBounds(10, 10, 30, 20);
	    add(l_dept);
	    
	    String[] dept={"전체","컴퓨터시스템","멀티미디어","컴퓨터공학"};
	    JComboBox cb_dept=new JComboBox(dept);
	    cb_dept.setBounds(45, 10, 100, 20);
	    add(cb_dept);
	    cb_dept.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				query="select s.id,s.name,b.title,br.rdate "
						+ " from student2 s,books b,bookrent br "
						+ " where s.id=br.id and b.no=br.bookno";
				
				JComboBox cb=(JComboBox)e.getSource(); //이벤트가 발생한 콤보박스 구하기
				//동적쿼리
				if(cb.getSelectedIndex()==0) {
					query+=" order by s.id";
				}else if(cb.getSelectedIndex()==1) {
					query+=" and s.dept='컴퓨터시스템' order by br.no";
				}else if(cb.getSelectedIndex()==2) {
					query+=" and s.dept='멀티미디어' order by br.no";
				}else if(cb.getSelectedIndex()==3) {
					query+=" and s.dept='컴퓨터공학' order by br.no";
				}
				list();
			}});
	    
	    String colName[]={"학번","이름","도서명","대출일"};
	    model=new DefaultTableModel(colName,0);
	    table = new JTable(model);
	    table.setPreferredScrollableViewportSize(new Dimension(470,200));
	    add(table);
	    JScrollPane sp=new JScrollPane(table);
	    sp.setBounds(10, 40, 460, 250);
	    add(sp);
	    
	    setSize(490, 400);//화면크기
	    setVisible(true);
	}
	
	public void list() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kim","bluesky");
			System.out.println("연결완료");
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			model.setNumRows(0);// model의 행의수를 0으로 설정
			while(rs.next()) {
				String[] row=new String[4]; //행
				row[0]=rs.getString("id");
				row[1]=rs.getString("name");
				row[2]=rs.getString("title");
				row[3]=rs.getString("rdate");
				model.addRow(row); //모델에 추가
			}
		}catch(Exception e1) {
			e1.printStackTrace();
		}finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}