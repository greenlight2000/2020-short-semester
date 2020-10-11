<%@ page import="com.webproject.project01.VO.CartVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.webproject.project01.VO.OrderVO" %>
<%@ page import="antlr.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="exception-page.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
	<head>
		<!-- Meta -->
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<meta name="description" content="">
		<meta name="author" content="">
	    <meta name="keywords" content="">
	    <meta name="robots" content="all">
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	    <title>订单列表 - 慕课商城</title>

	    <!-- Bootstrap Core CSS -->
	    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
	    
	    <!-- Customizable CSS -->
	    <link rel="stylesheet" href="assets/css/main.css">
	    <link rel="stylesheet" href="assets/css/red.css">
	    <link rel="stylesheet" href="assets/css/owl.carousel.css">
		<link rel="stylesheet" href="assets/css/owl.transitions.css">
		<link rel="stylesheet" href="assets/css/animate.min.css">

		
		<!-- Icons/Glyphs -->
		<link rel="stylesheet" href="assets/css/font-awesome.min.css">
		
		<!-- Favicon -->
		<link rel="shortcut icon" href="assets/images/favicon.ico">

		<!-- HTML5 elements and media queries Support for IE8 : HTML5 shim and Respond.js -->
		<!--[if lt IE 9]>
			<script src="assets/js/html5shiv.js"></script>
			<script src="assets/js/respond.min.js"></script>
		<![endif]-->
 
	</head>
<body>
<%
    //header
    //获取cartVoList   req里需要有userId, 否则session里的cartVoList 为 new ArrayList<>
    request.getRequestDispatcher("/cart/get").include(request,response);
    List<CartVO> cartVoList = (List<CartVO>) session.getAttribute("cartVoList");
    double cartTotalPrice = 0;
    int cartNum = 0;
    for(CartVO cartVo : cartVoList){
        cartTotalPrice += cartVo.getTotalPrice();
        cartNum++;
    }
    String userId = session.getAttribute("userId")==null?"":(String) session.getAttribute("userId");
    String userName = session.getAttribute("userName")==null?"":(String)session.getAttribute("userName");
%>
<%
    //获取用户的订单
    request.getRequestDispatcher("/showOrder").include(request,response);
    List<OrderVO> orderVoList = session.getAttribute("orderVoList")==null?new ArrayList<>(): (List<OrderVO>) session.getAttribute("orderVoList");
%>
	<div class="wrapper">
		<!-- ============================================================= TOP NAVIGATION ============================================================= -->
        <nav class="top-bar animate-dropdown">
            <div class="container">
                <div class="col-xs-12 col-sm-6 no-margin">
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="product-list.jsp">All Categories</a></li>
                        <li><a onclick="goToCart(<%=userId%>)">My Cart</a></li>
                        <li><a onclick="goToOrder(<%=userId%>)">My Order</a></li>
                    </ul>
                </div><!-- /.col -->

                <div class="col-xs-12 col-sm-6 no-margin">
                    <ul class="right">
                        <ul class="right">
                            <%if(userName.equals("")){%>
                            <li><a href="register.jsp">register</a></li>
                            <li><a href="authentication.jsp">log in</a></li>
                            <%}else{%>
                            <li><a href="authentication.jsp">welcome, <%=userName%> &nbsp<img style="border: solid 1px lightgrey;" alt="user_head" src="assets/images/user-figure/defalt-user-figure.jpg" width="25" height="25"/></a></li>
                            <li><a href="javascript:void(0);" onclick="logout()">log out</a></li>
                            <%}%>
                        </ul>
                    </ul>
                </div><!-- /.col -->
            </div><!-- /.container -->
        </nav><!-- /.top-bar -->
