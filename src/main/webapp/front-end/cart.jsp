<%@ page import="com.webproject.project01.VO.CartVO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.webproject.project01.PO.Cart" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
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
	    <meta name="keywords" content="MediaCenter, Template, eCommerce">
	    <meta name="robots" content="all">
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	    <title>Group 57 - My Cart</title>
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
    <%//navigation
        String userName = session.getAttribute("userName")==null?"":(String)session.getAttribute("userName");
    %>
    <%//header
        //获取cartVoList   req里需要有userId, 否则session里的cartVoList 为 new ArrayList<>
        request.getRequestDispatcher("/cart/get").include(request,response);
        List<CartVO> cartVoList = (List<CartVO>) session.getAttribute("cartVoList");
        double cartTotalPrice = 0;
        int cartNum = 0;
        for(CartVO cartVo : cartVoList){
            cartTotalPrice += cartVo.getTotalPrice();
            cartNum++;
        }
        //view cart需要的参数
        String userId = session.getAttribute("userId")==null?"":(String) session.getAttribute("userId");
    %>
	<div class="wrapper">
		<!-- ============================================================= TOP NAVIGATION ============================================================= -->
        <nav class="top-bar animate-dropdown">
            <div class="container">
                <div class="col-xs-12 col-sm-6 no-margin">
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="product-list.jsp">All Categories</a></li>
                        <li><a href="javascript:void(0);" onclick="goToCart(<%=userId%>)">My Cart</a></li>
                        <li><a href="javascript:void(0);" onclick="goToOrder(<%=userId%>)">My Order</a></li>
                    </ul>
                </div><!-- /.col -->

                <div class="col-xs-12 col-sm-6 no-margin">
                    <ul class="right">
                        <ul class="right">
                            <%if(userName.equals("")){%>
                            <li><a href="authentication.jsp">register</a></li>
                            <li><a href="authentication.jsp">log in</a></li>
                            <%}else{%>
                            <li><a href="user-info.jsp">welcome, <%=userName%> &nbsp<img style="border: solid 1px lightgrey;" alt="user_head" src="assets/images/user-figure/defalt-user-figure.jpg" width="25" height="25"/></a></li>
                            <li><a href="javascript:void(0);" onclick="logout()">log out</a></li>
                            <%}%>
                        </ul>
                    </ul>
                </div><!-- /.col -->
            </div><!-- /.container -->
        </nav><!-- /.top-bar -->
