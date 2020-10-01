<%@ page import="com.webproject.project01.PO.User" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/7/1
  Time: 1:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>welcome</title>
</head>
<body>
    <% String name = (String)session.getAttribute("name");%>
    <% User user = (User)session.getAttribute("user");%>
    <h1>welcome! <%=name%></h1>
    <h1>user email; <%=user.getEmail()%></h1>
</body>
</html>