<!-- ============================================================= TOP NAVIGATION : END ============================================================= -->		<!-- ============================================================= HEADER ============================================================= -->
        <header>
            <div class="container no-padding">

                <div class="col-xs-12 col-sm-12 col-md-3 logo-holder">
                    <!-- ============================================================= LOGO ============================================================= -->
                    <div class="logo">
                        <a href="index.html">
                            <img alt="logo" src="assets/images/group57-logo.png" width="333" height="70"/>
                        </a>
                    </div><!-- /.logo -->
                    <!-- ============================================================= LOGO : END ============================================================= -->		</div><!-- /.logo-holder -->

                <div class="col-xs-12 col-sm-12 col-md-6 top-search-holder no-margin">
                    <div class="contact-row">
                        <div class="phone inline">
                            <i class="fa fa-phone"></i> (+086) 123 456 7890
                        </div>
                        <div class="contact inline">
                            <i class="fa fa-envelope"></i> contact@<span class="le-color">bupt.edu.com</span>
                        </div>
                    </div><!-- /.contact-row -->
                    <!-- ============================================================= SEARCH AREA ============================================================= -->
                    <div class="search-area">
                        <form>
                            <div class="control-group">
                                <input class="search-field" placeholder="Search Product" id="keywords-input"/>
                                <ul class="categories-filter animate-dropdown">
                                    <li class="dropdown"><a class="dropdown-toggle"  data-toggle="dropdown" href="product-list.jsp" id="search-by-box" tabindex="0">Search By</a>
                                        <ul class="dropdown-menu" role="menu" >
                                            <li role="presentation"><a role="menuitem" tabindex="0" onclick="chooseSearchBy(this)" >By Name</a></li>
                                            <li role="presentation"><a role="menuitem" tabindex="2" onclick="chooseSearchBy(this)">By Description</a></li>
                                            <li role="presentation"><a role="menuitem" tabindex="3" onclick="chooseSearchBy(this)">By Brand</a></li>
                                        </ul>
                                    </li>
                                </ul>
                                <a style="padding:15px 15px 13px 12px" class="search-button" href="#" onclick="clickSearch()"></a>
                            </div>
                        </form>
                    </div><!-- /.search-area -->
                    <!-- ============================================================= SEARCH AREA : END ============================================================= -->
                </div><!-- /.top-search-holder -->

                <div class="col-xs-12 col-sm-12 col-md-3 top-cart-row no-margin">
                    <div class="top-cart-row-container">

                        <!-- ============================================================= SHOPPING CART DROPDOWN ============================================================= -->
                        <div class="top-cart-holder dropdown animate-dropdown">
                            <div class="basket">

                                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                    <div class="basket-item-count">
                                        <span class="count"><%=cartNum%></span>
                                        <img src="assets/images/icon-cart.png" alt="" />
                                    </div>

                                    <div class="total-price-basket">
                                        <span class="lbl">Your Cart:</span>
                                        <span class="total-price">
                        <span class="sign">$</span><span class="value"><%=cartTotalPrice%></span>
                    </span>
                                    </div>
                                </a>

                                <ul class="dropdown-menu">
                                    <%for(CartVO cartVo : cartVoList){%>
                                    <li>
                                        <div class="basket-item">
                                            <div class="row">
                                                <div class="col-xs-4 col-sm-4 no-margin text-center">
                                                    <div class="thumb">
                                                        <img alt="" src="<%=cartVo.getPicture()%>" />
                                                    </div>
                                                </div>
                                                <div class="col-xs-8 col-sm-8 no-margin">
                                                    <div class="title"><%=cartVo.getName()%></div>
                                                    <div class="price">$<%=cartVo.getTotalPrice()%></div>
                                                </div>
                                            </div>
                                            <a class="close-btn" onclick="clickDelCart(<%=cartVo.getId()%>)" href="<%=request.getRequestURI()%>"></a>
                                        </div>
                                    </li>
                                    <%}%>



                                    <li class="checkout">
                                        <div class="basket-item">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-6">
                                                    <a class="le-button inverse" href="javascript:void(0);" onclick="goToCart(<%=userId%>)">View Cart</a>
                                                </div>
                                                <div class="col-xs-12 col-sm-6">
                                                    <a href="checkout.jsp" class="le-button">Check Out</a>
                                                </div>
                                            </div>
                                        </div>
                                    </li>

                                </ul>
                            </div><!-- /.basket -->
                        </div><!-- /.top-cart-holder -->
                    </div><!-- /.top-cart-row-container -->
                    <!-- ============================================================= SHOPPING CART DROPDOWN : END ============================================================= -->		</div><!-- /.top-cart-row -->

            </div><!-- /.container -->
        </header>

