<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" isELIgnored="false"%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Spring Boot Application with JSP</title>
</head>
<body>
<%
    Object name = request.getAttribute("name");
    out.print(request.getHeader("name"));
    out.println("=========");
    out.print(name);
%>
</body>
</html>