<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Sign Up</h1>
<form action="${ctx }/login" method="post">
	<label for="username">Username:</label>
	<input type="text" id="username" name="username" placeholder="Username">
	<br>
	<label for="password">Password:</label>
	<input type="password" id="password" name="password" placeholder="Password">
	<br>
	<input type="submit" value="Sign UP">
</form>
</body>
</html>