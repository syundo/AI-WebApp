<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>EL의 Empty</h2>
	parameter "name"의 값 존재 유무: <b>${empty param.name}</b>(요청이 없다면 true)<br>
	<a href="empty.jsp?name=hkd">"name"의 값이 있는 요청</a> || 
	<a href="empty.jsp">"name"의 값이 없는 요청</a>
</body>
</html>