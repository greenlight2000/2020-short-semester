<%@ page import="com.webproject.project01.VO.CartVO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  errorPage="exception-page.jsp" %>
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

	    <title>Group57 - checkout</title>
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
                                        <span class="total-price">
                        <span class="sign">$</span><span class="value"><%=cartTotalPrice%></span>
                    </span>
                                    </div>
                                </a>

                                <ul class="dropdown-menu">
                                    <%for(CartVO cartVo : cartVoList){%>
                                    <%if(cartVoList.isEmpty()){%>
                                    <li>
                                        <div class="basket-item">
                                            <div class="row">
                                                <text style="margin-left: 90px">the Cart is Empty ~</text>
                                            </div>
                                        </div>
                                    </li>
                                    <%}%>
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

<!-- ============================================================= HEADER : END ============================================================= -->		<!-- ========================================= CONTENT ========================================= -->

<section id="checkout-page">
    <div class="container">
        <div class="col-xs-12 no-margin">
            <section id="shipping-address" style="margin-bottom:100px;margin-top:-10px">
                <h2 class="border h1">Address</h2>
                    <a href="#" id="createlink">Add new contact</a>
					<br/><br/>
					<table border="1" bordercolor="#DFDFDF">
    	                <tr height="50px">
        	            	<td width="50" align="center"><input class="le-radio big" type="radio" name="address" checked="true"></td>
							<td width="200"><span class="simple-link bold" href="#" style="left: 15px; position: relative;">Anny Black</span></td>
							<td width="400"><span class="simple-link bold" href="#" style="left: 10px; right: 10px; position: 	relative;">Nanfeng highway, Changping district, Beijing</span></td>
							<td width="180"><span class="simple-link bold" href="#" style="left: 15px; position: relative;">122 1111 1111</span></td>
						</tr>
    	    	            <tr height="50px">
        	            	<td width="50" align="center"><input  class="le-radio big" type="radio" name="address"></td>
							<td width="200"><span class="simple-link bold" href="#" style="left: 15px; position: relative;">Cindy Channing</span></td>
							<td width="400"><span class="simple-link bold" href="#" style="left: 10px; right: 10px; position: relative;"> Beijing University of Posts and Telecommunications, Hiadian district, Beijing</span></td>
							<td width="180"><span class="simple-link bold" href="#" style="left: 15px; position: relative;">222 1111 1111</span></td>
						</tr>
                	</table>
            </section><!-- /#shipping-address -->
            
            <div class="billing-address" style="display:none;">
                <h2 class="border h1">Add new contact</h2>
                <form>
                    <div class="row field-row">
                        <div class="col-xs-12 col-sm-6">
                            <label>name</label>
                            <input class="le-input" >
                        </div>
                    </div><!-- /.field-row -->
                    <div class="row field-row">
                        <div class="col-xs-12 col-sm-6">
                            <label>Address</label>
                            <input class="le-input" data-placeholder="For example: Baisha Road, Changeping district, Beijing" >
                        </div>
                    </div><!-- /.field-row -->
                    <div class="row field-row">
                        <div class="col-xs-12 col-sm-6">
                            <label>Phone number</label>
                            <input class="le-input" >
                        </div>
                    </div><!-- /.field-row -->
                    <div class="place-order-button" style="left:-850px; position: relative">
                        <button class="le-button small">Add</button>
                    </div><!-- /.place-order-button -->
                </form>
            </div><!-- /.billing-address -->


            <section id="your-order">

                <h2 class="border h1">Order details</h2>
                <form>
                    <%for(CartVO cartVo : cartVoList){%>
                    <div class="row no-margin order-item">
                        <div class="col-xs-12 col-sm-1 no-margin">
                            <a href="#" class="qty"><%=cartVo.getNum()%> x</a>
                        </div>
                        <div class="col-xs-12 col-sm-9 ">
                            <div class="title"><a href="#"><%=cartVo.getName()%> </a></div>
                            <div class="brand"><%=cartVo.getConfigSpecs()%></div>
                            <div class="brand"><%if(cartVo.getAccessory()!=null && !cartVo.getAccessory().equals("")){%>+ <%=cartVo.getAccessory()%><%}%></div>
                        </div>
                        <div class="col-xs-12 col-sm-2 no-margin">
                            <div class="price">$<%=cartVo.getTotalPrice()%></div>
                        </div>
                    </div><!-- /.order-item -->
                    <%}%>
                </form>
            </section><!-- /#your-order -->

            <div id="total-area" class="row no-margin">
                <!--<div class="col-xs-12 col-lg-4 col-lg-offset-8 no-margin-right">-->
				<div style="float: left; width: 40%">
                    <div id="subtotal-holder">
                        <ul class="tabled-data inverse-bold no-border">
                            <li>
								<br/>
                                <label class="radio-label bold" style="font-size: 16px">Total product price</label>
                                <div class="value" style="text-align: right; font-size: 16px">$<%=cartTotalPrice%></div>
                            </li>
							<br/>
                            <li>
                                <label class="radio-label bold" style="font-size: 16px">Select your mailing method</label>
                                <div class="value" style="left:70px; position: relative">
                                    <div class="radio-group">
                                        <input class="le-radio" type="radio" name="group1" value="free" checked>
										<div class="radio-label bold" style="font-size: 14px">EMS<span class="bold"> $10</span></div><br/>
<%--                                        <input class="le-radio" type="radio" name="group2" value="local">--%>
<%--										<div class="radio-label" style="font-size: 14px">ZTO Express<span class="bold"> $10</span></div>--%>
                                    </div>
                                </div>
                            </li>
                        </ul><!-- /.tabled-data -->

                        <ul id="total-field" class="tabled-data inverse-bold ">
                            <li>
                                <label class="radio-label bold" style="font-size: 16px">Total order price</label>
                                <div class="value" style="right: -70px; position:relative">$<%=cartTotalPrice + 10%></div>
                            </li>
                        </ul><!-- /.tabled-data -->

                    </div><!-- /#subtotal-holder -->
                </div><!-- /.col -->
				<div id="payment-method-options" style="float: left; width: 40%; margin-top: 50px;; margin-left: 230px">
	                <form>
    	                <div class="payment-method-option">
        	                <input class="le-radio" type="radio" name="group1" value="Direct" checked="true">
            	            <div class="radio-label bold">WeChat Pay</div>
                	    </div><!-- /.payment-method-option -->
                    
                    	<div class="payment-method-option">
                        	<input class="le-radio" type="radio" name="group2" value="cheque">
							<div class="radio-label bold ">Alipay</div>
 	                   </div><!-- /.payment-method-option -->
                    
    	                <div class="payment-method-option">
        	                <input class="le-radio" type="radio" name="group3" value="paypal">
            	            <div class="radio-label bold ">Credit card pay</div>
                	    </div><!-- /.payment-method-option -->
                	</form>
            	</div><!-- /#payment-method-options -->
            </div><!-- /#total-area -->
            <br/><br/>
            <div class="place-order-button" style="text-align: center">
                <button class="le-button big" href="javascript:void(0);" onclick="confirmCheckOut(<%=userId%>)">Confirm</button>
            </div><!-- /.place-order-button -->

        </div><!-- /.col -->
    </div><!-- /.container -->    
</section><!-- /#checkout-page -->
<!-- ========================================= CONTENT : END ========================================= -->		<!-- ============================================================= FOOTER ============================================================= -->
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
                            <p>Wang Yunkun</p>
                            <p>Gu Yue</p>
                            <p>Shu Nan</p>
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

    <script>
        $("#createlink").click(function(){
            $(".billing-address").slideDown();
        });
        
    </script>

</body>
</html>