<!-- ============================================================= HEADER : END ============================================================= -->
        <div class="control-bar">
            <button class="le-button" onclick="filterPayStatus(<%=userId%>)">Filter</button>
            <div id="filter" class="le-select">
                <select id="select-payStatus">
                    <option value="" selected>all</option>
                    <option value="paid">paid</option>
                    <option value="unpaid">unpaid</option>
                    <option value="canceled">canceled</option>
                </select>
            </div>
        </div><!-- /.control-bar -->
    <div id="single-product">
    <%
    String preTime = "";
    double billPrice = 0;
    StringBuilder billOrderIdSB = new StringBuilder();
//    if(!orderVoList.isEmpty())
//        preTime = orderVoList.get(0).getOrderTime();
        int i;
        OrderVO orderVo;
    %>
        <div style="margin-bottom:30px;">
          <div class="trade-order-mainClose">
            <div>
                <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                    <colgroup>
                        <col style="width:38%;">
                        <col style="width:10%;">
                        <col style="width:5%;">
                        <col style="width:12%;">
                        <col style="width:12%;">
                        <col style="width:11%;">
                        <col style="width:12%;">
                    </colgroup>
                    <tbody>
                <%
                for(i = 0; i<orderVoList.size() ;i++){
                    orderVo = orderVoList.get(i);
                    billPrice += orderVo.getTotalPrice();
                    //从这个商品开始新的bill，加一条时间分割条
                    if(!orderVo.getOrderTime().equals(preTime)){
                        preTime = orderVo.getOrderTime();
                        billOrderIdSB = new StringBuilder();
                    %>
                <%--     time label table     --%>
                    </tbody>
                </table>
                <%-- 日期时间拦 --%>
                <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                    <colgroup>
                        <col style="width:38%;">
                        <col style="width:10%;">
                        <col style="width:5%;">
                        <col style="width:12%;">
                        <col style="width:12%;">
                        <col style="width:11%;">
                        <col style="width:12%;">
                    </colgroup>
                    <tbody>
                    <tr style="background-color:#F5F5F5;width:100%">
                        <td style="padding:10px 20px;text-align:left;">
                            <label>
                                <input type="checkbox" disabled="" style="margin-right:8px;">
                                <strong title="2016-02-17 15:55:26" style="margin-right:8px;font-weight:bold;">
                                    <%=orderVo.getOrderTime()%>
                                </strong>
                            </label>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                    <colgroup>
                        <col style="width:38%;">
                        <col style="width:10%;">
                        <col style="width:5%;">
                        <col style="width:12%;">
                        <col style="width:12%;">
                        <col style="width:11%;">
                        <col style="width:12%;">
                    </colgroup>
                    <tbody>
                    <%}%>
                        <tr>
                        <td style="text-align:left;vertical-align:top;padding-top:10px;padding-bottom:10px;border-right-width:0;border-right-style:solid;border-right-color:#E8E8E8;border-top-width:0;border-top-style:solid;border-top-color:#E8E8E8;padding-left:20px;" >
                            <div style="overflow:hidden;">
                                <a class="tp-tag-a" href="<%=orderVo.getPicture()%>" style="float:left;width:27%;margin-right:2%;text-align:center;" target="_blank">
                                    <img src="<%=orderVo.getPicture()%>" style="width: 73px; height: 73px; border:1px solid #E8E8E8;max-width:80px;">
                                </a>
                                <div style="float:left;width:71%;word-wrap:break-word;">
                                    <div style="margin:0px;">
                                        <a class="tp-tag-a" href="javascript:void(0);" onclick="checkProduct(<%=orderVo.getSpuId()%>)">
                              <span>
                                <%=orderVo.getName()%><br><%=orderVo.getConfigSpecs()%><br>
                              </span>
                                        </a>
                                        <span>
                            </span>
                                    </div>
                                    <div style="margin-top:8px;margin-bottom:0;color:#9C9C9C;">
                            <span style="margin-right:6px;">
                              <span>
                              <%if(orderVo.getAccessory()!=null && !orderVo.getAccessory().equals("")){%>
                                Accessory:
                              </span>
                              <span>
                              <%=orderVo.getAccessory()%>
                              <%}%>
                              </span>
                            </span>
                                    </div>

                                    <span>
                            </span>
                                </div>
                            </div>
                        </td>
                        <td style="text-align:center;vertical-align:top;padding-top:10px;padding-bottom:10px;border-right-width:0;border-right-style:solid;border-right-color:#E8E8E8;border-top-width:0;border-top-style:solid;border-top-color:#E8E8E8;">
                            <div style="font-family:verdana;font-style:normal;">
                                <div>
                                    <%=orderVo.getNum()%>
                                </div>
                            </div>
                        </td>
                        <td style="text-align:center;vertical-align:top;padding-top:10px;padding-bottom:10px;border-right-width:0;border-right-style:solid;border-right-color:#E8E8E8;border-top-width:0;border-top-style:solid;border-top-color:#E8E8E8;">
                            <div style="font-family:verdana;font-style:normal;">
                                <%--                            <p>--%>
                                <%--                              <del style="color:#9C9C9C;">--%>
                                <%--                                <%=orderVo.getTotalPrice()%>--%>
                                <%--                              </del>--%>
                                <%--                            </p>--%>
                                <p>
                                    $<%=orderVo.getTotalPrice()%>
                                </p>
                            </div>
                        </td>
                        <td style="text-align:center;vertical-align:top;padding-top:10px;padding-bottom:10px;border-right-width:1px;border-right-style:solid;border-right-color:#E8E8E8;border-top-width:0;border-top-style:solid;border-top-color:#E8E8E8;" >
                            <div>
                                <div style="margin-bottom:3px;">
                          <span>
                            <span class="trade-ajax">
                              <span class="trade-tooltip-wrap">
                                <span>
                                    <%
                                        String color = "green";
                                        switch (orderVo.getPayStatus()){
                                            case "paid":
                                                break;
                                            case "unpaid":
                                                color = "orange";
                                                break;
                                            case "canceled":
                                                color = "grey";
                                                break;
                                        }
                                    %>
                                  <span class="trade-operate-text" style="color: <%=color%>">
                                    <%=orderVo.getPayStatus()%>
                                  </span>
                                </span>
                              </span>
                            </span>
                          </span>
                                </div>
                            </div>
                        </td>
                        <%
                            billOrderIdSB.append(orderVo.getId());
                            billOrderIdSB.append(';');
                        %>
                        <%boolean isShowBillProp = i==orderVoList.size()-1 || !orderVoList.get(i + 1).getOrderTime().equals(orderVo.getOrderTime());%>
                        <td style="text-align:center;vertical-align:top;padding-top:10px;padding-bottom:10px;border-right-width:1px;border-right-style:solid;border-right-color:#E8E8E8;border-top-width:0;border-top-style:solid;border-top-color:#E8E8E8;" >
                            <div>
                                <div style="font-family:verdana;font-style:normal;">
                                    <p>
                                        <strong>
                                            <%if(isShowBillProp){%>
                                            <%=billPrice+10%>
                                            <%}%>
                                        </strong>
                                    </p>
                                </div>
                                <p>
                              <span>
                              <%if(isShowBillProp){%>
                                (freight fee: $10)
                              <%}%>
                              </span>
                                    <span>
                                 </span>
                                    <span>
                                </span>
                                </p>
                                <div>
                                </div>
                            </div>

                        </td>
                        <td style="text-align:center;vertical-align:top;padding-top:10px;padding-bottom:10px;border-right-width:1px;border-right-style:solid;border-right-color:#E8E8E8;border-top-width:0;border-top-style:solid;border-top-color:#E8E8E8;" >
                            <div>
                                <div style="margin-bottom:3px;">
                                    <%if(isShowBillProp){
                                        String str = "";
                                        String href = "";
                                        switch (orderVo.getPayStatus()){
                                            case "unpaid":
                                                str = "go to pay";
                                                href = "payBill(this.attributes[1].value);";
                                                break;
                                            case "paid":
                                                str = "Transfer complete";
                                                href = "";
                                                break;
                                            case "canceled":
                                                str = "orders canceled";
                                                href = "";
                                                break;
                                        }%>
                                    <a class="tp-tag-a" orders-id="<%=billOrderIdSB.toString()%>"  href="javascript: void(0);" onclick="<%=href%>">
                                        <%=str%>
                                    </a>
                                    <%}%>
                                </div>
                                <div>
                                    <div style="margin-bottom:3px;">
                                <span>
                                    <%if(isShowBillProp){
                                        String str = "";
                                        String href = "";
                                        switch (orderVo.getPayStatus()){
                                            case "unpaid":
                                                str = "cancel orders";
                                                href = "cancelBill(this.attributes[1].value);";
                                                break;
                                            case "paid":
                                                str = "track logistics";
                                                href = "";
                                                break;
                                            case "canceled":
                                                str = "";
                                                href = "";
                                                break;
                                        }%>
                                        <a class="tp-tag-a" orders-id="<%=billOrderIdSB.toString()%>" href="javascript:void(0);"  onclick="<%=href%>">
                                            <span class="trade-operate-text">
                                            <%=str%>
                                            </span>
                                        </a>
                                    <%}%>
                                </span>
                                    </div>

                                </div>
                            </div>
                        </td>
                        <%
                            if(isShowBillProp)
                                billPrice = 0;
                        %>
                        <td style="text-align:center;vertical-align:top;padding-top:10px;padding-bottom:10px;border-right-width:0;border-right-style:solid;border-right-color:#E8E8E8;border-top-width:0;border-top-style:solid;border-top-color:#E8E8E8;" >
                            <div>
                                <div style="margin-bottom: 3px;">
                          <span>
                            <a class="tp-tag-a" href="javascript:void(0);" target="_blank">
                              <span class="trade-operate-text">
                                comment
                              </span>
                            </a>
                          </span>
                                </div>
                            </div>
                        </td>
                    </tr>
                <%}%>
                    </tbody>
                </table>
            </div>
          </div>
        </div>
