<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%!
	String[] name={"Java","JSP","Android","Struts"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<% for(int i=0;i<name.length;i++) { %>
		<tr>
			<td><%=i %></td>
			<td><%=name[i] %></td>
		</tr>
		<% } %>
	</table>
</body>
</html>