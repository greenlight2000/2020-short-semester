<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.webproject.project01.VO.*" %>
<!--
    @param:     skuIndex : 0
    @session:   userId : ""
                userName : ""
                cartVoList : new ArrayList()
                spuVo : null                    ``\ <= "/detail"
                skuVoList : new ArrayList()      _/
    @query:     "/accessory" => session: accessoryVoList
-->

<%@ page contentType="text/html;charset=UTF-8" language="java"  errorPage="exception-page.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
	<head>
		<!-- Meta -->
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

	    <title>Group57 - single-product</title>

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
<script src="assets/js/template.js"></script>
<script id="tpl" type="text/html">
    <div class="comment-item">
        <div class="row no-margin">
            <div class="col-lg-1 col-xs-12 col-sm-2 no-margin">
                <div class="avatar">
                    <img alt="avatar" src="assets/images/default-avatar.jpg">
                </div><!-- /.avatar -->
            </div><!-- /.col -->

            <div class="col-xs-12 col-lg-11 col-sm-10 no-margin">
                <div class="comment-body">
                    <div class="meta-info">
                        <div class="author inline">
                            <a href="#" class="bold">{{userName}}</a>
                        </div>
                        <div class="star-holder inline">
                            <div class="star" data-score="5" style="cursor: pointer; width: 80px;">
                                <img src="{{star1}}" alt="1" width="20px" height="20px" style="margin-top: -5px">
                                <img src="{{star2}}" alt="2" width="20px" height="20px" style="margin-top: -5px">
                                <img src="{{star3}}" alt="3" width="20px" height="20px" style="margin-top: -5px">
                                <img src="{{star4}}" alt="4" width="20px" height="20px" style="margin-top: -5px">
                                <img src="{{star5}}" alt="5" width="20px" height="20px" style="margin-top: -5px">
                            </div>
                        </div>
                        <div class="date inline pull-right">
                            {{time}}
                        </div>
                    </div><!-- /.meta-info -->
                    <p class="comment-text">
                        {{comment}}
                    </p><!-- /.comment-text -->
                </div><!-- /.comment-body -->

            </div><!-- /.col -->

        </div><!-- /.row -->
    </div>
</script>
<%--    <script src="assets/js/fun.js"></script>--%>
<%--    <script src="assets/js/jquery-1.10.2.min.js"></script>--%>
    <script type="text/javascript">
        var accessoryStrList = [];
        var axStr;
    </script>
    <%
        //navigation  登录/登出相关显示
        String userName = session.getAttribute("userName")==null?"":(String)session.getAttribute("userName");
        //header   小购物车相关
        request.getRequestDispatcher("/cart/get").include(request,response);
        List<CartVO> cartVoList = session.getAttribute("cartVoList")==null?new ArrayList<>():(List<CartVO>) session.getAttribute("cartVoList");
        double cartTotalPrice = 0;
        int cartNum = 0;
        for(CartVO cartVo : cartVoList){
            cartTotalPrice += cartVo.getTotalPrice();
            cartNum++;
        }
        String userId = session.getAttribute("userId")==null?"":(String) session.getAttribute("userId");
        //content
        request.getRequestDispatcher("/accessory").include(request,response);
        List<AccessoryVO> accessoryVoList = session.getAttribute("accessoryVoList")==null?new ArrayList<>():(List<AccessoryVO>) session.getAttribute("accessoryVoList");
        //从请求获取skuIndex（默认0）
        int skuIndex = Integer.parseInt(request.getParameter("skuIndex")==null?"0":request.getParameter("skuIndex"));//本页面加载的并当前显示的skuVoList[skuIndex]

        //获取spu
        SPUVO spuVo = (SPUVO) session.getAttribute("spuVo");
        //获取skuList
        List<SKUVO> skuVoList = session.getAttribute("skuVoList")==null?new ArrayList<>():(List<SKUVO>) session.getAttribute("skuVoList");

        //构造configMapList（包含所有sku的config键值map）
        Gson gson = new Gson();
        List<Map<String,String>> configMapList = new ArrayList<>();
        for(int i=0;i<skuVoList.size();i++){
            Map<String,String> configMap = gson.fromJson(skuVoList.get(i).getConfigSpecs(),Map.class);
            configMapList.add(configMap);
            //test: print the current map content
//            for(Map.Entry<String,String> entry : configMap.entrySet()){
//                out.print("key= " + entry.getKey() + " and value= " + entry.getValue() + "\n");
//            }
        }

        //选中一个sku
        SKUVO skuVo = skuVoList.isEmpty()?new SKUVO():skuVoList.get(skuIndex);
        //选中当前sku的config map
        Map<String,String> curConfigMap = configMapList.isEmpty()?new HashMap<>() : configMapList.get(skuIndex);

        //test