<%--    <%}%>--%>
    </div>


<footer id="footer" class="color-bg">
    
    <div class="container">
        <div class="row no-margin widgets-row">
            <div class="col-xs-12  col-sm-4 no-margin-left">
                <!-- ============================================================= FEATURED PRODUCTS ============================================================= -->
<div class="widget">
    <h2>推荐商品</h2>
    <div class="body">
        <ul>
            <li>
                <div class="row">
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">Netbook Acer Travel B113-E-10072</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>  

                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-01.jpg" />
                        </a>
                    </div>
                </div>
            </li>

            <li>
                <div class="row">
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">PowerShot Elph 115 16MP Digital Camera</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-02.jpg" />
                        </a>
                    </div>
                </div>
            </li>
            
            <li>
                <div class="row">                        
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">PowerShot Elph 115 16MP Digital Camera</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>  

                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-03.jpg" />
                        </a>
                    </div>
                </div>
            </li>
        </ul>
    </div><!-- /.body -->
</div> <!-- /.widget -->
<!-- ============================================================= FEATURED PRODUCTS : END ============================================================= -->            </div><!-- /.col -->

            <div class="col-xs-12 col-sm-4 ">
                <!-- ============================================================= ON SALE PRODUCTS ============================================================= -->
<div class="widget">
    <h2>促销商品</h2>
    <div class="body">
        <ul>
            <li>
                <div class="row">
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">HP Scanner 2910P</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>  

                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-04.jpg" />
                        </a>
                    </div>
                </div>

            </li>
            <li>
                <div class="row">
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">Galaxy Tab 3 GT-P5210 16GB, Wi-Fi, 10.1in - White</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>  

                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-05.jpg" />
                        </a>
                    </div>
                </div>
            </li>

            <li>
                <div class="row">
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">PowerShot Elph 115 16MP Digital Camera</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>  

                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-06.jpg" />
                        </a>
                    </div>
                </div>
            </li>
        </ul>
    </div><!-- /.body -->
