<%@ page import="com.webproject.project01.VO.CartVO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.webproject.project01.VO.ClassificationVO" %>
<%@ page import="com.webproject.project01.PO.Classification" %><%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/10/8
  Time: 3:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Group57</title>
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keywords" content="MediaCenter, Template, eCommerce">
    <meta name="robots" content="all">

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
    <div class="product-item product-item-holder">
        <div class="ribbon red"><span>sale</span></div>
        <div class="ribbon blue"><span>new!</span></div>
        <div class="row">
            <div class="no-margin col-xs-12 col-sm-4 image-holder">
                <div class="image">
                    <img alt="{{$value.picture}}" src="{{$value.picture}}" width="246" height="186"/>
                </div>
            </div><!-- /.image-holder -->
            <div class="no-margin col-xs-12 col-sm-5 body-holder">
                <div class="body">
                    <div class="label-discount green">-50% sale</div>
                    <div class="title">
                        <a href="single-product.jsp">{{$value.name}}</a>
                    </div>
                    <div class="brand">{{$value.configChoice.name}}</div>
                    <div class="excerpt">
                        <p>{{$value.description}}</p>
                    </div>
                </div>
            </div><!-- /.body-holder -->
            <div class="no-margin col-xs-12 col-sm-3 price-area">
                <div class="right-clmn">
                    <div class="price-current">\${{$value.price}}</div>
                    <div class="price-prev">🔥{{$value.sales}}</div>
                    <div class="availability"><label>launch time:</label><span class="available"> {{$value.launchTime}}</span></div>
                    <a class="le-button" href="javascript:void(0);" onclick="checkProduct('{{$value.id}}')">Add To Cart</a>
                </div>
            </div><!-- /.price-area -->
        </div><!-- /.row -->
    </div><!-- /.product-item -->
    {{/each}}
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
<%
    //content
    String catId = request.getParameter("catId");

    request.getRequestDispatcher("/class/hierarchy"+"?classId="+catId).include(request,response);
    List<ClassificationVO> ancestorClassVoList = (List<ClassificationVO>) session.getAttribute("ancestorClassVoList");
    List<ClassificationVO> childClassVoList = (List<ClassificationVO>) session.getAttribute("childClassVoList");
%>
<script type="text/javascript">
    <%--loadCatHierarchy(<%=catId%>);--%>
    loadCatSpu(<%=catId%>);
</script>
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

    <div id="products-tab" class="wow fadeInUp">
        <div class="container">
            <div class="meta-row">
                <div class="inline">
                    <label>categories-hierarchy:</label>
                    <%int cnt=0;for(ClassificationVO classVo : ancestorClassVoList){cnt++;%>
                    <span><a href="javascript:void(0);" onclick="goToCatSpu(<%=classVo.getId()%>)"><%=classVo.getName()%></a>
                    <%if(cnt!=ancestorClassVoList.size()){%>
                        <label>></label>
                    <%}%>
                    </span>
                    <%}%>
                </div><!-- /.inline -->
            </div>
            <%if(!childClassVoList.isEmpty()){%>
                <div>
                    <div class="inline">
                        <label>sub-categories:</label>
                        <span>
                        <%int cnt2=0;for(ClassificationVO classVo : childClassVoList){cnt2++;%>
                        <a href="javascript:void(0);" onclick="goToCatSpu(<%=classVo.getId()%>)"><%=classVo.getName()%></a>
                        <%if(cnt2!=childClassVoList.size()){%>
                            <label>, </label>
                        <%}%>
                        <%}%>
                        </span>
                    </div>
                </div>
            <%}%>
            <div class="tab-holder">

                <!-- Tab panes -->
                <div class="tab-content">
                    <%--   recommended   --%>
                    <div class="tab-pane active" id="featured">
                        <div id="div-cat-spu" class="products-list">
                            <!-- 待插入 -->
                        </div>
<%--                        <div class="loadmore-holder text-center">--%>
<%--                            <a class="btn-loadmore" href="javascript:void(0);" onclick="loadRecommendSPU(++recPageNum)">--%>
<%--                                <i class="fa fa-plus"></i>--%>
<%--                                load more</a>--%>
<%--                        </div>--%>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- ========================================= BEST SELLERS ========================================= -->
    <section id="bestsellers" class="color-bg wow fadeInUp">

    </section><!-- /#bestsellers -->
    <!-- ========================================= BEST SELLERS : END ========================================= -->
    <!-- ========================================= RECENTLY VIEWED ========================================= -->
    <section id="recently-reviewd" class="wow fadeInUp">

    </section><!-- /#recently-reviewd -->
    <!-- ========================================= RECENTLY VIEWED : END ========================================= -->
    <!-- ========================================= TOP BRANDS ========================================= -->
    <section id="top-brands" class="wow fadeInUp">

    </section><!-- /#top-brands -->
    <!-- ========================================= TOP BRANDS : END ========================================= -->		<!-- ============================================================= FOOTER ============================================================= -->
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
    </footer><!-- /.wrapper -->

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
