<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>header</h2>
	호스트명 : <b>${header.host}</b><br>
 	사용브라우저 : <b> ${header["user-agent"]}</b><br>
 	사용언어 : <b> ${header["accept-language"]}</b><br>
</body>
</html>