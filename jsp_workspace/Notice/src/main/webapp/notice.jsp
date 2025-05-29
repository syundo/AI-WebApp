<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   /*  boolean showNotice = true; // 공지사항 출력여부를 체크하기 위한 flag

    // 쿠키 체크
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("noticeHidden".equals(cookie.getName())) {
                showNotice = false;
                break;
            }
        }
    } */
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <script>
/*
		function closeNotice() {
            if (document.getElementById("hideToday").checked) {
                // 쿠키 생성 (1일 유효)
                let date = new Date();
                date.setTime(date.getTime() + (24 * 60 * 60 * 1000)); // 1일. 쿠키보존기간
                // 쿠키명은 noticeHidden. true값을 저장. 적용되는 경로는 '/'. root directory이하 모든 경로.
                document.cookie = "noticeHidden=true; path=/; expires=" + date.toUTCString();
            }

            // 공지사항 영역 숨김
            document.getElementById("noticeBox").style.display = "none";
        } 
*/
        
        function closeNotice() {
            if (document.getElementById("hideToday").checked) {
            	
            	//Ajax처리
            	fetch("notice.do", {
            		  method: "POST"            		 
            		})
            		.then((result) => console.log(result));
            }

            // 공지사항 영역 숨김
            document.getElementById("noticeBox").style.display = "none";
        }
    </script>
</head>
<body>

<%-- 

<% if (showNotice) { %>
    <div id="noticeBox" style="background-color: #fffae6; padding: 15px; border: 1px solid #ccc; margin-bottom: 20px;">
        <strong>📢 공지사항:</strong> 새로운 업데이트가 적용되었습니다.<br><br>
        <input type="checkbox" id="hideToday"> 오늘 하루 이 창을 다시 보지 않음
        <button onclick="closeNotice()">닫기</button>
    </div>
<% } %>

 --%>
<c:if test="${showNotice==true}">
    <div id="noticeBox" style="background-color: #fffae6; padding: 15px; border: 1px solid #ccc; margin-bottom: 20px;">
        <strong>📢 공지사항:</strong> 새로운 업데이트가 적용되었습니다.<br><br>
        <input type="checkbox" id="hideToday"> 오늘 하루 이 창을 다시 보지 않음
        <button onclick="closeNotice()">닫기</button>
    </div>
</c:if>

<h2>메인 콘텐츠</h2>
<p>여기 메인 페이지 내용이 들어갑니다.</p>

</body>
</html>