//        if(skuVoList!=null) {
//            if (skuVoList.isEmpty())
//                System.out.print("single-product.jsp:  skuVoList is empty");
//            else
//                System.out.print("single-product.jsp:  skuVoList is ok");
//        } else
//            System.out.print("single-product.jsp:  skuVoList is null");

        //nav2
        //category navigation
        request.getRequestDispatcher("/class?param=root").include(request,response);
        List<ClassificationVO> rootClassVoList = (List<ClassificationVO>) session.getAttribute("rootClassVoList");

        request.getRequestDispatcher("/class/hierarchy"+"?classId="+spuVo.getClassificationVO().getId()).include(request,response);
        List<ClassificationVO> ancestorClassVoList = (List<ClassificationVO>) session.getAttribute("ancestorClassVoList");
    %>
    <script src="assets/js/fun.js"></script>
    <script src="assets/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        loadMoreDetail(<%=spuVo.getId()%>)
    </script>
<%--    <%try {%>--%>
    <div id="wrapper" class="wrapper">
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
        <!-- ============================================================= TOP NAVIGATION : END ============================================================= -->		<!-- ============================================================= HEADER ============================================================= -->
        <header>
            <div class="container no-padding">

                <div class="col-xs-12 col-sm-12 col-md-3 logo-holder">
                    <!-- ============================================================= LOGO ============================================================= -->
                    <div class="logo">
                        <a href="index.jsp">
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
                            <i class="fa fa-envelope"></i> contact@<span class="le-color">jason.com</span>
                        </div>
                    </div><!-- /.contact-row -->
                    <!-- ============================================================= SEARCH AREA ============================================================= -->
                    <div class="search-area">
                        <form>
                            <div class="control-group">
                                <input class="search-field" placeholder="Search Product" id="keywords-input"/>
                                <ul class="categories-filter animate-dropdown">
                                    <li class="dropdown"><a class="dropdown-toggle"  data-toggle="dropdown" href="javascript:void(0);" id="search-by-box" tabindex="0">Search By</a>
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
                    <!-- ============================================================= SEARCH AREA : END ============================================================= -->		</div><!-- /.top-search-holder -->

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

        <!-- ============================================================= HEADER : END ============================================================= -->		<div id="single-product">
        <div class="container">

            <div class="no-margin col-xs-12 col-sm-6 col-md-5 gallery-holder">
                <div class="product-item-holder size-big single-product-gallery small-gallery">

                    <div id="owl-single-product">
                        <%--  第一个图片放当前sku的图  --%>
                        <div class="single-product-gallery-item" id="slide0">
                            <a data-rel="prettyphoto" href="<%=skuVo.getPicture()%>">
                                <img class="img-responsive" alt="" src="<%=skuVo.getPicture()%>"  style="height: 325px;width: 433px"/>
                            </a>
                        </div><!-- /.single-product-gallery-item -->
                        <%--  中间的图片放依次所有的sku的图  --%>
                        <%int picCnt=0; for(SKUVO aSkuVo : skuVoList){picCnt++;if(aSkuVo.getId()!=skuVo.getId()){%>
                        <div class="single-product-gallery-item" id="slide<%=picCnt%>">
                            <a data-rel="prettyphoto" href="<%=aSkuVo.getPicture()%>">
                                <img class="img-responsive" alt="" src="<%=aSkuVo.getPicture()%>" style="height: 325px;width: 433px"/>
                            </a>
                        </div><!-- /.single-product-gallery-item -->
                        <%}}%>
                        <%--  最后一个图片放spu的图  --%>
                        <div class="single-product-gallery-item active" id="slide<%=picCnt+1%>">
                            <a data-rel="prettyphoto" href="<%=spuVo.getPicture()%>">
                                <img class="img-responsive" alt="" src="<%=spuVo.getPicture()%>"  style="height: 325px;width: 433px"/>
                            </a>
                        </div><!-- /.single-product-gallery-item -->
                    </div><!-- /.single-product-slider -->


                    <div class="single-product-gallery-thumbs gallery-thumbs">

                        <div id="owl-single-product-thumbnails">
                            <a class="horizontal-thumb active" data-target="#owl-single-product" data-slide="0" href="#slide0">
                                <img width="67" alt="" src="<%=skuVo.getPicture()%>" style="height: 60px;width: 67px"/>
                            </a>
                            <%int sldCnt=0; for(SKUVO aSkuVo : skuVoList){ sldCnt++;if(aSkuVo.getId()!=skuVo.getId()){%>
                            <a class="horizontal-thumb" data-target="#owl-single-product" data-slide="<%=sldCnt-1%>" href="#slide<%=sldCnt%>">
                                <img width="67" alt="" src="<%=aSkuVo.getPicture()%>" style="height: 60px;width: 67px"/>
                            </a>
                            <%}}%>
                            <a class="horizontal-thumb" data-target="#owl-single-product" data-slide="<%=sldCnt%>" href="#slide<%=sldCnt+1%>">
                                <img width="67" alt="" src="<%=spuVo.getPicture()%>" style="height: 60px;width: 67px"/>
                            </a>
                        </div><!-- /#owl-single-product-thumbnails -->

                        <div class="nav-holder left hidden-xs">
                            <a class="prev-btn slider-prev" data-target="#owl-single-product-thumbnails" href="#prev"></a>
                        </div><!-- /.nav-holder -->

                        <div class="nav-holder right hidden-xs">
                            <a class="next-btn slider-next" data-target="#owl-single-product-thumbnails" href="#next"></a>
                        </div><!-- /.nav-holder -->

                    </div><!-- /.gallery-thumbs -->

                </div><!-- /.single-product-gallery -->
            </div><!-- /.gallery-holder -->
            <div class="no-margin col-xs-12 col-sm-7 body-holder">
                <div class="body">
<%--                    <div class="star-holder inline"><div class="star" data-score="4"></div></div>--%>
                    <div class="availability" style="margin-left: 0px"><label>launchTime:</label><span class="available">  <%=spuVo.getLaunchTime()%></span></div>
                    <div class="availability"><label>inventory:</label><span class="available">  <%=skuVo.getStockNum()%></span></div>
                    <div class="title"><a href="javascript:void(0)" onclick="checkProduct(<%=spuVo.getId()%>)"><%=skuVo.getName()%></a></div>
                    <div class="brand"><a style="color: grey" href="javascript:void(0)" onclick="goToCatSpu(<%=spuVo.getClassificationVO().getId()%>)"><%=spuVo.getClassificationVO()==null?"":spuVo.getClassificationVO().getName()%></a></div>

                    <div class="excerpt">
                        <p><%=spuVo.getDescription()%></p>
                    </div>
                    <div>
                        <h2 style="color: black">Configuration:&nbsp&nbsp&nbsp</h2>
                    </div>
                    <div>
                        <div class="le-select" style="left: 0px; right: 10px; top: 4px; border-color: #E74C3C; border-radius: 5px;">
                            <select style="font-weight: 600; margin-left: -3px; width:300px">
                                <%
                                    List<String> configStrArr = new ArrayList<>();
                                    for(int i=0; i<skuVoList.size(); i++){%>
                                <option <%if(i==skuIndex){%>selected<%}%> onclick="chooseSku(<%=i%>)">
                                    <%
                                        StringBuilder configStr = new StringBuilder();
                                        //获取当前sku的config键值对map
                                        Map<String,String> map = configMapList.get(i);
                                        //配置串联一个configStr
                                        int cnt=0;
                                        for(Map.Entry<String,String> entry : map.entrySet()) {
                                            cnt++;
                                            configStr.append(entry.getKey()).append(": ").append(entry.getValue());
//                                            configStr.append(entry.getValue());
                                            if (cnt != map.size()) {
                                                configStr.append(" &times ️");
                                            }
                                        }
                                        //将配置好的str放入list
                                        configStrArr.add(configStr.toString());
                                    %>

                                    &nbsp&nbsp&nbsp&nbsp<%=configStrArr.get(i)%></option>
                                <%}%>

                            </select>
                        </div>

                    </div><br/>

                    <div class="dropdown">
                        <a data-hover="dropdown" data-toggle="dropdown"><h2 style="color: black">Accessories of choice:</h2><div id="accessory-str" axStr="" ></div></a>
                        <ul class="dropdown-menu">
                            <li>
                                <table class="acc-table">

                                    <%int cnt=0;for(AccessoryVO accessoryVo : accessoryVoList){%>
                                    <tr>
                                        <td class="spefic-acc"><label><input class="acc_list" type="checkbox" value="<%=accessoryVo.getName()%>" prop="<%=accessoryVo.getName()%>" href="javascript:void(0);" onclick="chooseAccessory(this, accessoryStrList,'<%=accessoryVo.getName()%>',axStr,<%=accessoryVo.getPrice()%>)"> <%=accessoryVo.getName()%> ($<%=accessoryVo.getPrice()%>)</label></td>
                                    </tr>
                                    <%cnt++;}%>
                                </table>
                            </li>
                        </ul>
                    </div><br/>
<%--                    <div><input id="chosen-ax" value="" readonly style="left: 8px; right: 10px; top: 4px; border-color: #E74C3C; border-radius: 5px;"></div>--%>
                    <div class="prices">
                        <div id="price-accessory" hidden="true" price="0"></div>
                        <div id="price-current" class="price-current" price="<%=skuVo.getTotalPrice()%>">$<%=skuVo.getTotalPrice()%></div>
<%--                        <div id="price-prev" class="price-prev">$<%=spuVo.getPrice()%></div>--%>
                    </div>


                    <div class="qnt-holder">
                        <div class="le-quantity">
                            <form>
                                <span class="minus" href="javascript:void(0);" onclick="changeNum('-',<%=skuVo.getStockNum()%>)"></span>
                                <input id="choose-num" readonly="readonly" type="text" value="1"/>
                                <span class="plus" href="javascript:void(0);" onclick="changeNum('+',<%=skuVo.getStockNum()%>)"></span>
                            </form>
                        </div>
                        <button id="addto-cart" class="le-button huge" onclick='addToCart("<%=configStrArr.get(skuIndex)%>","<%=skuVo.getName()%>","<%=skuVo.getPicture()%>","1",<%=skuVo.getSPUId()%>,<%=skuVo.getId()%>,<%=userId%>)'>Add To Cart</button>
                        <%--            "<%=configStrArr.get(skuIndex)%>","",<%=skuVo.getName()%>,"<%=spuVo.getPicture()%>","1","1",<%=skuVo.getSPUId()%>,<%=userId%>--%>
                    </div><!-- /.qnt-holder -->

                </div><!-- /.body -->

            </div><!-- /.body-holder -->
        </div><!-- /.container -->
    </div><!-- /.single-product -->

        <!-- ========================================= SINGLE PRODUCT TAB ========================================= -->
        <section id="single-product-tab">
            <div class="container">
                <div class="tab-holder">

                    <ul class="nav nav-tabs simple" >
                        <li class="active"><a href="#description" data-toggle="tab">More Detail</a></li>
                        <li><a href="#additional-info" data-toggle="tab">Specification</a></li>
                        <li><a href="#reviews" data-toggle="tab">Comments (3)</a></li>
                    </ul><!-- /.nav-tabs -->

                    <div class="tab-content">
                        <div class="tab-pane active" id="description">

                            <p id="more-detail">Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet porttitor eros. Praesent quis diam placerat, accumsan velit interdum, accumsan orci. Nunc libero sem, elementum in semper in, sollicitudin vitae dolor. Etiam sed tempus nisl. Integer vel diam nulla. Suspendisse et aliquam est. Nulla molestie ante et tortor sollicitudin, at elementum odio lobortis. Pellentesque neque enim, feugiat in elit sed, pharetra tempus metus. Pellentesque non lorem nunc. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>

<%--                            <p>Sed consequat orci vel rutrum blandit. Nam non leo vel risus cursus porta quis non nulla. Vestibulum vitae pellentesque nunc. In hac habitasse platea dictumst. Cras egestas, turpis a malesuada mollis, magna tortor scelerisque urna, in pellentesque diam tellus sit amet velit. Donec vel rhoncus nisi, eget placerat elit. Phasellus dignissim nisl vel lectus vehicula, eget vehicula nisl egestas. Duis pretium sed risus dapibus egestas. Nam lectus felis, sodales sit amet turpis se.</p>--%>

                            <div class="meta-row">
                                <div class="inline">
                                    <label>SKU-id:</label>
                                    <span><%=skuVo.getId()%></span>
                                </div><!-- /.inline -->

                                <span class="seperator">/</span>


                                <div class="inline">
                                    <label>categories-hierarchy:</label>
                                    <%int cnt0=0;for(ClassificationVO classVo : ancestorClassVoList){cnt0++;%>
                                    <span><a href="javascript:void(0);" onclick="goToCatSpu(<%=classVo.getId()%>)"><%=classVo.getName()%></a>
                                    <%if(cnt0!=ancestorClassVoList.size()){%>
                                        <label>></label>
                                    <%}%>
                                    </span>
                                    <%}%>
                                </div><!-- /.inline -->

                            </div><!-- /.meta-row -->
                        </div><!-- /.tab-pane #description -->

                        <div class="tab-pane" id="additional-info">
                            <ul class="tabled-data">
                                <%for(Map.Entry<String,String> entry : curConfigMap.entrySet()){%>
                                <li>
                                    <label><%=entry.getKey()%></label>
                                    <div class="value"><%=entry.getValue()%></div>
                                </li>
                                <%}%>
                            </ul><!-- /.tabled-data -->

                            <div class="meta-row">
                                <div class="inline">
                                    <label>SKU-id:</label>
                                    <span><%=skuVo.getId()%></span>
                                </div><!-- /.inline -->

                                <span class="seperator">/</span>

                                <div class="inline">
                                    <label>categories-hierarchy:</label>
                                    <%int cnt1=0;for(ClassificationVO classVo : ancestorClassVoList){cnt1++;%>
                                    <span><a href="javascript:void(0);" onclick="goToCatSpu(<%=classVo.getId()%>)"><%=classVo.getName()%></a>
                                    <%if(cnt1!=ancestorClassVoList.size()){%>
                                        <label>></label>
                                    <%}%>
                                    </span>
                                    <%}%>
                                </div><!-- /.inline -->

                            </div><!-- /.meta-row -->
                        </div><!-- /.tab-pane #additional-info -->
                        <%-- comment-item 模版 --%>

                        <div class="tab-pane" id="reviews">
                            <div class="comments" id="comments-list">
                                <div class="comment-item">
                                    <div class="row no-margin">
                                        <div class="col-lg-1 col-xs-12 col-sm-2 no-margin">
                                            <div class="avatar">
                                                <img alt="avatar" src="assets/images/default-avatar.jpg">
                                            </div><!-- /.avatar -->
                                        </div><!-- /.col -->

                                        <div class="col-xs-12 col-lg-11 col-sm-10 no-margin">
                                            <div class="comment-body">
                                                <div class="meta-info">
                                                    <div class="author inline">
                                                        <a href="#" class="bold">John Smith</a>
                                                    </div>
                                                    <div class="star-holder inline">
                                                        <div class="star" data-score="4"></div>
                                                    </div>
                                                    <div class="date inline pull-right">
                                                        2020-10-20 17:35:50
                                                    </div>
                                                </div><!-- /.meta-info -->
                                                <p class="comment-text">
                                                    Integer id purus ultricies nunc tincidunt congue vitae nec felis. Vivamus sit amet nisl convallis, faucibus risus in, suscipit sapien. Vestibulum egestas interdum tellus id venenatis.
                                                </p><!-- /.comment-text -->
                                            </div><!-- /.comment-body -->

                                        </div><!-- /.col -->

                                    </div><!-- /.row -->
                                </div><!-- /.comment-item -->

                                <div class="comment-item">
                                    <div class="row no-margin">
                                        <div class="col-lg-1 col-xs-12 col-sm-2 no-margin">
                                            <div class="avatar">
                                                <img alt="avatar" src="assets/images/default-avatar.jpg">
                                            </div><!-- /.avatar -->
                                        </div><!-- /.col -->

                                        <div class="col-xs-12 col-lg-11 col-sm-10 no-margin">
                                            <div class="comment-body">
                                                <div class="meta-info">
                                                    <div class="author inline">
                                                        <a href="#" class="bold">Daisy Gatsby</a>
                                                    </div>
                                                    <div class="star-holder inline">
                                                        <div class="star" data-score="5"></div>
                                                    </div>
                                                    <div class="date inline pull-right">
                                                        2020-10-20 17:35:50
                                                    </div>
                                                </div><!-- /.meta-info -->
                                                <p class="comment-text">
                                                    Integer id purus ultricies nunc tincidunt congue vitae nec felis. Vivamus sit amet nisl convallis, faucibus risus in, suscipit sapien. Vestibulum egestas interdum tellus id venenatis.
                                                </p><!-- /.comment-text -->
                                            </div><!-- /.comment-body -->

                                        </div><!-- /.col -->

                                    </div><!-- /.row -->
                                </div><!-- /.comment-item -->

                                <div class="comment-item">
                                    <div class="row no-margin">
                                        <div class="col-lg-1 col-xs-12 col-sm-2 no-margin">
                                            <div class="avatar">
                                                <img alt="avatar" src="assets/images/default-avatar.jpg">
                                            </div><!-- /.avatar -->
                                        </div><!-- /.col -->

                                        <div class="col-xs-12 col-lg-11 col-sm-10 no-margin">
                                            <div class="comment-body">
                                                <div class="meta-info">
                                                    <div class="author inline">
                                                        <a href="#" class="bold">Williams Johnson</a>
                                                    </div>
                                                    <div class="star-holder inline">
                                                        <div class="star" data-score="3"></div>
                                                    </div>
                                                    <div class="date inline pull-right">
                                                        2020-10-20 17:35:50
                                                    </div>
                                                </div><!-- /.meta-info -->
                                                <p class="comment-text">
                                                    Integer id purus ultricies nunc tincidunt congue vitae nec felis. Vivamus sit amet nisl convallis, faucibus risus in, suscipit sapien. Vestibulum egestas interdum tellus id venenatis.
                                                </p><!-- /.comment-text -->
                                            </div><!-- /.comment-body -->

                                        </div><!-- /.col -->

                                    </div><!-- /.row -->
                                </div><!-- /.comment-item -->
                            </div><!-- /.comments -->

                            <div class="add-review row">
                                <div class="col-sm-8 col-xs-12">
                                    <div class="new-review-form">
                                        <h2>Add review</h2>
                                        <form id="contact-form" class="contact-form" method="post" >
<%--                                            <div class="row field-row">--%>
<%--                                                <div class="col-xs-12 col-sm-6">--%>
<%--                                                    <label>name*</label>--%>
<%--                                                    <input class="le-input" >--%>
<%--                                                </div>--%>
<%--                                                <div class="col-xs-12 col-sm-6">--%>
<%--                                                    <label>email*</label>--%>
<%--                                                    <input class="le-input" >--%>
<%--                                                </div>--%>
<%--                                            </div><!-- /.field-row -->--%>

                                            <div class="field-row star-row">
                                                <label>your rating</label>
                                                <div class="star-holder">
                                                    <div id="star-num-div" class="star big" data-score="0" ></div>
                                                </div>
                                            </div><!-- /.field-row -->

                                            <div class="field-row">
                                                <label>your review</label>
                                                <textarea id="comment-text" rows="8" class="le-input"></textarea>
                                            </div><!-- /.field-row -->

                                            <div class="buttons-holder">
                                                <button type="button" class="le-button huge" onclick="submitComment('<%=userName%>')">submit</button>
                                            </div><!-- /.buttons-holder -->
                                        </form><!-- /.contact-form -->
                                    </div><!-- /.new-review-form -->
                                </div><!-- /.col -->
                            </div><!-- /.add-review -->

                        </div><!-- /.tab-pane #reviews -->
                    </div><!-- /.tab-content -->

                </div><!-- /.tab-holder -->
            </div><!-- /.container -->
        </section><!-- /#single-product-tab -->
        <!-- ========================================= SINGLE PRODUCT TAB : END ========================================= -->
        <!-- ========================================= RECENTLY VIEWED ========================================= -->

        <!-- ========================================= RECENTLY VIEWED : END ========================================= -->		<!-- ============================================================= FOOTER ============================================================= -->
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

    <script src="http://code.jquery.com/jquery-latest.js"></script>
</body>
</html>
