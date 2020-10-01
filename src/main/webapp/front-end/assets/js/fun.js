//product-list.jsp
var clickSearch = function(sortKey,pageNum){
    var value = $('#keywords-input').val();
    var keyIndex = $('#search-by-box')[0].tabIndex;
    var key = "";
    console.log(keyIndex);
    switch (keyIndex) {
        case 2:
            key="description";
            break;
        case 3:
            key="brand";
            break;
        default:
            key="name";
    }
    if(value==null)
        value="";
    if(sortKey==null)
        sortKey="launchTime";
    if(pageNum==null)
        pageNum=1;
    const url = "/find?key="+key+"&value="+value+"&isFuzzy=true&usePage=true&sortKey="+sortKey+"&pageNum="+pageNum;
    console.log(url);
    location.href=url;

};

var chooseSearchBy = function(choice){
    $("#search-by-box")[0].innerText = choice.innerText;
    $("#search-by-box")[0].tabIndex = choice.tabIndex;
};

var checkProduct = function(spuId){
    console.log(spuId);
    $.get(
        "/detail",{spuId:spuId},function(data){
            console("data="+data);
        }
    );
};

var clickSort = function(key,value){
    var sortKey = $("#select-sort-key option:selected").val();
    var sortAsc = $("#select-sort-dir option:selected").val();
    var pageNum = 1;
    const url = "/find?key="+key+"&value="+value+"&isFuzzy=true&usePage=true&sortKey="+sortKey+"&sortAsc="+sortAsc+"&pageNum="+pageNum;
    location.href=url;
};

var changeGrid = function(){
    $("#grid-href").className = "grid-list-button-item active";
    $("#list-href").className = "grid-list-button-item";
    console.log($("#grid-href").className);
    console.log($("#list-href").className);
};
var changeList = function(){
    $("#grid-href").className = "grid-list-button-item";
    $("#list-href").className = "grid-list-button-item active";
    console.log($("#grid-href").className);
    console.log($("#list-href").className);
};

var changePage = function(key,value,sortKey,sortAsc,toPage){
    const url = "/find?key="+key+"&value="+value+"&isFuzzy=true&usePage=true&sortKey="+sortKey+"&sortAsc="+sortAsc+"&pageNum="+toPage;
    location.href=url;
};


//single-product.jsp
var chooseSku = function(spuIndex,skuIndex){
    url = "single-product.jsp?spuIndex="+spuIndex+"&skuIndex="+skuIndex;
    location.href = url;
};
var chooseAccessory = function(checkbox, axStrList, axName, axStr, axPrice){

    if ( checkbox.checked == true){
        axStrList.push(axName);

        axStr = axStrList.join("➕");
        var accessoryStr = $("#accessory-str");
        accessoryStr[0].attributes[1].value = axStr;
        accessoryStr.html(axStr);


        var axTotalPrice = $("#price-accessory");
        axTotalPrice[0].attributes[1].value = (parseFloat(axTotalPrice[0].attributes[1].value)+axPrice).toString();
        var cartTotalPrice = $("#price-current");
        cartTotalPrice[0].attributes[2].value = (parseFloat( cartTotalPrice[0].attributes[2].value)+axPrice).toString();

        if(axStr!='')
            $("#axTotalPrice").html(' + $'+axTotalPrice[0].attributes[1].value);
        else
            $("#axTotalPrice").html("");
    }else{
        var index = axStrList.indexOf(axName);
        axStrList.splice(index,1);

        axStr = axStrList.join("➕");
        var accessoryStr = $("#accessory-str");
        accessoryStr[0].attributes[1].value = axStr;
        accessoryStr.html(axStr);

        var axTotalPrice = $("#price-accessory");
        axTotalPrice[0].attributes[1].value = (parseFloat(axTotalPrice[0].attributes[1].value)-axPrice).toString();
        var cartTotalPrice = $("#price-current");
        cartTotalPrice[0].attributes[2].value = (parseFloat(cartTotalPrice[0].attributes[2].value)-axPrice).toString();

        if(axStr!='')
            $("#axTotalPrice").html(' + $'+axTotalPrice[0].attributes[1].value);
        else
            $("#axTotalPrice").html("");
    }
};
var testJsp = function(jspObj){
    console.log(jspObj);
};

//cart.jsp
var addToCart = function(configSpecs,name,picture,num,spuId,userId){
    if(userId==""||userId==null){
        // console.log(window.location.href);
        notifyLogin(window.location.href);
    }else{
        alert("adding to cart...");
        var accessory = $("#accessory-str")[0].attributes[1].value;
        var totalPrice = $("#price-current")[0].attributes[2].value;
        $.post(
            "/cart/post", {configSpecs,accessory,name,picture,num,totalPrice,spuId,userId},function (data) {
                console.log(data);
                alert(data);
            }
        ).then(location.reload);
    }
};

