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
    $.get(
        "/detail",{spuId:spuId},function(){
            location.href = "single-product.jsp";
        }
    );

};
var goToComment = function(spuId){
    $.get(
        "/detail",{spuId:spuId},function(){
            location.href = "single-product.jsp#reviews";
        }
    );
    var body   = $('body');
    var target = $("#reviews");
    body.animate({
        scrollTop:target.offset().top - body.offset().top + body.scrollTop()
    }, 1000);
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
var chooseSku = function(skuIndex){
    url = "single-product.jsp?skuIndex="+skuIndex;
    location.href = url;
};
var chooseAccessory = function(checkbox, axStrList, axName, axStr, axPrice){

    if ( checkbox.checked == true){//如果新选中一个ax
        //将新ax添加进List
        axStrList.push(axName);
        //构造ax字符串
        axStr = axStrList.join(" + ");
        //展示ax字符串
        var accessoryStr = $("#accessory-str");
        accessoryStr[0].attributes[1].value = axStr;
        accessoryStr.html('<text style="color:dimgrey">'+axStr+'</text>');

        //将axPrice存进hiiden标签
        var priceAccessory = $("#price-accessory");
        priceAccessory[0].attributes[1].value = (parseFloat(priceAccessory[0].attributes[1].value)+axPrice).toString();


    }else{//如果退选一个ax
        var index = axStrList.indexOf(axName);
        axStrList.splice(index,1);

        axStr = axStrList.join("+");
        var accessoryStr = $("#accessory-str");
        accessoryStr[0].attributes[1].value = axStr;
        accessoryStr.html('<text style="color:dimgrey">'+axStr+'</text>');

        var axTotalPrice = $("#price-accessory");
        axTotalPrice[0].attributes[1].value = (parseFloat(axTotalPrice[0].attributes[1].value)-axPrice).toString();
        // var cartTotalPrice = $("#price-current");
        // cartTotalPrice[0].attributes[2].value = (parseFloat(cartTotalPrice[0].attributes[2].value)-axPrice).toString();

        // if(axStr!='')
        //     $("#axTotalPrice").html(' + $'+axTotalPrice[0].attributes[1].value);
        // else
        //     $("#axTotalPrice").html("");
    }
    showCartTolPrice();
};
//single-product页面显示总价格
var calCartTolPrice = function(){
    //sku总单价
    var skuPrice = $("#price-current");
    skuPrice = parseFloat(skuPrice[0].attributes[2].value);
    //acessory总单价
    var axPrice = $("#price-accessory");
    axPrice = parseFloat(axPrice[0].attributes[1].value);
    //订货数
    var num = parseFloat($("#choose-num").val());

    var CartTotPrice = num * (skuPrice + axPrice);
    console.log("CartTotPrice = "+CartTotPrice);
    return CartTotPrice.toFixed(1);
};
var showCartTolPrice = function(){
    $("#price-current").html("$"+calCartTolPrice());
};
var showTotCartPrice = function(userId){
    var totCartPrice = 0;
    $.get(
        "/cart/getTotPrice",{userId:userId},function(data){
            totCartPrice = parseFloat(data);
            $("#tot-cart-price").html("$"+totCartPrice.toFixed(1));
            var transferFee = totCartPrice+10;
            $("#tot-transfer-price").html("$"+transferFee.toFixed(1));
        }
    );
};
//在cart.jsp修改商品数量
var changeNum2 = function(opr, skuId, cartId, userId){
    var oldNum = parseInt($("#choose-num-"+skuId).val());
    var stockNum = 0;
    $.get(
        "/sku/stockNum",{skuId:skuId},
        function(data){
            stockNum = data;
            console.log("stockNum="+stockNum);
        }
    );
    if(opr=='+') {
        if(oldNum+1 > stockNum)
            alert("inventory stock shortage");
        else
            $("#choose-num-"+skuId).val(oldNum + 1);
    }
    else if (opr=='-') {
        if(oldNum-1 > 0)
            $("#choose-num-"+skuId).val(oldNum - 1);
    }
    var totPrice = parseFloat($('#cart-tot-price-'+skuId)[0].attributes.value.value);
    var newNum = parseInt($("#choose-num-"+skuId).val());
    var newTotPrice = totPrice * newNum / oldNum;
    // console.log($('#cart-tot-price')[0].attributes.value.value);
    $('#cart-tot-price-'+skuId)[0].attributes.value.value = newTotPrice;
    $('#cart-tot-price-'+skuId).html("$"+(newTotPrice.toFixed(1)));
    $.get(
        "/cart/changeNum",{cartId,newNum},
        function(data){
            console.log("successful change num in db");
            showTotCartPrice(userId);
        }
    );
};
//在single-product.jsp修改商品数
var changeNum = function(opr,stockNum){
    // if($("#choose-num").val()==0)
    var oldVal = parseInt($("#choose-num").val());
    if(opr=='+') {
        if(oldVal+1 > stockNum)
            alert("inventory stock shortage");
        else
            $("#choose-num").val(oldVal + 1);
    }
    else if (opr=='-') {
        if(oldVal-1 > 0)
            $("#choose-num").val(oldVal - 1);
    }
    // var start = new Date().getTime();
    // var delay = 3000;
    // while(new Date().getTime() < start + delay);
    showCartTolPrice();
};

//cart.jsp
var addToCart = function(configSpecs,name,picture,num,spuId,skuId,userId){
    if(userId==""||userId==null){
        // console.log(window.location.href);
        notifyLogin(window.location.href);
    }else{
        alert("adding to cart...");
        var accessory = $("#accessory-str")[0].attributes[1].value;
        var totalPrice = $("#price-current")[0].attributes[2].value;
        num = $("#choose-num").val();

        if(num==0)
            alert("num cannot be 0");

        var stockNum=0;
        $.get(
            "/sku/stockNum",{skuId:skuId},
            function(data){
                stockNum = data;
                console.log("stockNum="+stockNum);

                if(num>stockNum) {
                    alert("inventory stock shortage, please reload your page");
                    checkProduct(spuId);
                }else
                    $.post(
                        "/cart/post", {configSpecs,accessory,name,picture,num,totalPrice,spuId,skuId,userId},
                        function (data) {
                            console.log(data);
                            alert(data);
                            location.reload();
                        }
                    );
            }
        );

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
        location.href = "/front-end/orders.jsp";
    }else{
        notifyLogin(window.location.href);
    }
};

var clickDelCart = function(cartId){
    if(window.confirm("Do you want to delete this product from the cart?")) {
        $.get(
            "/cart/del", {cartId: cartId}, function (data) {
                console.log(data);
                if (data != "")
                    location.href = location.href;
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
                location.href = "index.jsp";
            }
        );
    }
};
var registers = function(){

    var validFlag = 1;
    if($('#register-name').val()==""){
        $('#register-name').css("background-color","#fa7268");
        $('#register-name').focus();
        $('#notice-name').html('<text style=\"color: red; font-size: 10px\">' + "name cannot be blank" + '</text>');
        validFlag = 0;
    }else{
        $('#register-name').css("background-color","");
        $('#register-name').blur();
        $('#notice-name').html("");
    }
    if($('#register-password').val()==""){
        $('#register-password').css("background-color","#fa7268");
        $('#register-password').focus();
        $('#notice-pwd').html('<text style=\"color: red; font-size: 10px\">' + "password cannot be blank"+'</text>');
        validFlag = 0;
    }else{
        $('#register-password').css("background-color","");
        $('#register-password').blur();
        $('#notice-pwd').html("");
    }
    if($('#register-email').val()==""){
        $('#register-email').css("background-color","#fa7268");
        $('#register-email').focus();
        $('#notice-email').html('<text style=\"color: red; font-size: 10px\">'+"email cannot be blank"+'</text>');
        validFlag = 0;
    }else{
        $('#register-email').css("background-color","");
        $('#register-email').blur();
        $('#notice-email').html("");
    }
    if($('#register-phone').val()==""){
        $('#register-phone').css("background-color","#fa7268");
        $('#register-phone').focus();
        $('#notice-phone').html('<text style=\"color: red; font-size: 10px\">' + "phone cannot be blank"+'</text>');
        validFlag = 0;
    }else{
        $('#register-phone').css("background-color","");
        $('#register-phone').blur();
        $('#notice-phone').html("");
    }

    if(checkPwdStrength($('#register-password').val()<=2)){
        alert("password strength is too low, please consider having numbers, capital and lower case, signs in your password");
        return;
    }
    if(!$("#confirm-checkbox").prop("checked")){
        alert("please confirm that you agree on our privacy policy");
        return;
    }
    console.log("form:");
    console.log($('#register-from').serialize());
    if(validFlag==1){
        $.post(
            "/register", $('#register-from').serialize(), function (data) {

                if(data.indexOf("email")!=-1){
                    $('#register-email').css("background-color","#fa7268");
                    $('#register-email').focus();
                    $('#notice-email').html('<text style=\"color: red; font-size: 10px\">' + data + '</text>');
                }
                if(data.indexOf("phone")!=-1){
                    $('#register-phone').css("background-color","#fa7268");
                    $('#register-phone').focus();
                    $('#notice-phone').html('<text style=\"color: red; font-size: 10px\">' + data +'</text>');
                }
                alert(data);
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
    }else{
        alert("please input all the required information");
    }

};

var confirmCheckOut = function(userId){
    if(userId!="" && userId!=null){
        var payStatus = "";
        if(confirm("complete the payment"))
            payStatus = "paid";
        else
            payStatus = "unpaid";
        $.post(
            "/postOrder",{userId,payStatus},function(data){
                alert(data);
                if(data.indexOf("success") != -1) {
                    location.href = "orders.jsp"+"?userId="+userId;
                }else{
                    location.href = "cart.jsp"+"?userId="+userId;
                }
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
                li+='<li>'+'<a href="javascript:void(0);" onclick="goToCatSpu('+element.id+')">'+element.name+'</a>'+'<div style="float: right">('+element.spuNum +')</div></li>';
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
//orders.jsp
var filterPayStatus = function(userId){
    // $.get(
    //     "orders.jsp",
    //     {
    //         userId,
    //         payStatus
    //     },
    //     function(data){
    //         console.log("orders.jsp: successful filter");
    //         console.log(data);
    //     }
    // );
    userId = 3;
    var payStatus = $('#select-payStatus  option:selected').val();
    // console.log(userId);
    // console.log(payStatus);
    location.href = "orders.jsp?userId="+userId+"&payStatus="+payStatus;
};
var payBill = function(idStr){
    if(confirm("do you want to pay the bill?")) {
        var orderIdArr = idStr.split(';');
        for (var i = 0; i < orderIdArr.length - 1; i++) {//最后一项为空
            // console.log(orderIdArr[i]);
            $.post(
                "/order/pay",
                {orderId: orderIdArr[i]},
                function () {
                    console.log("payBill completed");
                }
            )
        }
        confirm("successful paid the bill");
        location.reload();
    }
};
var cancelBill = function(idStr){
    if(confirm("do you want to cancel the bill?")){
        var orderIdArr = idStr.split(';');
        for(var i=0; i<orderIdArr.length-1; i++){
            console.log(orderIdArr[i]);
            $.post(
                "/order/cancel",
                {orderId:orderIdArr[i]},
                function(){
                    console.log("cancel Bill completed");
                }
            )
        }
        confirm("successful canceled the bill");
        location.reload();
    }

};
var goToCatSpu = function(catId){
    location.href = "cat-spu.jsp?catId="+catId;
};

var loadCatSpu = function(catId){
    $.post(
        "/class/spu",
        {classId: catId},
        function(data){
            var spuVoList = JSON.parse(data);
            var html = template("tpl",{
                spuVoList: spuVoList,
            });
            $("#div-cat-spu").append(html);
        }
    )
};
var loadCatHierarchy = function(catId){
    $.post(
        "/class/hierarchy",
        {classId: catId},
        function(){
            console.log("cat-spu.jsp: successful load cat hierarchy");
        }
    )
};

var loadMoreDetail = function(spuId){
    $.post(
        "/SPU/moreDetail",{spuId:spuId},function(data){
            $("#more-detail").html(data);
        }
    )
};
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        + " " + date.getHours() + seperator2 + date.getMinutes()
        + seperator2 + date.getSeconds();
    return currentdate;
}
var submitComment = function(userName){
    if(userName==null || userName==""){
        notifyLogin(location.href);
        return;
    }
    var date = getNowFormatDate();
    var starNum = $("#star-num-div")[0].lastChild.defaultValue;
    var stars = [];
    for(var cnt=0; cnt<starNum; cnt++){
        stars.push("assets/images/star-big-on.png");
    }
    for(var cnt=0; cnt<5-starNum; cnt++){
        stars.push("assets/images/star-big-off.png");
    }
    var html = template("tpl",{
        userName : userName,
        starNum : starNum,
        star1 : stars[0],
        star2 : stars[1],
        star3 : stars[2],
        star4 : stars[3],
        star5 : stars[4],
        comment : $("#comment-text").val(),
        time : date
    });
    $("#comments-list").append(html);
    location.href = "#comments-list";
    $("#star-num-div")[0].lastChild.defaultValue = 0;
    $("#comment-text").val("");

};
var updateName = function(userId, name){
    if(name==null || name=="") {
        $("#modi-name-input").css("border-color","red");
        $("#modi-name-input").focus();
        $("#notice-name").html('<text style="color: red; font-size: 10px; margin-top: 0">please input new name</text>');
    }else
    $.post(
        "/user/modify",
        {
            userId: userId,
            mod: "information",
            changeInfo: "name",
            name: name
        },
        function(data){
            if(data=="success") {
                $("#notice-name").html("");
                $("#modi-name-input").css("border-color","");
                $("#modi-name-input").blur();
                alert(data);
                location.href = location.href;
            }else{
                $("#notice-name").html('<text style="color: red; font-size: 10px">' + data + '</text>');
                $("#modi-name-input").css("border-color","red");
                $("#modi-name-input").focus();
                alert(data);
            }
        }
    )
};
var updatePhone = function(userId, phone){
    if(phone==null || phone=="") {
        $("#modi-phone-input").css("border-color","red");
        $("#modi-phone-input").focus();
        $("#notice-phone").html('<text style="color: red; font-size: 10px">please input new phone number</text>');
    }else
    $.post(
        "/user/modify",
        {
            userId: userId,
            mod: "information",
            changeInfo: "phone",
            phone: phone
        },
        function(data){
            if(data=="success") {
                $("#notice-phone").html("");
                $("#modi-phone-input").css("border-color","");
                $("#modi-phone-input").blur();
                alert(data);
                location.href = location.href;
            }else{
                $("#notice-phone").html('<text style="color: red; font-size: 10px">' + data + '</text>');
                $("#modi-phone-input").css("border-color","red");
                $("#modi-phone-input").focus();
                alert(data);
            }
        }
    )
};
var updateEmail = function(userId, email){
    if(email==null || email=="") {
        $("#modi-email-input").css("border-color","red");
        $("#modi-email-input").focus();
        $("#notice-email").html('<text style="color: red; font-size: 10px">please input new email</text>');
    }else
    $.post(
        "/user/modify",
        {
            userId: userId,
            mod: "information",
            changeInfo: "email",
            email: email
        },
        function(data){
            if(data=="success") {
                $("#notice-email").html("");
                $("#modi-email-input").css("border-color","");
                $("#modi-email-input").blur();
                alert(data);
                location.href = location.href;
            }else{
                $("#notice-email").html('<text style="color: red; font-size: 10px">' + data + '</text>');
                $("#modi-email-input").css("border-color","red");
                $("#modi-email-input").focus();
                alert(data);
            }
        }
    )
};
var checkConsistentPwd = function(input1, input2){

    if(input1!=input2) {
        $("#notice").html('<text style="color: red; font-size: 10px">inconsistent inputs</text>');
        $("#confirm-pwd").css("border-color","red");
        $("#confirm-pwd").focus();
        $("#new-pwd").css("border-color","red");
        $("#new-pwd").focus();
    }else {
        $("#notice").html("");
        $("#confirm-pwd").css("border-color","");
        $("#confirm-pwd").blur();
        $("#new-pwd").css("border-color","");
        $("#new-pwd").blur();
    }
};
var updatePwd = function(userId, oldPwd, newPwd){
    var confirmPwd = $("#confirm-pwd").val();
    if(newPwd!=confirmPwd) {
        alert("two inputs must be consistent");
    }else
    $.post(
        "/user/modify",
        {
            userId: userId,
            mod: "password",
            oldPwd: oldPwd,
            newPwd: newPwd
        },
        function(data){
            if(data=="success"){
                $("#old-pwd").css("border-color","");
                $("#old-pwd").blur();
                alert(data);
                location.href = location.href;
            }else{
                $("#notice2").html('<text style="color: red; font-size: 10px">invalid old password</text>');
                $("#old-pwd").css("border-color","red");
                $("#old-pwd").focus();
                alert(data);
            }

        }
    )
};
var isNameValid = function(name){
    if(name != null && name != ''){
        $('#register-name').css('background-color','');
        $('#notice-name').html('');
    }else{
        $('#register-name').css("background-color","#fa7268");
        $('#register-name').focus();
        $('#notice-name').html('<text style=\"color: red; font-size: 10px\">' + "name cannot be blank"+'</text>');
    }
};
var isPhoneValid = function(phone){
    if(phone != null && phone != ''){
        $('#register-phone').css('background-color','');
        $('#notice-phone').html('');
    }else{
        $('#register-phone').css("background-color","#fa7268");
        $('#register-phone').focus();
        $('#notice-phone').html('<text style=\"color: red; font-size: 10px\">' + "phone cannot be blank"+'</text>');
    }
};
var isEmailValid = function(email){
    if(email != null && email != ''){
        $('#register-email').css('background-color','');
        $('#notice-email').html('');
    }else{
        $('#register-email').css("background-color","#fa7268");
        $('#register-email').focus();
        $('#notice-email').html('<text style=\"color: red; font-size: 10px\">' + "email cannot be blank"+'</text>');
    }
};
var isPwdValid = function(pwd){
    if(pwd != null && pwd != ''){
        $('#register-password').css('background-color','');
        $('#notice-pwd').html('');

        var modes = checkPwdStrength(pwd);
        if(modes<=2){
            $('#register-password').css('background-color','#fa7268');
            $('#notice-pwd').html('<text style="color: red; font-size: 10px">password strength is too low</text>');
        }else if(modes==3){
            $('#register-password').css('background-color','');
            $('#notice-pwd').html('<text style="color: orange; font-size: 10px">password strength is medium</text>');
        }else{
            $('#register-password').css('background-color','');
            $('#notice-pwd').html('<text style="color: forestgreen; font-size: 10px">password strength is high</text>');
        }
    }else{
        $('#register-password').css("background-color","#fa7268");
        $('#register-password').focus();
        $('#notice-pwd').html('<text style=\"color: red; font-size: 10px\">' + "password cannot be blank"+'</text>');
    }

};
var checkPwdStrength = function(value){
    var modes =  0;
    if(value==''){//最初级别
        return modes;
    }
    if(/\d/.test(value)){//如果用户输入的密码 包含了数字
        modes++;
    }
    if(/[a-z]/.test(value)){//如果用户输入的密码 包含了小写的a到z
        modes++;
    }
    if(/[A-Z]/.test(value)){//如果用户输入的密码 包含了大写的A到Z
        modes++;
    }
    if(/\W/.test(value)){//如果是非数字 字母 下划线
        modes++;
    }
    return modes;
};