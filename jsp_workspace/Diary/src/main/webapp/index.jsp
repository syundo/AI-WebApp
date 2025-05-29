<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일기장</title>
</head>
<body>
	
	<h2>그동안 작성한 일기 모음</h2>
	<!-- 목록 테이블 -->
    <table border="1" width="90%">
        <tr>
            <th width="10%">번호</th>
            <th width="*">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
            <th width="8%">첨부</th>
        </tr>
		<c:choose>    
		    <c:when test="${ empty boardLists }">  <!-- 게시물이 없을 때 -->
		        <tr>
		            <td colspan="6" align="center">
		                등록된 일기가 없음^^*
		            </td>
		        </tr>
		    </c:when>
		    <c:otherwise>  <!-- 게시물이 있을 때 -->
		        <c:forEach items="${ boardLists }" var="row" varStatus="loop">    
		        <tr align="center">
		            <td>  <!-- 번호 -->
		                ${ row.idx }   
		            </td>
		            <td align="left">  <!-- 제목(링크) -->
		                <a href="../mvcboard/view.do?idx=${ row.idx }">${ row.title }</a> 
		            </td> 
		            <td>${ row.name }</td>  <!-- 작성자 -->
		            <td>${ row.visitcount }</td>  <!-- 조회수 -->
		            <td>${ row.postdate }</td>  <!-- 작성일 -->
		            <td>  <!-- 첨부 파일 -->
		            <c:if test="${ not empty row.ofile }">
		                <a href="../mvcboard/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">[Down]</a>
		            </c:if>
		            </td>
		        </tr>
		        </c:forEach>        
		    </c:otherwise>    
		</c:choose>
    </table>
    <!-- 하단 메뉴(바로가기, 글쓰기) -->
    <table border="1" width="90%">
        <tr align="center">
            <td>
                ${ map.pagingImg }
            </td>
            <td width="100">
            	<a href="diary.do">일기쓰기</a>
            </td>
        </tr>
    </table>
</body>
</html>