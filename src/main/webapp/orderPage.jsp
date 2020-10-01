<%@ page import="com.webproject.project01.VO.OrderVO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/7/4
  Time: 4:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script src="JS/jquery-1.8.3.js"></script>
    <title>Order Page</title>
</head>
<body>
    <h1 id="showOrder"></h1>
<%--    <script type="text/javascript">--%>
<%--        <c:forEach var="item" items="${sessionScope.orderVoList}">--%>
<%--            var id = "${item.id}";--%>
<%--            var name = "${item.name}";--%>
<%--            var totalPrice = "${item.totalPrice}";--%>
<%--            var configSpecs = "${item.configSpecs}";--%>
<%--            var stockNum = "${item.accessory}";--%>
<%--            var orderTime = "${item.orderTime}";--%>
<%--            var payStatus = "${item.payStatus}";--%>
<%--            $("#showOrder").html('<li>'+'id:'+id+', name:'+name+', totalPrice:'+totalPrice+', configSpecs:'+configSpecs+', stockNum:'+stockNum+', orderTime:'+orderTime+', payStatus:'+payStatus+'</li>');--%>
<%--        </c:forEach>--%>
<%--    </script>--%>
    <div>
    <%for(OrderVO orderVo : (List<OrderVO>)session.getAttribute("orderVoList")){%>
        <li>name:<%=orderVo.getName()%></li><br>
        <div>time:<%=orderVo.getOrderTime()%></div>
        <div>price:<%=orderVo.getTotalPrice()%></div><br>
        <div>config:<%=orderVo.getConfigSpecs()%></div><br>
    <%}%>
    </div>
</body>
</html>
