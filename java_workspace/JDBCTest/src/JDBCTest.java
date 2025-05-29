import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCTest {
	public static void main(String[] args) {
		try {
			// oracle jdbc driver load
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// Connection
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kim","bluesky");
			System.out.println("연결완료");
			// Statement 객체 생성
			Statement stmt = conn.createStatement();
			// insert
//			stmt.executeUpdate("INSERT INTO student2 VALUES('K202001','왕건','국문학과')");
			// update
//			stmt.executeUpdate("UPDATE student2 SET name='홍길돈' WHERE id='M202001'");
			// delete
//			stmt.executeUpdate("DELETE FROM student2 WHERE id='S202003'");
			// select
			ResultSet rs = stmt.executeQuery("SELECT * FROM student2");
			while(rs.next()) {
				System.out.println(rs.getString("id"));
				System.out.println(rs.getString("name"));
				System.out.println(rs.getString("dept"));
				System.out.println(rs.getString("dept"));
			}
			rs.close();
			stmt.close();
			conn.close();
		}
		catch(Exception e) { e.printStackTrace(); }
	}
}