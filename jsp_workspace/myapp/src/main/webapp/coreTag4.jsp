<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>JSTL Core Tags</title>
</head>
<body >
	<h2>c Tag - import, url, param</h2>
	<hr>
	<c:import url="coreTag2.jsp">
		<c:param name="id" value="JSPStudy"/>
		<c:param name="color" value="orange"/>
	</c:import>
	<hr>
	<c:url var="url1" value="https://www.google.co.kr/search">
		<c:param name="q" value="JSPStudy"/>
		<c:param name="safe" value="off"/>
	</c:url>
	<a href="${url1}">JSPStudy 검색</a>
	<a href="https://www.google.co.kr/search?q=JSPStudy&safe=off">JSPStudy 검색</a>
</body>
</html>