<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection con;
	
	try{
		Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "hkd", "1234");
		System.out.println("Success");
	}
	catch(SQLException ex){ System.out.println("SQLException" + ex);}
	catch(Exception ex){ System.out.println("Exception:" + ex);}
%>
</body>
</html>