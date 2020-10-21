<%@ page import="java.util.List" %>
<%@ page import="com.webproject.project01.PO.Cart" %>
<%@ page import="com.webproject.project01.VO.CartVO" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/9/11
  Time: 2:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>get-cart-test</title>
</head>
<body>
    <%
        request.getRequestDispatcher("/cart/get").include(request,response);
        List<CartVO> cartVoList = (List<CartVO>) session.getAttribute("cartVoList");
    %>
    <div>
    <%for(CartVO cartVO : cartVoList){%>
        <text><%=cartVO.getId()%>_<%=cartVO.getName()%></text>
    <%}%>
    </div>

</body>
</html>
