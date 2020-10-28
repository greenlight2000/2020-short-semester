<%@ page import="java.util.Arrays" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/9/28
  Time: 4:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>error</title>
</head>
<body>
    <div>
        <h1>the resource queried may be outdated, please return to <a href="index.jsp">home page</a></h1>
        <text>error: <%=exception.toString()%></text><br>
        <text>cause: <%=exception.getCause()%></text><br>
<%--        <text>trace: <%=Arrays.toString(exception.getStackTrace())%></text><br>--%>
        <%System.out.println(exception.toString());%>
    </div>
</body>
</html>
