<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Core Tag2</h2>
	<c:if test="${param.id!=null}">
		<b>${param.id}</b>
	</c:if>
	<c:if test="${param.id==''}">
		<b>Guest</b>
	</c:if>
	<c:choose>
		<c:when test="${param.color=='yellow'}">
			<c:set var="c" value="노랑"/>
		</c:when>
		<c:when test="${param.color=='blue'}">
			<c:set var="c" value="파랑"/>
		</c:when>
		<c:when test="${param.color=='orange'}">
			<c:set var="c" value="주황"/>
		</c:when>
		<c:when test="${param.color=='green'}">
			<c:set var="c" value="초록"/>
		</c:when>
		<c:otherwise>
			<c:set var="c" value="알수없음"/>
		</c:otherwise>
	</c:choose>
	님이 좋아하는 색상은 <span style="color:${param.color}">${c}</span>입니다.<br>
	${param.id}님이 좋아하는 색상은 <span style="color:${param.color}"><c:out value="${c}"/></span>입니다.
</body>
</html>