</div> <!-- /.widget -->
<!-- ============================================================= ON SALE PRODUCTS : END ============================================================= -->            </div><!-- /.col -->

            <div class="col-xs-12 col-sm-4 ">
                <!-- ============================================================= TOP RATED PRODUCTS ============================================================= -->
<div class="widget">
    <h2>最热商品</h2>
    <div class="body">
        <ul>
            <li>
                <div class="row">
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">Galaxy Tab GT-P5210, 10" 16GB Wi-Fi</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>  

                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-07.jpg" />
                        </a>
                    </div>
                </div>
            </li>

            <li>
                <div class="row">
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">PowerShot Elph 115 16MP Digital Camera</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>  

                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-08.jpg" />
                        </a>
                    </div>
                </div>
            </li>

            <li>
                <div class="row">
                    <div class="col-xs-12 col-sm-9 no-margin">
                        <a href="single-product.jsp">Surface RT 64GB, Wi-Fi, 10.6in - Dark Titanium</a>
                        <div class="price">
                            <div class="price-prev">￥2000</div>
                            <div class="price-current">￥1873</div>
                        </div>
                    </div>  

                    <div class="col-xs-12 col-sm-3 no-margin">
                        <a href="#" class="thumb-holder">
                            <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-09.jpg" />
                        </a>
                    </div>

                </div>
            </li>
        </ul>
    </div><!-- /.body -->
