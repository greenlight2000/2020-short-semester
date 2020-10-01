/*function register(){
    var user=document.getElementById("name").value;
    var password=document.getElementById("password").value;
    var email=document.getElementById("email").value;
    var phone=document.getElementById("phone").value;
    var reg1=/^\w{3,}$/;  //password format（only numbers, letters or underscores, and at least 3 characters)
    var reg2=/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;  //email format xxx@xxx.xxx or xxx@xxx.xxx.xxx
    var reg3=/^1[34578]\d{9}$/; //phone format xxxxxxxxxxx
    if(reg1.test(password)==true && user.length>0 && reg2.test(email) == true && reg3.test(phone) == true){
        //提交表单
        document.forms[1].submit();
    }
    else{
        if(user.length==0){
            alert("User name can not be empty!");
            return;
        }
        else if(reg1.test(password)==false) {
            alert("The format of your password is wrong. Please include only numbers, letters or underscores.(at least 3 characters)");
            return;
        }
        else if (reg2.test(email)==false){
            alert("Your email format is wrong. PLease correct it.");
            return;
        }
        else if (reg3.test(phone)==false){
            alert("Your phone format is wrong. Please correct it.");
            return;
        }
    }
    alert("注册成功!");
}*/

/*//post name and password to LoginServlet.java
$(document).ready(function(){
	$('#logi').click(function(){
		$.post("/Servlet/LoginServlet.java",{
			name:$("#name").val(),
			password:$("#password").val()
		});
        $.get("/Servlet/LoginServlet.java",function(data,status){
                if (data != "success"){ alert(data); }  //需要后台在成功的情况下返回success
                //若后端跳转则不需要  else{   window.location.href = "Home.html"; }
            });

	});
}) //需要该java函数中response.sendRedirect(“Home.html”);*/

$(document).ready(function(){
    $('#logi').click(function(){
        $.ajax({
            url:'/login',  //post到的地方
            data:{
                name:$("#name").val(),
                password:$("#password").val()
            },
            dataType:"text",
            type:"Post",
            success:function(data){
                if (
                    data === "no such user" || data === "invalid password"){alert(data);
                }  //需要后台在成功的情况下返回success
                else{
                    alert(data); window.sessionStorage.setItem("userId",data);
                    window.location.href = "Home.html";
                }
            }
        })
    });
});

/*//post name and password to RegisterServlet.java
$(document).ready(function(){
    $('#submi').click(function(){
        $.post("/Servlet/RegisterServlet.java",{
            name:$("#name").val(),
            password:$("#password").val(),
            phone:$("#phone").val(),
            email:$("#email").val()
        });
        $.get("/Servlet/RegisterServlet.java",function(data,status){
                if (data != "success"){ alert(data); }
                //若后端跳转则不需要  else{   window.location.href = "Home.html"; }
            });
    });
}) //需要该java函数中response.sendRedirect(“Login.html”);*/

$(document).ready(function(){
    $('#submi').click(function(){
        $.ajax({
            url:'/register',
            data:{
                name:$("#name").val(),
                password:$("#password").val(),
                phone:$("#phone").val(),
                email:$("#email").val()
            },
            dataType:"text",
            type:"Post",
            /*beforeSend:function(){
                alert("hi");
            },*/
            success:function(data){
                if (data == "success"){
                    alert(data);
                    window.location.href = "Home.html";
                }  //需要后台在成功的情况下返回success
                else{
                    alert(data);
                }
            }
        })
    });
})