var goToCart = function(userId){
    if(userId!="" && userId!=null){
        location.href = "/front-end/cart.jsp";
    }else{
        notifyLogin(window.location.href);
    }
};
var goToOrder = function(userId){
    if(userId!="" && userId!=null){
        location.href = "/front-end/orders.jsp"+"?userId="+userId;
    }else{
        notifyLogin(window.location.href);
    }
};

var clickDelCart = function(cartId){
    if(window.confirm("Do you want to delete this product from the cart?")) {
        $.get(
            "/cart/del", {cartId: cartId}, function (data) {
                console.log(data);
                location.reload();
            }
        );

    }
};

//authentication.jsp
var notAvailable = function(){
    window.confirm("sorry, this function is not currently available");
};
var login = function(){
    var validFlag = 1;
    if($('#login-name').val()=="" || $('#login-pwd').val()==""){
        window.alert("Please input your user name and password");
        validFlag = 0;
    }
    if(validFlag == 1) {
        $.post(
            "/login", $('#login-form').serialize(), function (data) {
                var ret = data.split(";");
                alert(ret[0]);
                if(data.indexOf("welcome")!=-1){
                    // location.reload();
                    console.log("authentication.jsp: successful login");
                    window.location.href = ret[1];
                }else
                    console.log("authentication.jsp: fail to login");

            }
        )
    }
};
var notifyLogin = function(preUrl){
    alert("Please login first");
    location.href = "/front-end/authentication.jsp"+"?preUrl="+preUrl;
};
var logout = function(){
    if(window.confirm("do you want to log out?")){
        $.post(
            "/logout",function(data){
                alert("successful logout");
                location.reload()
            }
        );
    }
};
var registers = function(){
    var validFlag = 1;
    if($('#register-name').val()=="" || $('#register-password').val()=="" || $('#register-email').val()=="" || $('#register-phone').val()==""){
        window.alert("Please fill in all the info");
        validFlag = 0;
    }
    console.log("form:");
    console.log($('#register-from').serialize());
    if(validFlag==1){
        $.post(
            "/register", $('#register-from').serialize(), function (data) {
                alert(data);
                console.log(data);
                if(data.indexOf("success")!=-1){
                    var url = "";
                    if(confirm("login to access more content?"))
                        url = "authentication.jsp";
                    else
                        url = "index.jsp";
                    location.href = url;
                }

            }
        );
    }

};

var confirmCheckOut = function(userId){
    if(userId!="" && userId!=null){
        $.post(
            "/postOrder",{userId},function(data){
                alert("successful checkout");
                location.href = "orders.jsp"+"?userId="+userId;
            }
        )
    }else {
        alert("your identification is outdated, please login first");
        location.href = "authentication.jsp";
    }
};


//index.jsp
var loadChildClass = function(classId){
    $.get(
        "/class",{param:"child",id:classId},function(data){
            // console.log(data);
            var childVoList = JSON.parse(data);
            // console.log(childVoList[0].name);
            var li = "";
            for(let element of childVoList){
                li+='<li>'+'<a href="#">'+element.name+'</a>'+'</li>';
            }
            $("#class-list-"+classId).html(li);

        }
    )
};
var loadRecommendSPU = function(pageNum){
    $.get(
        "/SPU/load",
        {
            sortKey:"id",
            sortAsc:"false",
            pageSize:4,
            pageNum:pageNum
        },
        function(data){
            var spuVoList = JSON.parse(data);
            var html = template("tpl",{
                spuVoList: spuVoList,
                ribbonText:"recommend",
                ribbonType:"ribbon green"
            });
            $("#div-recommend-spu").append('</div>'+html+'<div>');
        }
    )
};

var loadBestSellSPU = function(pageNum){
    $.get(
        "/SPU/load",
        {
            sortKey:"sales",
            sortAsc:"false",
            pageSize:4,
            pageNum: pageNum
        },
        function(data){
            var spuVoList = JSON.parse(data);
            var html = template("tpl",{
                spuVoList: spuVoList,
                ribbonText:"best seller",
                ribbonType:"ribbon red"
            });
            console.log(html);
            $("#div-bs-spu").append('</div>'+html+'<div>');
        }
    )
};
var loadNewSPU = function(pageNum){
    console.log("loadNewSPU");
    $.get(
        "/SPU/load",
        {
            sortKey:"launchTime",
            sortAsc:"false",
            pageSize:4,
            pageNum:pageNum
        },
        function(data){
            var spuVoList = JSON.parse(data);
            var html = template("tpl",{
                spuVoList: spuVoList,
                ribbonText:"newest",
                ribbonType:"ribbon blue"
            });
            $("#div-new-spu").append('</div>'+html+'<div>');
        }
    )
};