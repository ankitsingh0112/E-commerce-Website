<%@page import="com.Entities.User" %>

<%
User user=(User)session.getAttribute("current_user");
if(user.getUserType().equals("normal")) {
	response.sendRedirect("index.jsp");
	return;
}
if(user==null)
{
	session.setAttribute("message", "You are not logged in !! Login first");
	response.sendRedirect("login.jsp");
	return;
}
else
{
	if(user.getUserType().equals("admin"))
	{
		session.setAttribute("message", "You are not a Normal User !! Do not access this page");
    	response.sendRedirect("login.jsp");
		return;
	}
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Panel</title>
</head>
<body>
	<h1>Welcome User</h1>
</body>
</html>