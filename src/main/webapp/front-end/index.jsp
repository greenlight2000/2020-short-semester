<%@ page import="com.webproject.project01.VO.CartVO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.webproject.project01.VO.ClassificationVO" %>
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
	    <meta name="keywords" content="MediaCenter, Template, eCommerce">
	    <meta name="robots" content="all">

	    <title>慕课商城</title>
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

<script src="assets/js/fun.js"></script>
<script src="assets/js/jquery-1.10.2.min.js"></script>
<script src="assets/js/template.js"></script>
<script id="tpl" type="text/html">
    {{each spuVoList}}
    <div class="col-sm-4 col-md-3 no-margin product-item-holder hover">
        <div class="product-item">
            <div class="{{ribbonType}}"><span>{{ribbonText}}</span></div>
            <div class="image">
                <img alt="" src="{{$value.picture}}" width="246" height="186"/>
            </div>
            <div class="body">
                <div class="label-discount clear"></div>
                <div class="title">
                    <a onclick="checkProduct('{{$value.id}}')">{{$value.name}}1</a>
                </div>
                <div class="brand">{{$value.classificationVO.name}}</div>
            </div>
            <div class="prices">
                <div class="price-prev">\${{$value.price}}</div>
                <div class="price-current pull-right">\${{$value.price}}</div>
            </div>
            <div class="hover-area">
                <div class="add-cart-button">
                    <a class="le-button" onclick="checkProduct('{{$value.id}}')">Add To Cart</a>
                </div>
                <div class="wish-compare">
                    <a class="btn-add-to-wishlist" href="#">add to wishlist</a>
                    <a class="btn-add-to-compare" href="#">compare</a>
                </div>
            </div>
        </div>
    </div>
    {{/each}}
</script>
<script type="text/javascript">
    var recPageNum = 1;
    var newPageNum = 1;
    var bsPageNum = 1;
    loadBestSellSPU(bsPageNum);
    loadNewSPU(newPageNum);
    loadRecommendSPU(recPageNum);

    console.log("index.jsp: finish script");
