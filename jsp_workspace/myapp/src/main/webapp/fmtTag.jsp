<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL Formatting Tags</title>
</head>
<body>
	<h2>fmt Tag - formatNumber, formatDate</h2>
	<c:set var="num" value="123456879.567"></c:set>
	달러: <fmt:formatNumber value="${num}" type="currency" currencySymbol="$"/><br>
	패턴: <fmt:formatNumber value="${num}" pattern="#,###,###,###.000"/><br>
	<c:set var="dayTime" value="<%=new Date()%>"/>
	날짜:<br>	
	<fmt:formatDate value="${dayTime}" pattern="yyyy-mm-dd"/><br>
	<fmt:formatDate value="${dayTime}" pattern="yyyy년 mm월 dd일"/><br>
	<fmt:formatDate value="${dayTime}" pattern="z a h:m:s"/><br>
</body>
</html>