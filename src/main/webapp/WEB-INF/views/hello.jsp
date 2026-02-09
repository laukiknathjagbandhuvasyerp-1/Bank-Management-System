<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Hello JSP</title>
</head>
<body>
    <h1>Hello JSP 👋</h1>
    <p>Welcome to your first JSP page.</p>

    <%
        String name = "Laukik";
    %>
    <p>Hello, <b><%= name %></b></p>
</body>
</html>