</script>
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
                            <%if(userName.equals("")){%>
                            <li><a href="authentication.jsp">register</a></li>
                            <li><a href="authentication.jsp">log in</a></li>
                            <%}else{%>
                            <li><a href="authentication.jsp">welcome, <%=userName%> &nbsp<img style="border: solid 1px lightgrey;" alt="user_head" src="assets/images/user-figure/defalt-user-figure.jpg" width="25" height="25"/></a></li>
                            <li><a href="" onclick="logout()">log out</a></li>
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
                    <!-- ============================================================= SHOPPING CART DROPDOWN : END ============================================================= -->		</div><!-- /.top-cart-row -->

            </div><!-- /.container -->
        </header>
<!-- ============================================================= HEADER : END ============================================================= -->		<div id="top-banner-and-menu">
	<div class="container">
		
		<div class="col-xs-12 col-sm-4 col-md-3 sidemenu-holder">
			<!-- ================================== TOP NAVIGATION ================================== -->
<div class="side-menu animate-dropdown">
    <div class="head"><i class="fa fa-list"></i> All Categories </div>
    <nav class="yamm megamenu-horizontal" role="navigation">
        <ul class="nav">
            <%for (ClassificationVO classVo : rootClassVoList){%>
            <li class="dropdown menu-item">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" onclick="loadChildClass(<%=classVo.getId()%>)"><%=classVo.getName()%></a>
                <ul class="dropdown-menu mega-menu">
                    <li class="yamm-content">
                        <!-- ================================== MEGAMENU VERTICAL ================================== -->
                        <div class="row">
                            <div class="col-xs-12 col-lg-4">
                                <ul id="class-list-<%=classVo.getId()%>">
                                    <%-- loadChildClass()写入 --%>
                                </ul>
                            </div>

                            <div class="dropdown-banner-holder">
                                <a href="#"><img alt="" src="" /></a>
                            </div>
                        </div>
<!-- ================================== MEGAMENU VERTICAL ================================== -->                        
                    </li>
                </ul>
            </li><!-- /.menu-item -->
            <%}%>
            <!--<li><a href="http://themeforest.net/item/media-center-electronic-ecommerce-html-template/8178892?ref=shaikrilwan">Buy this Theme</a></li>-->
        </ul><!-- /.nav -->
    </nav><!-- /.megamenu-horizontal -->
</div><!-- /.side-menu -->
<!-- ================================== TOP NAVIGATION : END ================================== -->
        </div><!-- /.sidemenu-holder -->


		<div class="col-xs-12 col-sm-8 col-md-9 homebanner-holder">
			<!-- ========================================== SECTION – HERO ========================================= -->
			
<div id="hero">
	<div id="owl-main" class="owl-carousel owl-inner-nav owl-ui-sm">
		
		<div class="item" style="background-image: url();">
			<div class="container-fluid">
				<div class="caption vertical-center text-left">
					<div class="big-text fadeInDown-1">
						Highest Discount up to<span class="big"><span class="sign">$</span>40</span>
					</div>

					<div class="excerpt fadeInDown-2">
						play music<br>
						enjoy music<br>
						create music
					</div>
					<div class="small fadeInDown-2">
						Flash Sales last 5 days
					</div>
					<div class="button-holder fadeInDown-3">
						<a href="single-product.jsp" class="big le-button ">Purchase</a>
					</div>
				</div><!-- /.caption -->
			</div><!-- /.container-fluid -->
		</div><!-- /.item -->

		<div class="item" style="background-image: url();">
			<div class="container-fluid">
				<div class="caption vertical-center text-left">
					<div class="big-text fadeInDown-1">
						WANT TO HAVE A<span class="big"><span class="sign">$</span>20</span>DISCOUNT？
					</div>

					<div class="excerpt fadeInDown-2">
						COME &<br>SHOP<br>
					</div>
					<div class="small fadeInDown-2">
						more discounts to be discovered
					</div>
					<div class="button-holder fadeInDown-3">
						<a href="single-product.jsp" class="big le-button ">purchase</a>
					</div>
				</div><!-- /.caption -->
			</div><!-- /.container-fluid -->
		</div><!-- /.item -->

	</div><!-- /.owl-carousel -->
</div>
			
<!-- ========================================= SECTION – HERO : END ========================================= -->			
		</div><!-- /.homebanner-holder -->

	</div><!-- /.container -->
</div><!-- /#top-banner-and-menu -->

<!-- ========================================= HOME BANNERS ========================================= -->
<section id="banner-holder" class="wow fadeInUp">
    <div class="container">
        <div class="col-xs-12 col-lg-6 no-margin banner">
            <a href="product-list.jsp">
                <div class="banner-text theblue">
                    <h1 style="font-family:'Microsoft Yahei';">尝尝鲜</h1>
                    <span class="tagline">查看最新分类</span>
                </div>
                <img class="banner-image" alt="" src="assets/images/blank.gif" data-echo="assets/images/banners/banner-narrow-01.jpg" />
            </a>
        </div>
        <div class="col-xs-12 col-lg-6 no-margin text-right banner">
            <a href="product-list.jsp">
                <div class="banner-text right">
                    <h1 style="font-family:'Microsoft Yahei';">时尚流行</h1>
                    <span class="tagline">查看最新上架</span>
                </div>
                <img class="banner-image" alt="" src="assets/images/blank.gif" data-echo="assets/images/banners/banner-narrow-02.jpg" />
            </a>
        </div>
    </div><!-- /.container -->
</section><!-- /#banner-holder -->
<!-- ========================================= HOME BANNERS : END ========================================= -->
<div id="products-tab" class="wow fadeInUp">
    <div class="container">
        <div class="tab-holder">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" >
                <li class="active"><a href="#featured" data-toggle="tab">recommended</a></li>
                <li><a href="#new-arrivals" data-toggle="tab">newest</a></li>
                <li><a href="#top-sales" data-toggle="tab">best seller</a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <%--   recommended   --%>
                <div class="tab-pane active" id="featured">
                    <div id="div-recommend-spu" class="product-grid-holder">
                        <!-- 待插入 -->
                    </div>
                    <div class="loadmore-holder text-center">
                        <a class="btn-loadmore" onclick="loadRecommendSPU(++recPageNum)">
                            <i class="fa fa-plus"></i>
                            load more</a>
                    </div> 

                </div>
                <%--   newest   --%>
                <div class="tab-pane" id="new-arrivals">
                    <div id="div-new-spu" class="product-grid-holder">
                        <!-- 待插入 -->
                    </div>
                    <div class="loadmore-holder text-center">
                        <a class="btn-loadmore" onclick=loadNewSPU(++newPageNum)>
                            <i class="fa fa-plus"></i>
                            load more</a>
                    </div> 

                </div>
                <!-- best seller -->
                <div class="tab-pane" id="top-sales">
                    <div id="div-bs-spu" class="product-grid-holder">
                        <!-- 待插入 -->
                    </div>
                    <div class="loadmore-holder text-center">
                        <a class="btn-loadmore" onclick="loadBestSellSPU(++bsPageNum)">
                            <i class="fa fa-plus"></i>
                            load more</a>
                    </div> 
                </div>
            </div>
        </div>
    </div>
</div>
<!-- ========================================= BEST SELLERS ========================================= -->
<section id="bestsellers" class="color-bg wow fadeInUp">
    <div class="container">
        <h1 class="section-title">销量最佳</h1>

        <div class="product-grid-holder medium">
            <div class="col-xs-12 col-md-7 no-margin">
                
                <div class="row no-margin">
                    <div class="col-xs-12 col-sm-4 no-margin product-item-holder size-medium hover">
                        <div class="product-item">
                            <div class="image">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-05.jpg" />
                            </div>
                            <div class="body">
                                <div class="label-discount clear"></div>
                                <div class="title">
                                    <a href="single-product.jsp">beats studio headphones official one</a>
                                </div>
                                <div class="brand">beats</div>
                            </div>
                            <div class="prices">

                                <div class="price-current text-right">￥1199.00</div>
                            </div>
                            <div class="hover-area">
                                <div class="add-cart-button">
                                    <a href="single-product.jsp" class="le-button">加入购物车</a>
                                </div>
                                <div class="wish-compare">
                                    <a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
                                    <a class="btn-add-to-compare" href="#">Compare</a>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.product-item-holder -->

                    <div class="col-xs-12 col-sm-4 no-margin product-item-holder size-medium hover">
                        <div class="product-item">
                            <div class="image">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-06.jpg" />
                            </div>
                            <div class="body">
                                <div class="label-discount clear"></div>
                                <div class="title">
                                    <a href="single-product.jsp">playstasion 4 with four games and pad</a>
                                </div>
                                <div class="brand">acer</div>
                            </div>
                            <div class="prices">
                                <div class="price-current text-right">￥1199.00</div>
                            </div>
                            <div class="hover-area">
                                <div class="add-cart-button">
                                    <a href="single-product.jsp" class="le-button">加入购物车</a>
                                </div>
                                <div class="wish-compare">
                                    <a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
                                    <a class="btn-add-to-compare" href="#">Compare</a>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.product-item-holder -->

                    <div class="col-xs-12 col-sm-4 no-margin product-item-holder size-medium hover">
                        <div class="product-item">
                            <div class="image">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-07.jpg" />
                            </div>
                            <div class="body">
                                <div class="label-discount clear"></div>
                                <div class="title">
                                    <a href="single-product.jsp">EOS rebel t5i DSLR Camera with 18-55mm IS STM lens</a>
                                </div>
                                <div class="brand">canon</div>
                            </div>
                            <div class="prices">
                                <div class="price-current text-right">￥1199.00</div>
                            </div>
                            <div class="hover-area">
                                <div class="add-cart-button">
                                    <a href="single-product.jsp" class="le-button">加入购物车</a>
                                </div>
                                <div class="wish-compare">
                                    <a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
                                    <a class="btn-add-to-compare" href="#">Compare</a>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.product-item-holder -->
                </div><!-- /.row -->
                
                <div class="row no-margin">
                    
                    <div class="col-xs-12 col-sm-4 no-margin product-item-holder size-medium hover">
                        <div class="product-item">
                            <div class="image">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-08.jpg" />
                            </div>
                            <div class="body">
                                <div class="label-discount clear"></div>
                                <div class="title">
                                    <a href="single-product.jsp">fitbit zip wireless activity tracker - lime</a>
                                </div>
                                <div class="brand">fitbit zip</div>
                            </div>
                            <div class="prices">
                                <div class="price-current text-right">￥1199.00</div>
                            </div>
                            <div class="hover-area">
                                <div class="add-cart-button">
                                    <a href="single-product.jsp" class="le-button">加入购物车</a>
                                </div>
                                <div class="wish-compare">
                                    <a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
                                    <a class="btn-add-to-compare" href="#">Compare</a>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.product-item-holder -->

                    <div class="col-xs-12 col-sm-4 no-margin product-item-holder size-medium hover">
                        <div class="product-item">
                            <div class="image">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-09.jpg" />
                            </div>
                            <div class="body">
                                <div class="label-discount clear"></div>
                                <div class="title">
                                    <a href="single-product.jsp">PowerShot elph 115 16MP digital camera</a>
                                </div>
                                <div class="brand">canon</div>
                            </div>
                            <div class="prices">
                                <div class="price-current text-right">￥1199.00</div>
                            </div>
                            <div class="hover-area">
                                <div class="add-cart-button">
                                    <a href="single-product.jsp" class="le-button">加入购物车</a>
                                </div>
                                <div class="wish-compare">
                                    <a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
                                    <a class="btn-add-to-compare" href="#">Compare</a>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.product-item-holder -->

                    <div class="col-xs-12 col-sm-4 no-margin product-item-holder size-medium hover">
                        <div class="product-item">
                            <div class="image">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-10.jpg" />
                            </div>
                            <div class="body">
                                <div class="label-discount clear"></div>
                                <div class="title">
                                    <a href="single-product.jsp">netbook acer travelMate b113-E-10072</a>
                                </div>
                                <div class="brand">acer</div>
                            </div>
                            <div class="prices">
                                <div class="price-current text-right">￥1199.00</div>
                            </div>
                            <div class="hover-area">
                                <div class="add-cart-button">
                                    <a href="single-product.jsp" class="le-button">加入购物车</a>
                                </div>
                                <div class="wish-compare">
                                    <a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
                                    <a class="btn-add-to-compare" href="#">Compare</a>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.product-item-holder -->

                </div><!-- /.row -->
            </div><!-- /.col -->
            <div class="col-xs-12 col-md-5 no-margin">
                <div class="product-item-holder size-big single-product-gallery small-gallery">
                    
                    <div id="best-seller-single-product-slider" class="single-product-slider owl-carousel">
                        <div class="single-product-gallery-item" id="slide1">
                            <a data-rel="prettyphoto" href="images/products/product-gallery-01.jpg">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-gallery-01.jpg" />
                            </a>
                        </div><!-- /.single-product-gallery-item -->

                        <div class="single-product-gallery-item" id="slide2">
                            <a data-rel="prettyphoto" href="images/products/product-gallery-01.jpg">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-gallery-01.jpg" />
                            </a>
                        </div><!-- /.single-product-gallery-item -->

                        <div class="single-product-gallery-item" id="slide3">
                            <a data-rel="prettyphoto" href="images/products/product-gallery-01.jpg">
                                <img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-gallery-01.jpg" />
                            </a>
                        </div><!-- /.single-product-gallery-item -->
                    </div><!-- /.single-product-slider -->

                    <div class="gallery-thumbs clearfix">
                        <ul>
                            <li><a class="horizontal-thumb active" data-target="#best-seller-single-product-slider" data-slide="0" href="#slide1"><img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/gallery-thumb-01.jpg" /></a></li>
                            <li><a class="horizontal-thumb" data-target="#best-seller-single-product-slider" data-slide="1" href="#slide2"><img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/gallery-thumb-01.jpg" /></a></li>
                            <li><a class="horizontal-thumb" data-target="#best-seller-single-product-slider" data-slide="2" href="#slide3"><img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/gallery-thumb-01.jpg" /></a></li>
                        </ul>
                    </div><!-- /.gallery-thumbs -->

                    <div class="body">
                        <div class="label-discount clear"></div>
                        <div class="title">
                            <a href="single-product.jsp">CPU intel core i5-4670k 3.4GHz BOX B82-12-122-41</a>
                        </div>
                        <div class="brand">sony</div>
                    </div>
                    <div class="prices text-right">
                        <div class="price-current inline">￥1199.00</div>
                        <a href="cart.jsp" class="le-button big inline">加入购物车</a>
                    </div>
                </div><!-- /.product-item-holder -->
            </div><!-- /.col -->

        </div><!-- /.product-grid-holder -->
    </div><!-- /.container -->
</section><!-- /#bestsellers -->
<!-- ========================================= BEST SELLERS : END ========================================= -->
<!-- ========================================= RECENTLY VIEWED ========================================= -->
<section id="recently-reviewd" class="wow fadeInUp">
	<div class="container">
		<div class="carousel-holder hover">
			
			<div class="title-nav">
				<h2 class="h1">最近浏览</h2>
				<div class="nav-holder">
					<a href="#prev" data-target="#owl-recently-viewed" class="slider-prev btn-prev fa fa-angle-left"></a>
					<a href="#next" data-target="#owl-recently-viewed" class="slider-next btn-next fa fa-angle-right"></a>
				</div>
			</div><!-- /.title-nav -->

			<div id="owl-recently-viewed" class="owl-carousel product-grid-holder">
				<div class="no-margin carousel-item product-item-holder size-small hover">
					<div class="product-item">
						<div class="ribbon red"><span>sale</span></div> 
						<div class="image">
							<img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-11.jpg" />
						</div>
						<div class="body">
							<div class="title">
								<a href="single-product.jsp">LC-70UD1U 70" class aquos 4K ultra HD</a>
							</div>
							<div class="brand">Sharp</div>
						</div>
						<div class="prices">
							<div class="price-current text-right">￥1199.00</div>
						</div>
						<div class="hover-area">
							<div class="add-cart-button">
								<a href="single-product.jsp" class="le-button">加入购物车</a>
							</div>
							<div class="wish-compare">
								<a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
								<a class="btn-add-to-compare" href="#">Compare</a>
							</div>
						</div>
					</div><!-- /.product-item -->
				</div><!-- /.product-item-holder -->

				<div class="no-margin carousel-item product-item-holder size-small hover">
					<div class="product-item">
						<div class="ribbon blue"><span>new!</span></div> 
						<div class="image">
							<img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-12.jpg" />
						</div>
						<div class="body">
							<div class="title">
								<a href="single-product.jsp">cinemizer OLED 3D virtual reality TV Video</a>
							</div>
							<div class="brand">zeiss</div>
						</div>
						<div class="prices">
							<div class="price-current text-right">￥1199.00</div>
						</div>
						<div class="hover-area">
							<div class="add-cart-button">
								<a href="single-product.jsp" class="le-button">加入购物车</a>
							</div>
							<div class="wish-compare">
								<a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
								<a class="btn-add-to-compare" href="#">Compare</a>
							</div>
						</div>
					</div><!-- /.product-item -->
				</div><!-- /.product-item-holder -->

				<div class=" no-margin carousel-item product-item-holder size-small hover">
					<div class="product-item">

						<div class="image">
							<img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-13.jpg" />
						</div>
						<div class="body">
							<div class="title">
								<a href="single-product.jsp">s2340T23" full HD multi-Touch Monitor</a>
							</div>
							<div class="brand">dell</div>
						</div>
						<div class="prices">
							<div class="price-current text-right">￥1199.00</div>
						</div>
						<div class="hover-area">
							<div class="add-cart-button">
								<a href="single-product.jsp" class="le-button">加入购物车</a>
							</div>
							<div class="wish-compare">
								<a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
								<a class="btn-add-to-compare" href="#">Compare</a>
							</div>
						</div>
					</div><!-- /.product-item -->
				</div><!-- /.product-item-holder -->

				<div class=" no-margin carousel-item product-item-holder size-small hover">
					<div class="product-item">
						<div class="ribbon blue"><span>new!</span></div> 
						<div class="image">
							<img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-14.jpg" />
						</div>
						<div class="body">
							<div class="title">
								<a href="single-product.jsp">kardon BDS 7772/120 integrated 3D</a>
							</div>
							<div class="brand">harman</div>
						</div>
						<div class="prices">
							<div class="price-current text-right">￥1199.00</div>
						</div>
						<div class="hover-area">
							<div class="add-cart-button">
								<a href="single-product.jsp" class="le-button">加入购物车</a>
							</div>
							<div class="wish-compare">
								<a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
								<a class="btn-add-to-compare" href="#">Compare</a>
							</div>
						</div>
					</div><!-- /.product-item -->
				</div><!-- /.product-item-holder -->

				<div class=" no-margin carousel-item product-item-holder size-small hover">
					<div class="product-item">
						<div class="ribbon green"><span>bestseller</span></div> 
						<div class="image">
							<img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-15.jpg" />
						</div>
						<div class="body">
							<div class="title">
								<a href="single-product.jsp">netbook acer travel B113-E-10072</a>
							</div>
							<div class="brand">acer</div>
						</div>
						<div class="prices">
							<div class="price-current text-right">￥1199.00</div>
						</div>
						<div class="hover-area">
							<div class="add-cart-button">
								<a href="single-product.jsp" class="le-button">加入购物车</a>
							</div>
							<div class="wish-compare">
								<a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
								<a class="btn-add-to-compare" href="#">Compare</a>
							</div>
						</div>
					</div><!-- /.product-item -->
				</div><!-- /.product-item-holder -->

				<div class=" no-margin carousel-item product-item-holder size-small hover">
					<div class="product-item">

						<div class="image">
							<img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-16.jpg" />
						</div>
						<div class="body">
							<div class="title">
								<a href="single-product.jsp">iPod touch 5th generation,64GB, blue</a>
							</div>
							<div class="brand">apple</div>
						</div>
						<div class="prices">
							<div class="price-current text-right">￥1199.00</div>
						</div>
						<div class="hover-area">
							<div class="add-cart-button">
								<a href="single-product.jsp" class="le-button">加入购物车</a>
							</div>
							<div class="wish-compare">
								<a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
								<a class="btn-add-to-compare" href="#">Compare</a>
							</div>
						</div>
					</div><!-- /.product-item -->
				</div><!-- /.product-item-holder -->

				<div class=" no-margin carousel-item product-item-holder size-small hover">
					<div class="product-item">

						<div class="image">
							<img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-13.jpg" />
						</div>
						<div class="body">
							<div class="title">
								<a href="single-product.jsp">s2340T23" full HD multi-Touch Monitor</a>
							</div>
							<div class="brand">dell</div>
						</div>
						<div class="prices">
							<div class="price-current text-right">￥1199.00</div>
						</div>
						<div class="hover-area">
							<div class="add-cart-button">
								<a href="single-product.jsp" class="le-button">加入购物车</a>
							</div>
							<div class="wish-compare">
								<a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
								<a class="btn-add-to-compare" href="#">Compare</a>
							</div>
						</div>
					</div><!-- /.product-item -->
				</div><!-- /.product-item-holder -->

				<div class=" no-margin carousel-item product-item-holder size-small hover">
					<div class="product-item">
						<div class="ribbon blue"><span>new!</span></div> 
						<div class="image">
							<img alt="" src="assets/images/blank.gif" data-echo="assets/images/products/product-14.jpg" />
						</div>
						<div class="body">
							<div class="title">
								<a href="single-product.jsp">kardon BDS 7772/120 integrated 3D</a>
							</div>
							<div class="brand">harman</div>
						</div>
						<div class="prices">
							<div class="price-current text-right">￥1199.00</div>
						</div>
						<div class="hover-area">
							<div class="add-cart-button">
								<a href="single-product.jsp" class="le-button">加入购物车</a>
							</div>
							<div class="wish-compare">
								<a class="btn-add-to-wishlist" href="#">Add to Wishlist</a>
								<a class="btn-add-to-compare" href="#">Compare</a>
							</div>
						</div>
					</div><!-- /.product-item -->
				</div><!-- /.product-item-holder -->
			</div><!-- /#recently-carousel -->

		</div><!-- /.carousel-holder -->
	</div><!-- /.container -->
</section><!-- /#recently-reviewd -->
<!-- ========================================= RECENTLY VIEWED : END ========================================= -->
<!-- ========================================= TOP BRANDS ========================================= -->
<section id="top-brands" class="wow fadeInUp">
    <div class="container">
        <div class="carousel-holder" >
            
            <div class="title-nav">
                <h1>热门品牌</h1>
                <div class="nav-holder">
                    <a href="#prev" data-target="#owl-brands" class="slider-prev btn-prev fa fa-angle-left"></a>
                    <a href="#next" data-target="#owl-brands" class="slider-next btn-next fa fa-angle-right"></a>
                </div>
            </div><!-- /.title-nav -->
            
            <div id="owl-brands" class="owl-carousel brands-carousel">
                
                <div class="carousel-item">
                    <a href="#">
                        <img alt="" src="assets/images/brands/brand-01.jpg" />
                    </a>
                </div><!-- /.carousel-item -->
                
                <div class="carousel-item">
                    <a href="#">
                        <img alt="" src="assets/images/brands/brand-02.jpg" />
                    </a>
                </div><!-- /.carousel-item -->
                
                <div class="carousel-item">
                    <a href="#">
                        <img alt="" src="assets/images/brands/brand-03.jpg" />
                    </a>
                </div><!-- /.carousel-item -->
                
                <div class="carousel-item">
                    <a href="#">
                        <img alt="" src="assets/images/brands/brand-04.jpg" />
                    </a>
                </div><!-- /.carousel-item -->

                <div class="carousel-item">
                    <a href="#">
                        <img alt="" src="assets/images/brands/brand-01.jpg" />
                    </a>
                </div><!-- /.carousel-item -->

                <div class="carousel-item">
                    <a href="#">
                        <img alt="" src="assets/images/brands/brand-02.jpg" />
                    </a>
                </div><!-- /.carousel-item -->

                <div class="carousel-item">
                    <a href="#">
                        <img alt="" src="assets/images/brands/brand-03.jpg" />
                    </a>
                </div><!-- /.carousel-item -->

                <div class="carousel-item">
                    <a href="#">
                        <img alt="" src="assets/images/brands/brand-04.jpg" />
                    </a>
                </div><!-- /.carousel-item -->

            </div><!-- /.brands-caresoul -->

        </div><!-- /.carousel-holder -->
    </div><!-- /.container -->
</section><!-- /#top-brands -->
<!-- ========================================= TOP BRANDS : END ========================================= -->		<!-- ============================================================= FOOTER ============================================================= -->
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

</body>
</html>