<!-- ============================================================= TOP NAVIGATION : END ============================================================= -->
        <!-- ============================================================= HEADER ============================================================= -->
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
                                            <li role="presentation"><a role="menuitem" tabindex="0" href="javascript:void(0);" onclick="chooseSearchBy(this)" >By Name</a></li>
                                            <li role="presentation"><a role="menuitem" tabindex="2" href="javascript:void(0);" onclick="chooseSearchBy(this)">By Description</a></li>
                                            <li role="presentation"><a role="menuitem" tabindex="3" href="javascript:void(0);" onclick="chooseSearchBy(this)">By Brand</a></li>
                                        </ul>
                                    </li>
                                </ul>
                                <a style="padding:15px 15px 13px 12px" class="search-button" href="javascript:void(0);" onclick="clickSearch()"></a>
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
                                        <span class="lbl">My Cart:</span>
                                        <span class="total-price">
                        <span class="sign">$</span><span class="value"><%=cartTotalPrice%></span>
                    </span>
                                    </div>
                                </a>

                                <ul class="dropdown-menu">
                                    <%if(cartVoList.isEmpty()){%>
                                    <li>
                                        <div class="basket-item">
                                            <div class="row">
                                                <text style="margin-left: 90px">the Cart is Empty ~</text>
                                            </div>
                                        </div>
                                    </li>
                                    <%}%>
                                    <%for(CartVO cartVo : cartVoList){%>
                                    <li>
                                        <div class="basket-item">
                                            <div class="row">
                                                <div class="col-xs-4 col-sm-4 no-margin text-center">
                                                    <div class="thumb">
                                                        <img alt="" src="<%=cartVo.getPicture()%>" width="85px" height="73px"/>
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

<!-- ============================================================= HEADER : END ============================================================= -->		<section id="cart-page">
    <div class="container">
        <!-- ========================================= CONTENT ========================================= -->
        <div class="col-xs-12 col-md-9 items-holder no-margin">
            <%for(CartVO cartVO : cartVoList){
//                Gson gson = new Gson();
//                Map<String,String> configMap = gson.fromJson(cartVO.getConfigSpecs(),Map.class);
//
//                StringBuilder configStr = new StringBuilder();
//                int cnt=0;
//                for(Map.Entry<String,String> entry : configMap.entrySet()){
//                    cnt++;
//                    configStr.append(entry.getValue());
//                    if(cnt!=configMap.size()){
//                        configStr.append(" ✖ ");
//                    }
//                }
            %>
            <div class="row no-margin cart-item">
                <div class="col-xs-12 col-sm-2 no-margin">
                    <a href="#" class="thumb-holder">
                        <img class="lazy" alt="" src="<%=cartVO.getPicture()%>" width="100px" height="90px"/>
                    </a>
                </div>

                <div class="col-xs-12 col-sm-5 ">
                    <div class="title">
                        <a href="javascript:void(0);" onclick="checkProduct(<%=cartVO.getSpuId()%>)"><%=cartVO.getName()%></a>
                    </div>
                    <div class="brand"><%=cartVO.getConfigSpecs()%></div>
                    <div class="brand">accessory: <%=cartVO.getAccessory().equals("")?"no accessory selected":cartVO.getAccessory()%></div>
                </div>

                <div class="col-xs-12 col-sm-3 no-margin">
                    <div class="quantity">
                        <div class="le-quantity">
                            <form>
                                <span class="minus" href="javascript:void(0);" onclick="changeNum2('-',<%=cartVO.getSkuId()%>, <%=cartVO.getId()%>, <%=userId%>)"></span>
                                <input id="choose-num-<%=cartVO.getSkuId()%>" readonly="readonly" type="text" value="<%=cartVO.getNum()%>"/>
                                <span class="plus" href="javascript:void(0);" onclick="changeNum2('+',<%=cartVO.getSkuId()%>, <%=cartVO.getId()%>, <%=userId%>)"></span>
                            </form>
                        </div>
                    </div>
                </div> 

                <div class="col-xs-12 col-sm-2 no-margin">
                    <div class="price">
                        <div id="cart-tot-price-<%=cartVO.getSkuId()%>" value="<%=cartVO.getTotalPrice()%>">$<%=cartVO.getTotalPrice()%></div>
                    </div>
                    <a class="close-btn" onclick="clickDelCart(<%=cartVO.getId()%>)" href="<%=request.getRequestURI()+"?"+request.getQueryString()%>"></a>
                </div>
            </div><!-- /.cart-item -->
            <%}%>
<%--            <div class="row no-margin cart-item">--%>
<%--                <div class="col-xs-12 col-sm-2 no-margin">--%>
<%--                    <a href="#" class="thumb-holder">--%>
<%--                        <img class="lazy" alt="" src="assets/images/products/product-small-01.jpg" />--%>
<%--                    </a>--%>
<%--                </div>--%>

<%--                <div class="col-xs-12 col-sm-5">--%>
<%--                    <div class="title">--%>
<%--                        <a href="#">white lumia 9001 </a>--%>
<%--                    </div>--%>
<%--                    <div class="brand">sony</div>--%>
<%--                </div> --%>

<%--                <div class="col-xs-12 col-sm-3 no-margin">--%>
<%--                    <div class="quantity">--%>
<%--                        <div class="le-quantity">--%>
<%--                            <form>--%>
<%--                                <a class="minus" href="#reduce"></a>--%>
<%--                                <input name="quantity" readonly="readonly" type="text" value="1" />--%>
<%--                                <a class="plus" href="#add"></a>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="col-xs-12 col-sm-2 no-margin">--%>
<%--                    <div class="price">--%>
<%--                        $2000.00--%>
<%--                    </div>--%>
<%--                    <a class="close-btn" href="#"></a>--%>
<%--                </div>--%>
<%--            </div><!-- /.cart-item -->--%>

<%--            <div class="row no-margin cart-item">--%>
<%--                <div class="col-xs-12 col-sm-2 no-margin">--%>
<%--                    <a href="#" class="thumb-holder">--%>
<%--                        <img class="lazy" alt="" src="assets/images/products/product-small-01.jpg" />--%>
<%--                    </a>--%>
<%--                </div>--%>

<%--                <div class="col-xs-12 col-sm-5">--%>
<%--                    <div class="title">--%>
<%--                        <a href="#">white lumia 9001 </a>--%>
<%--                    </div>--%>
<%--                    <div class="brand">sony</div>--%>
<%--                </div> --%>

<%--                <div class="col-xs-12 col-sm-3 no-margin">--%>
<%--                    <div class="quantity">--%>
<%--                        <div class="le-quantity">--%>
<%--                            <form>--%>
<%--                                <a class="minus" href="#reduce"></a>--%>
<%--                                <input name="quantity" readonly="readonly" type="text" value="1" />--%>
<%--                                <a class="plus" href="#add"></a>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div> --%>
<%--                --%>
<%--                <div class="col-xs-12 col-sm-2 no-margin">--%>
<%--                    <div class="price">--%>
<%--                        $2000.00--%>
<%--                    </div>--%>
<%--                    <a class="close-btn" href="#"></a>--%>
<%--                </div>--%>
<%--            </div><!-- /.cart-item -->--%>

<%--            <div class="row no-margin cart-item">--%>
<%--                <div class="col-xs-12 col-sm-2 no-margin">--%>
<%--                    <a href="#" class="thumb-holder">--%>
<%--                        <img class="lazy" alt="" src="assets/images/products/product-small-01.jpg" />--%>
<%--                    </a>--%>
<%--                </div>--%>

<%--                <div class="col-xs-12 col-sm-5">--%>
<%--                    <div class="title">--%>
<%--                        <a href="#">white lumia 9001 </a>--%>
<%--                    </div>--%>
<%--                    <div class="brand">sony</div>--%>
<%--                </div> --%>

<%--                <div class="col-xs-12 col-sm-3 no-margin">--%>
<%--                    <div class="quantity">--%>
<%--                        <div class="le-quantity">--%>
<%--                            <form>--%>
<%--                                <a class="minus" href="#reduce"></a>--%>
<%--                                <input name="quantity" readonly="readonly" type="text" value="1" />--%>
<%--                                <a class="plus" href="#add"></a>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="col-xs-12 col-sm-2 no-margin">--%>
<%--                    <div class="price">--%>
<%--                        $2000.00--%>
<%--                    </div>--%>
<%--                    <a class="close-btn" href="#"></a>--%>
<%--                </div>--%>
<%--            </div><!-- /.cart-item -->--%>
        </div>
        <!-- ========================================= CONTENT : END ========================================= -->

        <!-- ========================================= SIDEBAR ========================================= -->

        <div class="col-xs-12 col-md-3 no-margin sidebar ">
            <div class="widget cart-summary">
                <h1 class="border">YOUR CART</h1>
                <div class="body">
                    <ul class="tabled-data no-border inverse-bold">
                        <li>
                            <label>Cart Price</label>
                            <div class="value pull-right" id="tot-cart-price">$<%=cartTotalPrice%></div>
                        </li>
                        <li>
                            <label>freight fee</label>
                            <div class="value pull-right">$10</div>
                        </li>
                    </ul>
                    <ul id="total-price" class="tabled-data inverse-bold no-border">
                        <li>
                            <label>Total Price</label>
                            <div class="value pull-right" id="tot-transfer-price">$<%=cartTotalPrice + 10%></div>
                        </li>
                    </ul>
                    <div class="buttons-holder">
                        <a class="le-button big" href="checkout.jsp">check out</a>
                        <a class="simple-link block" href="index.jsp" >keep shopping</a>
                    </div>
                </div>
            </div><!-- /.widget -->

            <div id="cupon-widget" class="widget">
                <h1 class="border">Use coupon</h1>
                <div class="body">
                    <form>
                        <div class="inline-input">
                            <input data-placeholder="type in coupon code" type="text" />
                            <button class="le-button" type="submit">use</button>
                        </div>
                    </form>
                </div>
            </div><!-- /.widget -->
        </div><!-- /.sidebar -->

        <!-- ========================================= SIDEBAR : END ========================================= -->
    </div>
</section>		<!-- ============================================================= FOOTER ============================================================= -->
        <footer id="footer" class="color-bg">
            <div class="link-list-row" style="margin-top: 0px;">
                <div class="container no-padding">
                    <div class="col-xs-12 col-md-4 ">
                        <div class="contact-info">
                            <div class="footer-logo">
                                <img alt="logo" src="assets/images/group57-logo.png" width="233" height="60"/>
                            </div><!-- /.footer-logo -->
                        </div>
                    </div>
                    <div class="link-widget">
                        <div class="widget">
                            <p class="regular-bold">Developers</p>
                            <p>Yunkun Wang</p>
                            <p>Yue Gu</p>
                            <p>Nan Shu</p>
                        </div>
                    </div>
                    <div class="link-widget">
                        <div class="widget">
                            <p class="regular-bold" style="width: 1000px">Contact us if you have any questions</p>
                            <p style="width: 1000px">Phone number: (+086) 666-6666-6666</p>
                            <p style="width: 1000px">E-mail: group_57@bupt.edu.cn</p>
                            <p style="width: 1000px">Company Address: Beijing University of Posts and Telecommunications<br> Nanfeng Road, Changping District<br> Beijing, China</p>
                        </div>
                    </div>

                </div>
            </div>
        </footer>
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
</body>
</html>
