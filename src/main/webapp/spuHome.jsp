<%@ page import="java.util.List" %>
<%@ page import="com.webproject.project01.VO.SPUVO" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/7/2
  Time: 4:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Detail SPU</title>
    <script src="JS/jquery-1.8.3.js"></script>
</head>
<body>
<small id="showSpu">
    spuList:<br>
</small>
<script type="text/javascript">
    var totalResult = "${sessionScope.totalResult}";
    var totalPage = "${sessionScope.totalPage}";
    var hasNext = "${sessionScope.hasNext}";
    $("#showSpu").append('<div>'+totalResult+' results found'+'<div>'+'<br>'+'<div>'+totalPage+' pages in total'+'<div>'+'<br>');
    <c:forEach var="item" items="${sessionScope.spuVoList}">
        var id = "${item.id}";
        var name = "${item.name}";
        var sales = "${item.sales}";
        var className = "${item.classificationVO.name}";
        var configChoice = "${item.configChoice}";
        var price = "${item.price}";
        var sales = "${item.sales}";
        var launchTime = "${item.launchTime}";
        $("#showSpu").append('<li>'+'id:'+id+', name:'+name+', sales:'+sales+', className:'+className+', configChoice:'+configChoice+', price:'+price+', sales:'+sales+', launchTime:'+launchTime+'</li>');
    </c:forEach>
    $("#showSpu").append('<div>'+'has next page:'+hasNext+'<div>');
    console.log(hasNext);

</script>

</body>
</html>
