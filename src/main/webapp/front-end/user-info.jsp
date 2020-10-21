<%@ page import="com.webproject.project01.VO.CartVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.webproject.project01.VO.ClassificationVO" %>
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

        <title>Personal Information</title>
        <link rel="stylesheet" href="assets/css/change_css/bootstrap-reboot.min.css">
        <link rel="stylesheet" href="assets/css/change_css/bootstrap-grid.min.css">
        <link rel="stylesheet" href="assets/css/change_css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/change_css/nouislider.min.css">
        <link rel="stylesheet" href="assets/css/change_css/select2.min.css">
        <link rel="stylesheet" href="assets/css/change_css/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="assets/css/change_css/ionicons.min.css">
        <link rel="stylesheet" href="assets/css/change_css/main1.css">
        <link rel="stylesheet" href="assets/css/change_css/change_position.css">
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
		
		<!-- change-new-->
		<link rel="stylesheet" href="assets/css/change-new.css">

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
<%
    request.getRequestDispatcher("/user/info?userId="+userId).include(request,response);
    String email = (String) session.getAttribute("email");
    userName = (String) session.getAttribute("userName");
    String phone = (String) session.getAttribute("phone");
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
                            <li><a href="register.jsp">register</a></li>
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
<!-- ============================================================= TOP NAVIGATION : END ============================================================= -->       <!-- ============================================================= HEADER ============================================================= -->
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
                                        <span class="lbl">Your Cart:</span>
                                        <span class="total-price" style="width: auto">
                                            <span class="value">$<%=cartTotalPrice%></span>
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
                                <li class="dropdown menu-item">
                                    <a>Categories: </a>
                                </li>
                                <%for (ClassificationVO classVo : rootClassVoList){%>
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" onclick="loadChildClass(<%=classVo.getId()%>)"><%=classVo.getName()%></a>
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

<!-- ============================================================= HEADER : END ============================================================= -->       <!-- ========================================= CONTENT ========================================= -->

<section id="checkout-page">
    <main class="main main--breadcrumb">

        <div class="container" style="margin-left: -80px;">
            <div class="row">
                <div class="col-10 col-md-5 col-lg-4 col-xl-5">

                    <!-- user -->
                    <div class="user" id="user">
                        <div class="user__head">
                            <div class="user__img">
                                <img src="assets/images/user-figure/defalt-user-figure.jpg" style="margin-top: 10px;margin-left: 3px;" alt="">
<%--                                style="position: relative;top:10%;left:10%;height:80%;width: 100%;"--%>
                            </div>
                        </div>
                        <div class="user__title">
                            <h2>Group 57</h2>
                            <p>Customer</p>
                        </div>

                        <ul class="user__list">
                            <li><span>User Name:</span> <span><%=userName%></span></li>
                            <li><span>E-Mail:</span> <span><%=email%></span></li>
                            <li><span>Tel-Number:</span> <span><%=phone%></span></li>
                        </ul>
                    </div>
                    <!-- end user -->

                </div>

                <div class="col-10 col-md-7 col-lg-8 col-xl-5" style="margin-left: 150px;">

                        <div  class="tab-user" id="tab-3" role="tabpanel" aria-labelledby="tab-3">
                            <!-- form -->
                            <form action="#" class="form">
                                <div class="row">
                                    <div class="col-12">
                                        <h2 class="form__title">Change Information</h2>
                                    </div>

                                    <div class="col-10 col-lg-6">
                                        <div class="form__group1">
                                            <label for="modi-name-input" class="form__label">User Name:</label>
                                            <input name="login" id="modi-name-input" type="text" class="form__input" placeholder="<%=userName%>">
                                        </div>
                                    </div>
                                    <div class="col-10 col-lg-6">
                                        <button class="form__btn" type="button" onclick="updateName(<%=userId%>,$('#modi-name-input').val())"><span>Save</span></button>
                                    </div>

                                    <div class="col-10 col-lg-6">
                                        <div class="form__group1">
                                            <label for="modi-phone-input" class="form__label">Tel-Number:</label>
                                            <input name="login" id="modi-phone-input" type="text" class="form__input" placeholder="<%=phone%>">
                                        </div>
                                    </div>
                                    <div class="col-10 col-lg-6">
                                        <button class="form__btn" type="button" onclick="updatePhone(<%=userId%>,$('#modi-phone-input').val())"><span>Save</span></button>
                                    </div>

                                    <div class="col-10 col-lg-6">
                                        <div class="form__group1">
                                            <label for="modi-email-input" class="form__label">E-Mail:</label>
                                            <input name="login" id="modi-email-input" type="text" class="form__input" placeholder="<%=email%>">
                                        </div>
                                    </div>
                                    <div class="col-10 col-lg-6">
                                        <button class="form__btn" type="button" onclick="updateEmail(<%=userId%>,$('#modi-email-input').val())"><span>Save</span></button>
                                    </div>


                                </div>
                            </form>
                            <!-- end form -->

                            <!-- form -->
                            <form action="#" class="form">
                                <div class="row">
                                    <div class="col-12">
                                        <h2 class="form__title">Change password</h2>
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <div class="form__group">
                                            <label for="old-pwd" class="form__label">Old password:</label>
                                            <input name="oldpass" id="old-pwd" type="password" class="form__input">
                                        </div>
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <div class="form__group">
                                            <label for="new-pwd" class="form__label">New Password:</label>
                                            <input name="newpass" id="new-pwd" type="password" class="form__input">
                                        </div>
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <div class="form__group">
                                            <label for="confirm-pwd" class="form__label">Confirm New Password:</label>
                                            <input name="confirmpass" id="confirm-pwd" type="password" class="form__input" onchange="checkConsistentPwd($('#new-pwd').val(),$('#confirm-pwd').val())">
                                        </div>
                                        <div id="notice"></div>
                                    </div>
                                    <div class="col-12 col-lg-4">
                                        <button class="form__btn" style="margin-left: 38%;
                                        " type="button" onclick="updatePwd(<%=userId%>,$('#old-pwd').val(),$('#new-pwd').val())"><span>Save</span></button>
                                    </div>
                                </div>
                            </form>
                            <!-- end form -->
                        </div>
                    </div>
                </div>

                
            </div>
    </main>
    <!-- end main content -->
            </section><!-- /#shipping-address -->


           
<!-- ========================================= CONTENT : END ========================================= -->      <!-- ============================================================= FOOTER ============================================================= -->
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
                        <a href="single-product.html">Netbook Acer Travel B113-E-10072</a>
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
                        <a href="single-product.html">PowerShot Elph 115 16MP Digital Camera</a>
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
                        <a href="single-product.html">PowerShot Elph 115 16MP Digital Camera</a>
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
                        <a href="single-product.html">HP Scanner 2910P</a>
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
                        <a href="single-product.html">Galaxy Tab 3 GT-P5210 16GB, Wi-Fi, 10.1in - White</a>
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
                        <a href="single-product.html">PowerShot Elph 115 16MP Digital Camera</a>
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
                        <a href="single-product.html">Galaxy Tab GT-P5210, 10" 16GB Wi-Fi</a>
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
                        <a href="single-product.html">PowerShot Elph 115 16MP Digital Camera</a>
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
                        <a href="single-product.html">Surface RT 64GB, Wi-Fi, 10.6in - Dark Titanium</a>
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
            <li><a href="category-grid.html">laptops &amp; computers</a></li>
            <li><a href="category-grid.html">Cameras &amp; Photography</a></li>
            <li><a href="category-grid.html">Smart Phones &amp; Tablets</a></li>
            <li><a href="category-grid.html">Video Games &amp; Consoles</a></li>
            <li><a href="category-grid.html">TV &amp; Audio</a></li>
            <li><a href="category-grid.html">Gadgets</a></li>
            <li><a href="category-grid.html">Car Electronic &amp; GPS</a></li>
            <li><a href="category-grid.html">Accesories</a></li>
        </ul>
    </div><!-- /.widget -->
</div><!-- /.link-widget -->

<div class="link-widget">
    <div class="widget">
        <h3>热门商品</h3>
        <ul>
            <li><a href="category-grid.html">Find a Store</a></li>
            <li><a href="category-grid.html">About Us</a></li>
            <li><a href="category-grid.html">Contact Us</a></li>
            <li><a href="category-grid.html">Weekly Deals</a></li>
            <li><a href="category-grid.html">Gift Cards</a></li>
            <li><a href="category-grid.html">Recycling Program</a></li>
            <li><a href="category-grid.html">Community</a></li>
            <li><a href="category-grid.html">Careers</a></li>

        </ul>
    </div><!-- /.widget -->
</div><!-- /.link-widget -->

<div class="link-widget">
    <div class="widget">
        <h3>最近浏览</h3>
        <ul>
            <li><a href="category-grid.html">My Account</a></li>
            <li><a href="category-grid.html">Order Tracking</a></li>
            <li><a href="category-grid.html">Wish List</a></li>
            <li><a href="category-grid.html">Customer Service</a></li>
            <li><a href="category-grid.html">Returns / Exchange</a></li>
            <li><a href="category-grid.html">FAQs</a></li>
            <li><a href="category-grid.html">Product Support</a></li>
            <li><a href="category-grid.html">Extended Service Plans</a></li>
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
<!-- ============================================================= FOOTER : END ============================================================= -->   </div><!-- /.wrapper -->

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
    <script>
        $("#createlink").click(function(){
            $(".billing-address").slideDown();
        });
        
    </script>

</body>
</html>