</div><!-- /.widget -->
<!-- ============================================================= TOP RATED PRODUCTS : END ============================================================= -->            </div><!-- /.col -->

        </div><!-- /.widgets-row-->
    </div><!-- /.container -->

    <div class="sub-form-row">
        <!--<div class="container">
            <div class="col-xs-12 col-sm-8 col-sm-offset-2 no-padding">
                <form role="form">
                    <input placeholder="Subscribe to our newsletter">
                    <button class="le-button">Subscribe</button>
                </form>
            </div>
        </div>--><!-- /.container -->
    </div><!-- /.sub-form-row -->

    <div class="link-list-row">
        <div class="container no-padding">
            <div class="col-xs-12 col-md-4 ">
                <!-- ============================================================= CONTACT INFO ============================================================= -->
<div class="contact-info">
    <div class="footer-logo">
		<img alt="logo" src="assets/images/logo.PNG" width="233" height="54"/>
    </div><!-- /.footer-logo -->
    
    <p class="regular-bold"> 请通过电话，电子邮件随时联系我们</p>
    
    <p>
        西城区二环到三环德胜门外大街10号TCL大厦3层(马甸桥南), 北京市西城区, 中国
        <br>慕课网 (QQ群:416465236)
    </p>
    
    <!--<div class="social-icons">
        <h3>Get in touch</h3>
        <ul>
            <li><a href="http://facebook.com/transvelo" class="fa fa-facebook"></a></li>
            <li><a href="#" class="fa fa-twitter"></a></li>
            <li><a href="#" class="fa fa-pinterest"></a></li>
            <li><a href="#" class="fa fa-linkedin"></a></li>
            <li><a href="#" class="fa fa-stumbleupon"></a></li>
            <li><a href="#" class="fa fa-dribbble"></a></li>
            <li><a href="#" class="fa fa-vk"></a></li>
        </ul>
    </div>--><!-- /.social-icons -->

</div>
<!-- ============================================================= CONTACT INFO : END ============================================================= -->            </div>

            <div class="col-xs-12 col-md-8 no-margin">
                <!-- ============================================================= LINKS FOOTER ============================================================= -->
