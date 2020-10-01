<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Full Layout - jQuery EasyUI Demo</title>
</head>
<body>

    <h1>login page</h1>
<%--    <form method="post" action="./login">--%>
<%--        username: <input type="text" name="name"/><br>--%>
<%--        password: <input type="text" name="password"/><br>--%>
<%--        <input type="submit" name="btn" value="post">--%>
<%--    </form>--%>
    <form method="get" action="./login">
        username: <input type="text" name="name"/><br>
        password: <input type="text" name="password"/><br>
        <input type="submit" name="btn" value="get">
    </form>
</body>
</html>