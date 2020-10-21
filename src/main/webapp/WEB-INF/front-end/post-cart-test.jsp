<%@ page import="com.webproject.project01.VO.CartVO" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/9/11
  Time: 1:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>post-cart-test</title>
</head>
<body>
    <%
        out.print(request.getRequestURI()+"?"+request.getQueryString());
    %>
</body>
</html>
