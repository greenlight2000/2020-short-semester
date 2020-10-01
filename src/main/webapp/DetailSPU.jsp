<%@ page import="java.util.List" %>
<%@ page import="com.webproject.project01.VO.SPUVO" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/7/3
  Time: 10:59 PM
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

<h1 id="showBox">
该商品的sku有：
</h1>
输入spuId<input type="text" id="spuId">
<button type="button" id="btn">查看skuList</button>
<script type="text/javascript">
    <c:forEach var="item" items="${sessionScope.skuList}">
        var id = "${item.id}";
        var name = "${item.name}";
        var totalPrice = "${item.totalPrice}";
        var configSpecs = "${item.configSpecs}";
        var stockNum = "${item.stockNum}";
        $("#showBox").append('<li>'+'id:'+id+', name:'+name+', totalPrice:'+totalPrice+', configSpecs:'+configSpecs+', stockNum:'+stockNum+'</li>');
    </c:forEach>
    let size = ${sessionScope.skuList.size()};
    console.log("size=",size);
    let skuArr = [];

    // $(document).ready(function(){
    //     $('#btn').live('click',function(){
    //         $.ajax({
    //             url:'/detail?spuId=1',
    //             // data:{
    //             //     spuId:$("#id").val()
    //             // },
    //             dataType:"text",
    //             type:"get",
    //             /*beforeSend:function(){
    //                 alert("hi");
    //             },*/
    //             success:function(data){
    //                 console.log(data);
    //             },
    //             error:function(msg){
    //                 console.log(msg);
    //             }
    //         });
    //     });
    // })
</script>

</body>
</html>
