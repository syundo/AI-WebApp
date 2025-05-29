<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("J",31);
	pageContext.setAttribute("S",8);
	pageContext.setAttribute("P",22);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>EL의 Operators</h2>
	<b>J = ${J}, S = ${S}, P = ${P}</b><br>
	<b>J = ${pageScope.J}, S = ${pageScope.S}, P = ${pageScope.P}</b><br>
	{J % S} : ${J mod S}<br>
	${(10*10) eq 100}
</body>
</html>