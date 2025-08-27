<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="comcodeModify" method="post">
	    <input type="text" name="code_group_id" value="${code.code_group_id}" readonly><br>
	    <input type="text" name="group_name" value="${code.group_name}"><br>
	    <input type="text" name="code" value="${code.code}"><br>
	    <input type="text" name="code_name" value="${code.code_name}"><br>
	    <input type="text" name="description" value="${code.description}"><br>
	    
	    <input type="submit" value="수정">
	    <button type="button" onclick="location.href='comcodeRegist'">취소</button>
	    
	    
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
</body>
</html>