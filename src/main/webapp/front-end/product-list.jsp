<%@ page import="java.util.List" %>
<%@ page import="com.webproject.project01.VO.SPUVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.webproject.project01.VO.CartVO" %>
<%@ page import="com.webproject.project01.VO.ClassificationVO" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/9/7
  Time: 9:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

	    <title>商品分类 - 慕课商城</title>

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
        //navigation
        String userName = session.getAttribute("userName")==null?"":(String)session.getAttribute("userName");

        //header
        //获取cartVoList   req里需要有userId, 否则session里的cartVoList 为 new ArrayList<>
        request.getRequestDispatcher("/cart/get").include(request,response);
        List<CartVO> cartVoList = session.getAttribute("cartVoList")==null?new ArrayList<>():(List<CartVO>) session.getAttribute("cartVoList");
        double cartTotalPrice = 0;
        int cartNum = 0;
        for(CartVO cartVo : cartVoList){
            cartTotalPrice += cartVo.getTotalPrice();
            cartNum++;
        }
        String userId = session.getAttribute("userId")==null?"":(String) session.getAttribute("userId");

        //nav2
        //category navigation
        request.getRequestDispatcher("/class?param=root").include(request,response);
        List<ClassificationVO> rootClassVoList = (List<ClassificationVO>) session.getAttribute("rootClassVoList");
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
                            <%if(userName.equals("")){
                                System.out.println("if"+userName);%>
                            <li><a href="authentication.jsp">register</a></li>
                            <li><a href="authentication.jsp">log in</a></li>
                            <%}else{
                                System.out.println("else"+userName);%>
                            <li><a href="authentication.jsp">welcome, <%=userName%> &nbsp<img style="border: solid 1px lightgrey;" alt="user_head" src="assets/images/user-figure/defalt-user-figure.jpg" width="25" height="25"/></a></li>
                            <li><a href="" onclick="logout()">log out</a></li>
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
                    <!-- ============================================================= LOGO : END ============================================================= -->
                </div><!-- /.logo-holder -->

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
                                                        <img alt="" src="<%=cartVo.getPicture()%>"/>
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
                                                    <a class="le-button inverse" onclick="goToCart(<%=userId%>)">View Cart</a>
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
                        <!-- ============================================================= SHOPPING CART DROPDOWN : END ============================================================= -->
                </div><!-- /.top-cart-row -->

	        </div><!-- /.container -->

            <!-- ========================================= NAVIGATION ========================================= -->
            <nav id="top-megamenu-nav" class="megamenu-vertical animate-dropdown">
    <div class="container">
        <div class="yamm navbar">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mc-horizontal-menu-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div><!-- /.navbar-header -->
            <div class="collapse navbar-collapse" id="mc-horizontal-menu-collapse">
                <ul class="nav navbar-nav">
                    <%for (ClassificationVO classVo : rootClassVoList){%>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" onclick="loadChildClass(<%=classVo.getId()%>)"><%=classVo.getName()%></a>
                        <ul class="dropdown-menu">
                            <li><div class="yamm-content">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4" >
                                        <h2 style="width: 200px">sub-categories</h2>
                                        <ul id="class-list-<%=classVo.getId()%>" style="width: 200px">
                                            <!-- 待插入 -->
                                        </ul>
                                    </div><!-- /.col -->
                                    <div class="col-xs-12 col-sm-4">
                                        <h2></h2>
                                    </div><!-- /.col -->
                                </div><!-- /.row -->
                            </div><!-- /.yamm-content --></li>
                        </ul>
                    </li>
                    <%}%>
                </ul><!-- /.navbar-nav -->
            </div><!-- /.navbar-collapse -->
        </div><!-- /.navbar -->
    </div><!-- /.container -->
</nav><!-- /.megamenu-vertical -->
            <!-- ========================================= NAVIGATION : END ========================================= -->
        </header>
        <!-- ============================================================= HEADER : END ============================================================= -->
        <section id="category-grid">
            <div class="container">
                <!-- ========================================= SIDEBAR ========================================= -->
                <div class="col-xs-12 col-sm-3 no-margin sidebar narrow">

                    <!-- ========================================= PRODUCT FILTER ========================================= -->
        <div class="widget">
            <h1>Product Filter</h1>
            <div class="body bordered">

                <div class="category-filter">
                    <h2>Category</h2>
                    <hr>
                    <ul>
                        <li><input checked="" class="le-checkbox" type="checkbox"  /> <label>Samsung</label> <span class="pull-right">(2)</span></li>
                        <li><input  class="le-checkbox" type="checkbox" /> <label>Dell</label> <span class="pull-right">(8)</span></li>
                        <li><input  class="le-checkbox" type="checkbox" /> <label>Toshiba</label> <span class="pull-right">(1)</span></li>
                        <li><input  class="le-checkbox" type="checkbox" /> <label>Apple</label> <span class="pull-right">(5)</span></li>
                    </ul>
                </div><!-- /.category-filter -->

                <div class="price-filter">
                    <h2>Price</h2>
                    <hr>
                    <div class="price-range-holder">

                        <input type="text" class="price-slider" value="" >

                        <span class="min-max">
                            Price: $89 - $2899
                        </span>
                        <span class="filter-button">
                            <a href="#">filter</a>
                        </span>
                    </div>
                </div><!-- /.price-filter -->

            </div><!-- /.body -->
        </div><!-- /.widget -->
        <!-- ========================================= PRODUCT FILTER : END ========================================= -->
                    <div class="widget">
            <h1 class="border">特价商品</h1>
            <ul class="product-list">
                <li>
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-01.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">Netbook Acer </a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-02.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">PowerShot Elph 115 16MP Digital Camera</a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-03.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">PowerShot Elph 115 16MP Digital Camera</a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-01.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">Netbook Acer</a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-02.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">PowerShot Elph 115 16MP Digital Camera</a>
                                <div class="price">
                                    <div class="price-prev">￥2000</div>
                                    <div class="price-current">￥1873</div>
                                </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div><!-- /.widget -->
        <!-- ========================================= FEATURED PRODUCTS ========================================= -->
        <div class="widget">
            <h1 class="border">推荐商品</h1>
            <ul class="product-list">

                <li class="sidebar-product-list-item">
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-01.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">Netbook Acer </a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li><!-- /.sidebar-product-list-item -->

                <li class="sidebar-product-list-item">
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-02.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">PowerShot Elph 115 16MP Digital Camera</a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li><!-- /.sidebar-product-list-item -->

                <li class="sidebar-product-list-item">
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-03.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">PowerShot Elph 115 16MP Digital Camera</a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li><!-- /.sidebar-product-list-item -->

                <li class="sidebar-product-list-item">
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-01.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">Netbook Acer </a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li><!-- /.sidebar-product-list-item -->

                <li class="sidebar-product-list-item">
                    <div class="row">
                        <div class="col-xs-4 col-sm-4 no-margin">
                            <a href="#" class="thumb-holder">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-small-02.jpg" />
                            </a>
                        </div>
                        <div class="col-xs-8 col-sm-8 no-margin">
                            <a href="#">PowerShot Elph 115 16MP Digital Camera</a>
                            <div class="price">
                                <div class="price-prev">￥2000</div>
                                <div class="price-current">￥1873</div>
                            </div>
                        </div>
                    </div>
                </li><!-- /.sidebar-product-list-item -->

            </ul><!-- /.product-list -->
        </div><!-- /.widget -->
        <!-- ========================================= FEATURED PRODUCTS : END ========================================= -->
                </div>
                <!-- ========================================= SIDEBAR : END ========================================= -->

                <!-- ========================================= CONTENT ========================================= -->
                <div class="col-xs-12 col-sm-9 no-margin wide sidebar">

<%--                    <section id="recommended-products" class="carousel-holder hover small">--%>

<%--                        <div class="title-nav">--%>
<%--                            <h2 class="inverse">推荐商品</h2>--%>
<%--                            <div class="nav-holder">--%>
<%--                                <a href="#prev" data-target="#owl-recommended-products" class="slider-prev btn-prev fa fa-angle-left"></a>--%>
<%--                                <a href="#next" data-target="#owl-recommended-products" class="slider-next btn-next fa fa-angle-right"></a>--%>
<%--                            </div>--%>
<%--                        </div><!-- /.title-nav -->--%>

<%--                        <div id="owl-recommended-products" class="owl-carousel product-grid-holder">--%>
<%--                            <div class="no-margin carousel-item product-item-holder hover size-medium">--%>
<%--                                <div class="product-item">--%>
<%--                                    <div class="ribbon red"><span>sale</span></div>--%>
<%--                                    <div class="image">--%>
<%--                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-11.jpg" />--%>
<%--                                    </div>--%>
<%--                                    <div class="body">--%>
<%--                                        <div class="title">--%>
<%--                                            <a href="single-product.jsp">LC-70UD1U 70" class aquos 4K ultra HD</a>--%>
<%--                                        </div>--%>
<%--                                        <div class="brand">sharp</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="prices">--%>
<%--                                        <div class="price-current text-right">￥1199.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="hover-area">--%>
<%--                                        <div class="add-cart-button">--%>
<%--                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div><!-- /.carousel-item -->--%>

<%--                            <div class="no-margin carousel-item product-item-holder hover size-medium">--%>
<%--                                <div class="product-item">--%>
<%--                                    <div class="ribbon blue"><span>new!</span></div>--%>
<%--                                    <div class="image">--%>
<%--                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-12.jpg" />--%>
<%--                                    </div>--%>
<%--                                    <div class="body">--%>
<%--                                        <div class="title">--%>
<%--                                            <a href="single-product.jsp">cinemizer OLED 3D virtual reality TV Video</a>--%>
<%--                                        </div>--%>
<%--                                        <div class="brand">zeiss</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="prices">--%>

<%--                                        <div class="price-current text-right">￥1199.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="hover-area">--%>
<%--                                        <div class="add-cart-button">--%>
<%--                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div><!-- /.carousel-item -->--%>

<%--                            <div class="no-margin carousel-item product-item-holder hover size-medium">--%>
<%--                                <div class="product-item">--%>
<%--                                    <div class="image">--%>
<%--                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-13.jpg" />--%>
<%--                                    </div>--%>
<%--                                    <div class="body">--%>
<%--                                        <div class="title">--%>
<%--                                            <a href="single-product.jsp">s2340T23" full HD multi-Touch Monitor</a>--%>
<%--                                        </div>--%>
<%--                                        <div class="brand">dell</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="prices">--%>
<%--                                        <div class="price-current text-right">￥1199.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="hover-area">--%>
<%--                                        <div class="add-cart-button">--%>
<%--                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div><!-- /.carousel-item -->--%>

<%--                            <div class="no-margin carousel-item product-item-holder hover size-medium">--%>
<%--                                <div class="product-item">--%>
<%--                                    <div class="ribbon blue"><span>new!</span></div>--%>
<%--                                    <div class="image">--%>
<%--                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-14.jpg" />--%>
<%--                                    </div>--%>
<%--                                    <div class="body">--%>
<%--                                        <div class="title">--%>
<%--                                            <a href="single-product.jsp">kardon BDS 7772/120 integrated 3D</a>--%>
<%--                                        </div>--%>
<%--                                        <div class="brand">harman</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="prices">--%>
<%--                                        <div class="price-current text-right">￥1199.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="hover-area">--%>
<%--                                        <div class="add-cart-button">--%>
<%--                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div><!-- /.carousel-item -->--%>

<%--                            <div class="no-margin carousel-item product-item-holder hover size-medium">--%>
<%--                                <div class="product-item">--%>
<%--                                    <div class="ribbon green"><span>bestseller</span></div>--%>
<%--                                    <div class="image">--%>
<%--                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-15.jpg" />--%>
<%--                                    </div>--%>
<%--                                    <div class="body">--%>
<%--                                        <div class="title">--%>
<%--                                            <a href="single-product.jsp">netbook acer travel B113-E-10072</a>--%>
<%--                                        </div>--%>
<%--                                        <div class="brand">acer</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="prices">--%>
<%--                                        <div class="price-current text-right">￥1199.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="hover-area">--%>
<%--                                        <div class="add-cart-button">--%>
<%--                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div><!-- /.carousel-item -->--%>

<%--                            <div class="no-margin carousel-item product-item-holder hover size-medium">--%>
<%--                                <div class="product-item">--%>
<%--                                    <div class="image">--%>
<%--                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-16.jpg" />--%>
<%--                                    </div>--%>
<%--                                    <div class="body">--%>
<%--                                        <div class="title">--%>
<%--                                            <a href="single-product.jsp">iPod touch 5th generation,64GB, blue</a>--%>
<%--                                        </div>--%>
<%--                                        <div class="brand">apple</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="prices">--%>
<%--                                        <div class="price-current text-right">￥1199.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="hover-area">--%>
<%--                                        <div class="add-cart-button">--%>
<%--                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div><!-- /.carousel-item -->--%>

<%--                            <div class="no-margin carousel-item product-item-holder hover size-medium">--%>
<%--                                <div class="product-item">--%>
<%--                                    <div class="image">--%>
<%--                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-13.jpg" />--%>
<%--                                    </div>--%>
<%--                                    <div class="body">--%>
<%--                                        <div class="title">--%>
<%--                                            <a href="single-product.jsp">s2340T23" full HD multi-Touch Monitor</a>--%>
<%--                                        </div>--%>
<%--                                        <div class="brand">dell</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="prices">--%>
<%--                                        <div class="price-current text-right">￥1199.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="hover-area">--%>
<%--                                        <div class="add-cart-button">--%>
<%--                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div><!-- /.carousel-item -->--%>

<%--                            <div class="no-margin carousel-item product-item-holder hover size-medium">--%>
<%--                                <div class="product-item">--%>
<%--                                    <div class="ribbon blue"><span>new!</span></div>--%>
<%--                                    <div class="image">--%>
<%--                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-14.jpg" />--%>
<%--                                    </div>--%>
<%--                                    <div class="body">--%>

<%--                                        <div class="title">--%>
<%--                                            <a href="single-product.jsp">kardon BDS 7772/120 integrated 3D</a>--%>
<%--                                        </div>--%>
<%--                                        <div class="brand">harman</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="prices">--%>

<%--                                        <div class="price-current text-right">￥1199.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="hover-area">--%>
<%--                                        <div class="add-cart-button">--%>
<%--                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div><!-- /.carousel-item -->--%>

<%--                        </div><!-- /#recommended-products-carousel .owl-carousel -->--%>
<%--                    </section><!-- /.carousel-holder -->--%>
                    <section id="gaming">
                        <%

                            String key = session.getAttribute("key")==null?"name":(String)session.getAttribute("key");
                            String value = session.getAttribute("value")==null?"":(String) session.getAttribute("value");

                            long totalResult = session.getAttribute("totalResult")==null?0:(long)session.getAttribute("totalResult");

                            List<SPUVO> spuVoList = session.getAttribute("spuVoList")==null?new ArrayList<>():(List<SPUVO>) session.getAttribute("spuVoList");
                        %>
                        <div class="grid-list-products">
                            <h2 class="section-title"><%=totalResult%> results found</h2>

                            <div class="control-bar">
                                <button class="le-button" onclick="clickSort('<%=key%>','<%=value%>')">Sort</button>
                                <div id="popularity-sort" class="le-select" >
                                    <label for="select-sort-key"></label><select id="select-sort-key">
                                        <option value="sales" selected>sort by: popularity</option>
                                        <option value="price">sort by: price</option>
                                        <option value="launchTime">sort by: launch time</option>
                                    </select>
                                </div>
                                <div id="item-count" class="le-select">
                                    <label for="select-sort-dir"></label><select id="select-sort-dir">
                                        <option value="true" selected>ascendent</option>
                                        <option value="false">descendent</option>
                                    </select>
                                </div>
                                <div class="grid-list-buttons">
                                    <ul>
                                        <li id="grid-href" class="grid-list-button-item active"><a data-toggle="tab" href="#grid-view"><i class="fa fa-th-large"></i> Grid</a></li>
                                        <li id="list-fref" class="grid-list-button-item"><a data-toggle="tab" href="#list-view"><i class="fa fa-th-list"></i> List</a></li>
                                    </ul>
                                </div>
                            </div><!-- /.control-bar -->

                            <div class="tab-content">
                                <div id="grid-view" class="products-grid fade tab-pane in active">

                                    <div class="product-grid-holder">
                                        <div class="row no-margin">
                                                <%  int cnt=0;
                                                    for (SPUVO spuvo : spuVoList){%>
                                                    <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover" id="product-list">
                                                        <div class="product-item">
                                                            <div class="ribbon red"><span>sale</span></div>
                                                            <div class="image">
                                                                <img alt="" src="<%=spuvo.getPicture()%>" width="246" height="186"/>
                                                            </div>
                                                            <div class="body">
                                                                <div class="label-discount green">-50% sale</div>
                                                                <div class="title">
                                                                    <a href="single-product.jsp?spuIndex=<%=cnt%>&skuIndex=0" onclick="checkProduct(<%=spuvo.getId()%>)"><%=spuvo.getName()%></a>
                                                                </div>
                                                                <div class="brand"><%=spuvo.getClassificationVO().getName()%></div>
                                                            </div>
                                                            <div class="prices">
                                                                <div class="price-prev">$<%=spuvo.getPrice()%></div>
                                                                <div class="price-current pull-right">$<%=spuvo.getPrice()%></div>
                                                            </div>
                                                            <div class="hover-area">
                                                                <div class="add-cart-button">
                                                                    <a href="single-product.jsp?spuIndex=<%=cnt%>&skuIndex=0" onclick="checkProduct(<%=spuvo.getId()%>)" class="le-button">Add To Cart</a>
                                                                </div>
                                                            </div>
                                                        </div><!-- /.product-item -->
                                                    </div><!-- /.product-item-holder -->
                                                <%cnt++;}%>

<%--                                            <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">--%>
<%--                                                <div class="product-item">--%>
<%--                                                    <div class="ribbon blue"><span>new!</span></div>--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-02.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">White lumia 9001</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">nokia</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="prices">--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="price-current pull-right">￥1199.00</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="hover-area">--%>
<%--                                                        <div class="add-cart-button">--%>
<%--                                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.product-item -->--%>
<%--                                            </div><!-- /.product-item-holder -->--%>
<%--            --%>
<%--                                            <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">--%>
<%--                                                <div class="product-item">--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-03.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">POV Action Cam</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="prices">--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="price-current pull-right">￥1199.00</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="hover-area">--%>
<%--                                                        <div class="add-cart-button">--%>
<%--                                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.product-item -->--%>
<%--                                            </div><!-- /.product-item-holder -->--%>
<%--            --%>
<%--                                            <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">--%>
<%--                                                <div class="product-item">--%>
<%--                                                    <div class="ribbon red"><span>sale</span></div>--%>
<%--                                                    <div class="ribbon green"><span>bestseller</span></div>--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-04.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">Netbook Acer TravelMate B113-E-10072</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">acer</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="prices">--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="price-current pull-right">￥1199.00</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="hover-area">--%>
<%--                                                        <div class="add-cart-button">--%>
<%--                                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.product-item -->--%>
<%--                                            </div><!-- /.product-item-holder -->--%>
<%--            --%>
<%--                                            <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">--%>
<%--                                                <div class="product-item">--%>
<%--                                                    <div class="ribbon red"><span>sale</span></div>--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-01.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount green">-50% sale</div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">VAIO Fit Laptop - Windows 8 SVF14322CXW</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="prices">--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="price-current pull-right">￥1199.00</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="hover-area">--%>
<%--                                                        <div class="add-cart-button">--%>
<%--                                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.product-item -->--%>
<%--                                            </div><!-- /.product-item-holder -->--%>
<%--            --%>
<%--                                            <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">--%>
<%--                                                <div class="product-item">--%>
<%--                                                    <div class="ribbon blue"><span>new!</span></div>--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-02.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">White lumia 9001</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">nokia</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="prices">--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="price-current pull-right">￥1199.00</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="hover-area">--%>
<%--                                                        <div class="add-cart-button">--%>
<%--                                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.product-item -->--%>
<%--                                            </div><!-- /.product-item-holder -->--%>
<%--            --%>
<%--                                            <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">--%>
<%--                                                <div class="product-item">--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-03.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">POV Action Cam</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="prices">--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="price-current pull-right">￥1199.00</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="hover-area">--%>
<%--                                                        <div class="add-cart-button">--%>
<%--                                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.product-item -->--%>
<%--                                            </div><!-- /.product-item-holder -->--%>
<%--            --%>
<%--                                            <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">--%>
<%--                                                <div class="product-item">--%>
<%--                                                    <div class="ribbon red"><span>sale</span></div>--%>
<%--                                                    <div class="ribbon green"><span>bestseller</span></div>--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-04.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">Netbook Acer TravelMate B113-E-10072</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">acer</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="prices">--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="price-current pull-right">￥1199.00</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="hover-area">--%>
<%--                                                        <div class="add-cart-button">--%>
<%--                                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.product-item -->--%>
<%--                                            </div><!-- /.product-item-holder -->--%>
<%--            --%>
<%--                                            <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">--%>
<%--                                                <div class="product-item">--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-03.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">POV Action Cam</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="prices">--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="price-current pull-right">￥1199.00</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="hover-area">--%>
<%--                                                        <div class="add-cart-button">--%>
<%--                                                            <a href="single-product.jsp" class="le-button">加入购物车</a>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.product-item -->--%>
<%--                                            </div><!-- /.product-item-holder -->--%>

                                        </div><!-- /.row -->
                                    </div><!-- /.product-grid-holder -->

                                    <div class="pagination-holder">
                                        <%
                                            boolean hasNext = session.getAttribute("hasNext")==null?false:(boolean) session.getAttribute("hasNext");
                                            boolean hasPrev = session.getAttribute("hasPrev")==null?false:(boolean) session.getAttribute("hasPrev");
                                            int totalPage = session.getAttribute("totalPage")==null?0:(int) session.getAttribute("totalPage");
                                            int curPage = session.getAttribute("curPage")==null?0:(int) session.getAttribute("curPage");
                                            String sortKey = session.getAttribute("sortKey")==null?"sales":(String) session.getAttribute("sortKey");
                                            Boolean sortAsc = session.getAttribute("sortAsc")==null?true:(Boolean) session.getAttribute("sortAsc");
                                        %>
                                        <div class="row">

                                            <div class="col-xs-12 col-sm-6 text-left">
                                                <ul class="pagination ">
                                                    <li>
                                                        <% if(hasPrev){%>
                                                        <a onclick="changePage('<%=key%>','<%=value%>','<%=sortKey%>',<%=sortAsc%>,<%=curPage-1%>)">Prev</a>
                                                        <%}%>
                                                    </li>
                                                    <%for(int i=1;i<=totalPage;i++){%>
                                                        <li><a <%if(i==curPage){%>style="border-color: orangered"<%}%> onclick="changePage('<%=key%>','<%=value%>','<%=sortKey%>',<%=sortAsc%>,this.innerText)"><%=i%></a></li>
                                                    <%}%>
<%--                                                    <% if(curPage != 1){%>--%>
<%--                                                    <li><a onclick="changePage('<%=key%>','<%=value%>','<%=sortKey%>',<%=sortAsc%>,this.innerText)">1</a></li>--%>
<%--                                                    <% if(curPage != 2){%>--%>
<%--                                                    <li><a href="#">...</a></li>--%>
<%--                                                    <%}%>--%>
<%--                                                    <%}%>--%>
<%--                                                    <li class="current"><a href="#"><%=curPage%></a></li>--%>
<%--                                                    <% if(curPage != totalPage){%>--%>
<%--                                                    <% if(curPage != totalPage-1){%>--%>
<%--                                                    <li><a href="#">...</a></li>--%>
<%--                                                    <%}%>--%>
<%--                                                    <li><a href="#"><%=totalPage%></a></li>--%>
<%--                                                    <%}%>--%>
                                                    <li>
                                                        <% if(hasNext){%>
                                                        <a onclick="changePage('<%=key%>','<%=value%>','<%=sortKey%>',<%=sortAsc%>,<%=curPage+1%>)">Next</a>
                                                        <%}%>
                                                    </li>
                                                </ul>
                                            </div>

                                            <div class="col-xs-12 col-sm-6">
                                                <div class="result-counter">
                                                    Showing <span><%=(curPage-1)*9+1%>-<%=(curPage-1)*9+spuVoList.size()%></span> of <span><%=totalResult%></span> results
                                                </div>
                                            </div>

                                        </div><!-- /.row -->
                                    </div><!-- /.pagination-holder -->
                                </div><!-- /.products-grid #grid-view -->

                                <div id="list-view" class="products-grid fade tab-pane">
                                    <div class="products-list">

                                        <% for(SPUVO spuVo : spuVoList){%>
                                            <div class="product-item product-item-holder">
                                                <div class="ribbon red"><span>sale</span></div>
                                                <div class="ribbon blue"><span>new!</span></div>
                                                <div class="row">
                                                    <div class="no-margin col-xs-12 col-sm-4 image-holder">
                                                        <div class="image">
                                                            <img alt="" src="<%=spuVo.getPicture()%>"  width="246" height="186"/>
                                                        </div>
                                                    </div><!-- /.image-holder -->
                                                    <div class="no-margin col-xs-12 col-sm-5 body-holder">
                                                        <div class="body">
                                                            <div class="label-discount green">-50% sale</div>
                                                            <div class="title">
                                                                <a href="single-product.jsp"><%=spuVo.getName()%></a>
                                                            </div>
                                                            <div class="brand"><%=spuVo.getClassificationVO().getName()%></div>
                                                            <div class="excerpt">
                                                                <p><%=spuVo.getDescription()%></p>
                                                            </div>
                                                        </div>
                                                    </div><!-- /.body-holder -->
                                                    <div class="no-margin col-xs-12 col-sm-3 price-area">
                                                        <div class="right-clmn">
                                                            <div class="price-current">$<%=spuVo.getPrice()%></div>
                                                            <div class="price-prev">$<%=spuVo.getPrice()%></div>
                                                            <div class="availability"><label>launch time:</label><span class="available"> <%=spuVo.getLaunchTime()%></span></div>
                                                            <a class="le-button" href="#">Add To Cart</a>
                                                        </div>
                                                    </div><!-- /.price-area -->
                                                </div><!-- /.row -->
                                            </div><!-- /.product-item -->
                                        <%}%>
<%--                                        <div class="product-item product-item-holder">--%>
<%--                                            <div class="ribbon red"><span>sale</span></div>--%>
<%--                                            <div class="ribbon blue"><span>new!</span></div>--%>
<%--                                            <div class="row">--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-4 image-holder">--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-01.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.image-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-5 body-holder">--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount green">-50% sale</div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">VAIO Fit Laptop - Windows 8 SVF14322CXW</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                        <div class="excerpt">--%>
<%--                                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lobortis euismod erat sit amet porta. Etiam venenatis ac diam ac tristique. Morbi accumsan consectetur odio ut tincidunt.</p>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.body-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-3 price-area">--%>
<%--                                                    <div class="right-clmn">--%>
<%--                                                        <div class="price-current">￥1199.00</div>--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="availability"><label>存货:</label><span class="available">  现货</span></div>--%>
<%--                                                        <a class="le-button" href="#">加入购物车</a>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.price-area -->--%>
<%--                                            </div><!-- /.row -->--%>
<%--                                        </div><!-- /.product-item -->--%>


<%--                                        <div class="product-item product-item-holder">--%>
<%--                                            <div class="ribbon green"><span>bestseller</span></div>--%>
<%--                                            <div class="row">--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-4 image-holder">--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-02.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.image-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-5 body-holder">--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">VAIO Fit Laptop - Windows 8 SVF14322CXW</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                        <div class="excerpt">--%>
<%--                                                            <div class="star-holder">--%>
<%--                                                                <div class="star" data-score="4"></div>--%>
<%--                                                            </div>--%>
<%--                                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lobortis euismod erat sit amet porta. Etiam venenatis ac diam ac tristique. Morbi accumsan consectetur odio ut tincidunt.</p>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.body-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-3 price-area">--%>
<%--                                                    <div class="right-clmn">--%>
<%--                                                        <div class="price-current">￥1199.00</div>--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="availability"><label>存货:</label><span class="not-available">无货</span></div>--%>
<%--                                                        <a class="le-button disabled" href="#">加入购物车</a>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.price-area -->--%>
<%--                                            </div><!-- /.row -->--%>
<%--                                        </div><!-- /.product-item -->--%>


<%--                                        <div class="product-item product-item-holder">--%>
<%--                                            <div class="ribbon red"><span>sell</span></div>--%>
<%--                                            <div class="row">--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-4 image-holder">--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-03.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.image-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-5 body-holder">--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">VAIO Fit Laptop - Windows 8 SVF14322CXW</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                        <div class="excerpt">--%>
<%--                                                            <div class="star-holder">--%>
<%--                                                                <div class="star" data-score="2"></div>--%>
<%--                                                            </div>--%>
<%--                                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lobortis euismod erat sit amet porta. Etiam venenatis ac diam ac tristique. Morbi accumsan consectetur odio ut tincidunt. </p>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.body-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-3 price-area">--%>
<%--                                                    <div class="right-clmn">--%>
<%--                                                        <div class="price-current">￥1199.00</div>--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="availability"><label>存货:</label><span class="available">现货</span></div>--%>
<%--                                                        <a class="le-button" href="#">加入购物车</a>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.price-area -->--%>
<%--                                            </div><!-- /.row -->--%>
<%--                                        </div><!-- /.product-item -->--%>

<%--                                        <div class="product-item product-item-holder">--%>
<%--                                            <div class="row">--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-4 image-holder">--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-04.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.image-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-5 body-holder">--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount green">-50% sale</div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">VAIO Fit Laptop - Windows 8 SVF14322CXW</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                        <div class="excerpt">--%>
<%--                                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lobortis euismod erat sit amet porta. Etiam venenatis ac diam ac tristique. Morbi accumsan consectetur odio ut tincidunt. </p>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.body-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-3 price-area">--%>
<%--                                                    <div class="right-clmn">--%>
<%--                                                        <div class="price-current">￥1199.00</div>--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="availability"><label>存货:</label><span class="available">  现货</span></div>--%>
<%--                                                        <a class="le-button" href="#">加入购物车</a>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.price-area -->--%>
<%--                                            </div><!-- /.row -->--%>
<%--                                        </div><!-- /.product-item -->--%>

<%--                                        <div class="product-item product-item-holder">--%>
<%--                                            <div class="ribbon green"><span>bestseller</span></div>--%>
<%--                                            <div class="row">--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-4 image-holder">--%>
<%--                                                    <div class="image">--%>
<%--                                                        <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-05.jpg" />--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.image-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-5 body-holder">--%>
<%--                                                    <div class="body">--%>
<%--                                                        <div class="label-discount clear"></div>--%>
<%--                                                        <div class="title">--%>
<%--                                                            <a href="single-product.jsp">VAIO Fit Laptop - Windows 8 SVF14322CXW</a>--%>
<%--                                                        </div>--%>
<%--                                                        <div class="brand">sony</div>--%>
<%--                                                        <div class="excerpt">--%>
<%--                                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lobortis euismod erat sit amet porta. Etiam venenatis ac diam ac tristique. Morbi accumsan consectetur odio ut tincidunt.</p>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.body-holder -->--%>
<%--                                                <div class="no-margin col-xs-12 col-sm-3 price-area">--%>
<%--                                                    <div class="right-clmn">--%>
<%--                                                        <div class="price-current">￥1199.00</div>--%>
<%--                                                        <div class="price-prev">￥1399.00</div>--%>
<%--                                                        <div class="availability"><label>存货:</label><span class="available">  现货</span></div>--%>
<%--                                                        <a class="le-button" href="#">加入购物车</a>--%>
<%--                                                    </div>--%>
<%--                                                </div><!-- /.price-area -->--%>
<%--                                            </div><!-- /.row -->--%>
<%--                                        </div><!-- /.product-item -->--%>

                                    </div><!-- /.products-list -->

                                    <div class="pagination-holder">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6 text-left">
                                                <ul class="pagination ">
                                                    <li>
                                                        <% if(hasPrev){%>
                                                        <a onclick="changePage('<%=key%>','<%=value%>','<%=sortKey%>',<%=sortAsc%>,<%=curPage-1%>)">Prev</a>
                                                        <%}%>
                                                    </li>
                                                    <%for(int i=1;i<=totalPage;i++){%>
                                                    <li><a <%if(i==curPage){%>style="border-color: orangered"<%}%> onclick="changePage('<%=key%>','<%=value%>','<%=sortKey%>',<%=sortAsc%>,this.innerText)"><%=i%></a></li>
                                                    <%}%>
                                                    <li>
                                                        <% if(hasNext){%>
                                                        <a onclick="changePage('<%=key%>','<%=value%>','<%=sortKey%>',<%=sortAsc%>,<%=curPage+1%>)">Next</a>
                                                        <%}%>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="col-xs-12 col-sm-6">
                                                <div class="result-counter">
                                                    Showing <span><%=(curPage-1)*9+1%>-<%=(curPage-1)*9+spuVoList.size()%></span> of <span><%=totalResult%></span> results
                                                </div><!-- /.result-counter -->
                                            </div>
                                        </div><!-- /.row -->
                                    </div><!-- /.pagination-holder -->

                                </div><!-- /.products-grid #list-view -->

                            </div><!-- /.tab-content -->
                        </div><!-- /.grid-list-products -->
                    </section><!-- /#gaming -->
                </div><!-- /.col -->
                <!-- ========================================= CONTENT : END ========================================= -->
            </div><!-- /.container -->
        </section><!-- /#category-grid -->
        <!-- ============================================================= FOOTER ============================================================= -->
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
                        <!-- ============================================================= FEATURED PRODUCTS : END ============================================================= -->
                    </div><!-- /.col -->

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
</body>
</html>
