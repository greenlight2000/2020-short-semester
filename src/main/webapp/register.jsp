<%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/7/1
  Time: 9:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>register page</title>
</head>
<body>
    <form method="get" action="./register">
        username: <input type="text" name="name"/><br>
        email:    <input type="text" name="email"/><br>
        phone:    <input type="text" name="phone"/><br>
        password: <input type="text" name="password"/><br>
        <input type="submit" name="btn" value="register">
    </form>
</body>
</html>
