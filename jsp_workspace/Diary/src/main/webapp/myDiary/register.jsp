<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
    function validateForm(form) {  // 필수 항목 입력 확인
        if (form.weather.value == "") {
            alert("날씨를 입력하세요.");
            form.weather.focus();
            return false;
        }
        if (form.title.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.content.value == "") {
            alert("내용을 입력하세요.");
            form.content.focus();
            return false;
        }
    }
</script>
</head>
<body>
<h2>일기장</h2>
<form name="diary" method="post" action="../diary.do">
	<table border="1" width="90%">
	    <tr>
	        <td>날씨</td>
	        <td>
	            <input type="text" name="weather" style="width:150px;" />
	        </td>
	    </tr>
	    <tr>
	        <td>제목</td>
	        <td>
	            <input type="text" name="title" style="width:95%;" />
	        </td>
	    </tr>
	    <tr>
	        <td>내용</td>
	        <td>
	            <textarea name="content" style="width:90%;height:100px;"></textarea>
	        </td>
	    </tr>
	    <tr>
	        <td colspan="2" align="center">
	            <button type="submit">일기 저장</button>
	            <button type="reset">새로 쓰기</button>
	        </td>
	    </tr>
	</table>    
</form>
</body>
</html>