<div class="link-widget">
    <div class="widget">
        <h3>快速检索</h3>
        <ul>
            <li><a href="product-list.jsp">laptops &amp; computers</a></li>
            <li><a href="product-list.jsp">Cameras &amp; Photography</a></li>
            <li><a href="product-list.jsp">Smart Phones &amp; Tablets</a></li>
            <li><a href="product-list.jsp">Video Games &amp; Consoles</a></li>
            <li><a href="product-list.jsp">TV &amp; Audio</a></li>
            <li><a href="product-list.jsp">Gadgets</a></li>
            <li><a href="product-list.jsp">Car Electronic &amp; GPS</a></li>
            <li><a href="product-list.jsp">Accesories</a></li>
        </ul>
    </div><!-- /.widget -->
</div><!-- /.link-widget -->

<div class="link-widget">
    <div class="widget">
        <h3>热门商品</h3>
        <ul>
            <li><a href="product-list.jsp">Find a Store</a></li>
            <li><a href="product-list.jsp">About Us</a></li>
            <li><a href="product-list.jsp">Contact Us</a></li>
            <li><a href="product-list.jsp">Weekly Deals</a></li>
            <li><a href="product-list.jsp">Gift Cards</a></li>
            <li><a href="product-list.jsp">Recycling Program</a></li>
            <li><a href="product-list.jsp">Community</a></li>
            <li><a href="product-list.jsp">Careers</a></li>

        </ul>
    </div><!-- /.widget -->
</div><!-- /.link-widget -->

<div class="link-widget">
    <div class="widget">
        <h3>最近浏览</h3>
        <ul>
            <li><a href="product-list.jsp">My Account</a></li>
            <li><a href="product-list.jsp">Order Tracking</a></li>
            <li><a href="product-list.jsp">Wish List</a></li>
            <li><a href="product-list.jsp">Customer Service</a></li>
            <li><a href="product-list.jsp">Returns / Exchange</a></li>
            <li><a href="product-list.jsp">FAQs</a></li>
            <li><a href="product-list.jsp">Product Support</a></li>
            <li><a href="product-list.jsp">Extended Service Plans</a></li>
        </ul>
    </div><!-- /.widget -->
</div><!-- /.link-widget -->
<!-- ============================================================= LINKS FOOTER : END ============================================================= -->            </div>
        </div><!-- /.container -->
    </div><!-- /.link-list-row -->

    <div class="copyright-bar">
        <div class="container">
            <div class="col-xs-12 col-sm-6 no-margin">
                <div class="copyright">
                    &copy; <a href="index.html">Imooc.com</a> - all rights reserved
                </div><!-- /.copyright -->
            </div>
            <div class="col-xs-12 col-sm-6 no-margin">
                <div class="payment-methods ">
                    <ul>
                        <li><img alt="" src="assets/images/payments/payment-visa.png"></li>
                        <li><img alt="" src="assets/images/payments/payment-master.png"></li>
                        <li><img alt="" src="assets/images/payments/payment-paypal.png"></li>
                        <li><img alt="" src="assets/images/payments/payment-skrill.png"></li>
                    </ul>
                </div><!-- /.payment-methods -->
            </div>
        </div><!-- /.container -->
    </div><!-- /.copyright-bar -->

</footer><!-- /#footer -->
<!-- ============================================================= FOOTER : END ============================================================= -->	</div><!-- /.wrapper -->

	<!-- JavaScripts placed at the end of the document so the pages load faster -->
	<script src="assets/js/jquery-1.10.2.min.js"></script>
	<script src="assets/js/jquery-migrate-1.2.1.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/gmap3.min.js"></script>
	<script src="assets/js/bootstrap-hover-dropdown.min.js"></script>
	<script src="assets/js/owl.carousel.min.js"></script>
	<script src="assets/js/css_browser_selector.min.js"></script>
	<script src="assets/js/echo.min.js"></script>
	<script src="assets/js/jquery.easing-1.3.min.js"></script>
	<script src="assets/js/bootstrap-slider.min.js"></script>
    <script src="assets/js/jquery.raty.min.js"></script>
    <script src="assets/js/jquery.prettyPhoto.min.js"></script>
    <script src="assets/js/jquery.customSelect.min.js"></script>
    <script src="assets/js/wow.min.js"></script>
	<script src="assets/js/scripts.js"></script>
    <script src="assets/js/fun.js"></script>
</div>
</body>
</html>
