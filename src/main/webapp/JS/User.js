
//confirm login ok
$(document).ready(function(){
    $('#logi').click(function(){
        $.ajax({
            url:'/src/Servlet/LoginServlet.java',  //检查login信息是否可以登录
            data:{
                name:$("#name").val(),
                password:$("#password").val()
            },
            dataType:"text",  //返回类型text
            type:"Post",  
            success:function(data){
				if ( data == "no such user" || data == "invalid password" ){alert(data); } 
                else{   
					var name = $("#name").val();
                    window.sessionStorage.setItem("userId",data);
					window.sessionStorage.setItem("userName", name);
                    window.location.href = "Home.html"; 
                }
            }
        })
    });
})

//confirm register ok
$(document).ready(function(){
    $('#submi').click(function(){
        $.ajax({
            url:'/src/Servlet/RegisterServlet.java',  //register是否成功
            data:{
                name:$("#name").val(),
                password:$("#password").val(),
                phone:$("#phone").val(),
                email:$("#email").val()
            },
            dataType:"text",  //返回类型text
            type:"Post",
            success:function(data){
                if (data !== "success"){ alert(data); }  //需要后台在成功的情况下返回success
                else{   window.location.href = "Login.html"; }
            }
        })
    });
})

//confirm new phone number ok
$(document).ready(function(){
    $('#subChanPhone').click(function(){
        $.ajax({
            url:'/src/Servlet/ChangePhoneServlet.java',  //改变电话号码
            data:{
				id:window.sessionStorage.getItem("userId"),
                oldPhone:$("#oldPhone").val(),
                newPhone:$("#newPhone").val()
            },
            dataType:"text",  //返回类型text
            type:"Post",
            success:function(data){
                if (data !== "success"){ alert(data); }  //需要后台在成功的情况下返回success
                else{   alert("Successfully change your phone number!"); }
            }
        })
    });
})

//confirm new password ok
$(document).ready(function(){
    $('#subChanPassword').click(function(){
        $.ajax({
            url:'/src/Servlet/ChangePasswordServlet.java',  //改变密码
			data:{
				id:window.sessionStorage.getItem("userId"),
                pastPassword:$("#pastPassword").val(),
                newPassword:$("#newPassword").val(),
                ConfirmNewPassword:$("#ConfirmNewPassword").val()
            },
            dataType:"text",  //返回类型text
            type:"Post",
            success:function(data){
                if (data !== "success"){ alert(data); }  //需要后台在成功的情况下返回success
                else{   
					//var newPassword = $("#newPassword").val();
					//sessionStorage.setItem("userPassword", newPassword);
					alert("Successfully change your password!"); 
				}
            }
        })
    });
})

//confirm new email ok
$(document).ready(function(){
    $('#SubChanEmail').click(function(){
        $.ajax({
            url:'/src/Servlet/ChangeEmailServlet.java',  //改变邮箱地址
            data:{
				id:window.sessionStorage.getItem("userId"),
                oldEmail:$("#oldEmail").val(),
                newEmail:$("#newEmail").val()
            },
            dataType:"text",  //返回类型text
            type:"Post",
            success:function(data){
                if (data !== "success"){ alert(data); }  //需要后台在成功的情况下返回success
                else{  alert("Successfully change your email!");  }
            }
        })
    });
})

//when click personal center, check whether one login
function checkUserLogin(){
	var checkLog = window.sessionStorage.getItem("id");
	if (checkLog == ""){	alert("Please login first");	}
	else{	window.location.href = "Person.html";	}  
}

//when click cart, check whether one login
function checkUserLoginCart(){
	var checkLog = window.sessionStorage.getItem("id");
	if (checkLog == ""){	alert("Please login first");	}
	else{	window.location.href = "Cart.html";	}
}

//个人信息界面
$(document).ready(function(){
    $('#persInfo').click(function(){
        $.ajax({
            url:'/src/Servlet/LoginServlet.java',  //路径要求：接收username后，能去数据库找User表，并返回phone number和email
            data:{ id:window.sessionStorage.getItem("userId")},   //saved userId from the success of login
			dataType:"json", 
            type:"Post",
			success:function(list){  
				if (JSON.stringify(list) == "[]"){	alert("Error");	}
				else{  //phone number email
					var first = list[0]; //Object
					var key1 = "name";
					var key2 = "phone";
					var key3 = "email";
					var name = eval('first.'+key1);  //String
					var phone = eval('first.'+key2);
					var email = eval('first.'+key3);
					document.getElementById("myName").innerHTML=name;					document.getElementById("myPhone").innerHTML=phone;
					document.getElementById("myEmail").innerHTML=email;
				}
			}
		})
	});
})

//fuzzy search
$(document).ready(function(){
    $('#searchProducts').click(function(){
        $.ajax({
            url:'find',  //路径要求：接受字符串，返回符合条件的SPU的信息
            data:{
            	key:"name",
				value:document.getElementById("keyworddd").innerHTML,
				usePage:"false"
			},   //saved fuzzy name
			dataType:"json",
            type:"Post",
            success:function(list){  //返回N个值，我只需要name+picture路径+description+time+price，返回样式[{},{}]
				if (JSON.stringify(list) == "[]"){	alert("No such products");	}
				else{
					var listString = JSON.stringify(list);  //json转String
					var listTest = eval("("+listString+")");  //转数组
					var number = listTest.length;  //得到长度，即页面上出现的商品数，一定大于等于1
					var first = list[0]; //Object
					var second = list[1];
					var third = list[2];
					var fourth = llist[3];
					var key1 = "name";
					var key2 = "launchTime";
					var key3 = "description";
					var key4 = "picture";
					var key5 = "price";
					//商品1的新数据
					var name1 = eval('first.'+key1);  //String
					var launchTime1 = eval('first.'+key2);
					var description1 = eval('first.'+key3);
					var picture1 = eval('first.'+key4);
					var price1 = eval('first.'+key5);
					//替换原商品一位置的内容
					document.getElementById("name1").innerHTML=name1;
					document.getElementById("time1").innerHTML=launchTime1;
					document.getElementById("picture1").src=picture1;
					document.getElementById('description1').src=description1;
					document.getElementById("price1").innerHTML=price1;
					if(number <2){ //将其余三个商品位置设置为空
						document.getElementById("prod2").style.display="none";//隐藏设置
						document.getElementById("prod3").style.display="none";
						document.getElementById("prod4").style.display="none";
					}else{  //商品2的新数据
						var name2 = eval('second.'+key1);  //String
						var launchTime2 = eval('second.'+key2);
						var description2 = eval('second.'+key3);
						var picture2 = eval('second.'+key4);
						var price2 = eval('second.'+key5);
						//替换原商品二位置的内容
						document.getElementById("name2").innerHTML=name2;
						document.getElementById("time2").innerHTML=launchTime2;
						document.getElementById("picture2").src=picture2;
						document.getElementById('description2').src =description2;
						document.getElementById('price2').src =price2;
						if(number < 3){//将其余两个商品位置设置为空
							document.getElementById("prod3").style.display="none";
							document.getElementById("prod4").style.display="none";
						}else{
							var name3 = eval('third.'+key1);  //String
							var launchTime3 = eval('third.'+key2);
							var description3 = eval('third.'+key3);
							var picture3 = eval('third.'+key4);
							var price3 = eval('third.'+key5);
							//替换原商品三位置的内容
							document.getElementById("name3").innerHTML=name3;
							document.getElementById("time3").innerHTML=launchTime3;
							document.getElementById("picture3").src=picture3;
							document.getElementById('description3').src =description3;
							document.getElementById('price3').src =price3;
							if(number < 4){ //最后一个产品位置设置为空
								document.getElementById("prod4").style.display="none";
							}else{
								var name4 = eval('fourth.'+key1);  //String
								var launchTime4 = eval('fourth.'+key2);
								var description4 = eval('fourth.'+key3);
								var picture4 = eval('fourth.'+key4);
								var price4 = eval('fourth.'+key5);
								//替换原商品四位置的内容
								document.getElementById("name4").innerHTML=name4;
								document.getElementById("time4").innerHTML=launchTime4;
								document.getElementById("picture4").src=picture4;
								document.getElementById('description4').src =description4;
								document.getElementById('price4').src =price4;
							}
						}
					}
				}
			}
		})
	});
})

//sort products by launch time
$(document).ready(function(){
    $('#sortPro').click(function(){
        $.ajax({
            url:'find', //路径要求：按照上架时间排序
            data:{
            	key:name,
				value:"",
				sortKey:"launchTime",
				usePage:"false"
			},
			dataType:"json",
			type:"Post",
			success:function(list){ 
				//新顺序信息
				var listString = JSON.stringify(list);  //json转String
				var listTest = eval("("+listString+")");  //转数组
				var first = list[0]; //Object
				var second = list[1];
				var third = list[2];
				var fourth = llist[3];
				//界面需展示信息
				var key1 = "name";
				var key2 = "launchTime";
				var key3 = "description";
				var key4 = "picture";
				var key5 = "price";
				//商品1的新数据
				var name1 = eval('first.'+key1);  //String
				var launchTime1 = eval('first.'+key2);
				var description1 = eval('first.'+key3);
				var picture1 = eval('first.'+key4);
				var price1 = eval('first.'+key5);
				//替换原商品一位置的内容
				document.getElementById("name1").innerHTML=name1;
				document.getElementById("time1").innerHTML=launchTime1;
				document.getElementById("picture1").src=picture1;
				document.getElementById('description1').src =description1;
				document.getElementById('price1').src =price1;
				//商品2的新数据
				var name2 = eval('second.'+key1);  //String
				var launchTime2 = eval('second.'+key2);
				var description2 = eval('second.'+key3);
				var picture2 = eval('second.'+key4);
				var price2 = eval('second.'+key5);
				//替换原商品二位置的内容
				document.getElementById("name2").innerHTML=name2;
				document.getElementById("time2").innerHTML=launchTime2;
				document.getElementById("picture2").src=picture2;
				document.getElementById('description2').src =description2;
				document.getElementById('price2').src =price2;
				//商品3的新数据
				var name3 = eval('third.'+key1);  //String
				var launchTime3 = eval('third.'+key2);
				var description3 = eval('third.'+key3);
				var picture3 = eval('third.'+key4);
				var price3 = eval('third.'+key5);
				//替换原商品三位置的内容
				document.getElementById("name3").innerHTML=name3;
				document.getElementById("time3").innerHTML=launchTime3;
				document.getElementById("picture3").src=picture3;
				document.getElementById('description3').src =description3;
				document.getElementById('price3').src =price3;
				//商品4的新数据
				var name4 = eval('fourth.'+key1);  //String
				var launchTime4 = eval('fourth.'+key2);
				var description4 = eval('fourth.'+key3);
				var picture4 = eval('fourth.'+key4);
				var price4 = eval('fourth.'+key5);
				//替换原商品四位置的内容
				document.getElementById("name4").innerHTML=name4;
				document.getElementById("time4").innerHTML=launchTime4;
				document.getElementById("picture4").src=picture4;
				document.getElementById('description4').src =description4;
				document.getElementById('price4').src =price4;
			}
		})
	});
})


//back to Products.html from cart
$(document).ready(function(){
    $('#backProduct').click(function(){
        window.location.href = "Products.html"; 
    });
})


//点击第一个商品的read more跳转产品详情页面
$(document).ready(function(){
    $('#bbtt1').click(function(){
		//获取SKU信息
        $.ajax({
            url:'/src/Servlet/LoginServlet.java',  //路径要求：接受商品名，返回符合条件的SKU的信息
            data:{	
				name:document.getElementById("name1").innerHTML
			},
			dataType:"json",
            type:"Post",
            success:function(list){  //返回六个值，我只需要name+total_price+config_specs，返回样式[{},{},{},{}]
				if (JSON.stringify(list) == "[]"){	alert("Error");	}
				else{
					var first = list[0]; //Object
					var second = list[1];
					var third = list[2];
					var fourth = llist[3];
					var key1 = "name";  //取出一个即可
					var key2 = "total_price";  //取出第一个即可
					var key3 = "config_specs";
					//SKU的数据
					var name = eval('first.'+key1);  //String
					var total_price = eval('first.'+key2);  //String  
					var config1 = eval('first.'+key3);  //json形式的第一个config_specs的value(也是json)
					var config2 = eval('second.'+key3);
					var config3 = eval('third.'+key3);
					var config4 = eval('fourth.'+key3);
					//config_specs第一个值
					var specs1 = JSON.stringify(config1);  //{"":"","",""}
					specs1 = specs1.substring(2, specs1.length-1).replace(/\"/g,"");
					//config_specs第二个值
					var specs2 = JSON.stringify(config2);
					specs2 = specs2.substring(2, specs2.length-1).replace(/\"/g,"");
					//config_specs第三个值
					var specs3 = JSON.stringify(config3);
					specs3 = specs3.substring(2, specs3.length-1).replace(/\"/g,"");
					//config_specs第四个值
					var specs4 = JSON.stringify(config4);
					specs4 = specs4.substring(2, specs4.length-1).replace(/\"/g,"");
					//替换product1.html部分内容
					document.getElementById("proName").innerHTML="&nbsp;&nbsp;"+name;
					document.getElementById("proConPrice").innerHTML=total_price;
					document.getElementById("config1").innerHTML=specs1;
					document.getElementById("config2").innerHTML=specs2;
					document.getElementById("config3").innerHTML=specs3;
					document.getElementById("config4").innerHTML=specs4;
					//替换picture的路径
					var pictu = document.getElementById("picture1").src;
					$("#proPicture").attr("src",pictu);
				}
			}
		})
    });
})

//点击第二个商品的read more跳转产品详情页面
$(document).ready(function(){
    $('#bbtt2').click(function(){
		//获取SKU信息
        $.ajax({
            url:'/src/Servlet/LoginServlet.java',  //路径要求：接受商品名，返回符合条件的SKU的信息
            data:{	name:document.getElementById("name2").innerHTML},
			dataType:"json",
            type:"Post",
            success:function(list){  //返回六个值，我只需要name+total_price+config_specs，返回样式[{},{},{},{}]
				if (JSON.stringify(list) == "[]"){	alert("Error");	}
				else{
					var first = list[0]; //Object
					var second = list[1];
					var third = list[2];
					var fourth = llist[3];
					var key1 = "name";  //取出一个即可
					var key2 = "total_price";  //取出第一个即可
					var key3 = "config_specs";
					//SKU的数据
					var name = eval('first.'+key1);  //String
					var total_price = eval('first.'+key2);  //String  
					var config1 = eval('first.'+key3);  //json形式的第一个config_specs的value(也是json)
					var config2 = eval('second.'+key3);
					var config3 = eval('third.'+key3);
					var config4 = eval('fourth.'+key3); 
					//config_specs第一个值
					var specs1 = JSON.stringify(config1);  //{"":"","",""}
					specs1 = specs1.substring(2, specs1.length-1).replace(/\"/g,"");
					//config_specs第二个值
					var specs2 = JSON.stringify(config2);
					specs2 = specs2.substring(2, specs2.length-1).replace(/\"/g,"");
					//config_specs第三个值
					var specs3 = JSON.stringify(config3);
					specs3 = specs3.substring(2, specs3.length-1).replace(/\"/g,"");
					//config_specs第四个值
					var specs4 = JSON.stringify(config4);
					specs4 = specs4.substring(2, specs4.length-1).replace(/\"/g,"");
					//替换product1.html部分内容
					document.getElementById("proName").innerHTML="&nbsp;&nbsp;"+name;
					document.getElementById("proConPrice").innerHTML=total_price;
					document.getElementById("config1").innerHTML=specs1;
					document.getElementById("config2").innerHTML=specs2;
					document.getElementById("config3").innerHTML=specs3;
					document.getElementById("config4").innerHTML=specs4;
					//替换picture的路径
					var pictu = document.getElementById("picture2").src;
					$("#proPicture").attr("src",pictu);
				}
			}
		})
    });
})

//点击第三个商品的read more跳转产品详情页面
$(document).ready(function(){
    $('#bbtt3').click(function(){
		//获取SKU信息
        $.ajax({
            url:'/src/Servlet/LoginServlet.java',  //路径要求：接受商品名，返回符合条件的SKU的信息
            data:{	
				name:document.getElementById("name3").innerHTML
			},
			dataType:"json",
            type:"Post",
            success:function(list){  //返回六个值，我只需要name+total_price+config_specs，返回样式[{},{},{},{}]
				if (JSON.stringify(list) == "[]"){	alert("Error");	}
				else{
					var first = list[0]; //Object
					var second = list[1];
					var third = list[2];
					var fourth = llist[3];
					var key1 = "name";  //取出一个即可
					var key2 = "total_price";  //取出第一个即可
					var key3 = "config_specs";
					//SKU的数据
					var name = eval('first.'+key1);  //String
					var total_price = eval('first.'+key2);  //String  
					var config1 = eval('first.'+key3);  //json形式的第一个config_specs的value(也是json)
					var config2 = eval('second.'+key3);
					var config3 = eval('third.'+key3);
					var config4 = eval('fourth.'+key3); 
					//config_specs第一个值
					var specs1 = JSON.stringify(config1);  //{"":"","",""}
					specs1 = specs1.substring(2, specs1.length-1).replace(/\"/g,"");
					//config_specs第二个值
					var specs2 = JSON.stringify(config2);
					specs2 = specs2.substring(2, specs2.length-1).replace(/\"/g,"");
					//config_specs第三个值
					var specs3 = JSON.stringify(config3);
					specs3 = specs3.substring(2, specs3.length-1).replace(/\"/g,"");
					//config_specs第四个值
					var specs4 = JSON.stringify(config4);
					specs4 = specs4.substring(2, specs4.length-1).replace(/\"/g,"");
					//替换product1.html部分内容
					document.getElementById("proName").innerHTML="&nbsp;&nbsp;"+name;
					document.getElementById("proConPrice").innerHTML=total_price;
					document.getElementById("config1").innerHTML=specs1;
					document.getElementById("config2").innerHTML=specs2;
					document.getElementById("config3").innerHTML=specs3;
					document.getElementById("config4").innerHTML=specs4;
					//替换picture的路径
					var pictu = document.getElementById("picture3").src;
					$("#proPicture").attr("src",pictu);
				}
			}
		})
    });
})

//点击第四个商品的read more跳转产品详情页面
$(document).ready(function(){
    $('#bbtt4').click(function(){
		//获取SKU信息
        $.ajax({
            url:'/src/Servlet/LoginServlet.java',  //路径要求：接受商品名，返回符合条件的SKU的信息
            data:{	
				name:document.getElementById("name4").innerHTML
			},
			dataType:"json",
            type:"Post",
            success:function(list){  //返回六个值，我只需要name+total_price+config_specs，返回样式[{},{},{},{}]
				if (JSON.stringify(list) == "[]"){	alert("Error");	}
				else{
					var first = list[0]; //Object
					var second = list[1];
					var third = list[2];
					var fourth = llist[3];
					var key1 = "name";  //取出一个即可
					var key2 = "total_price";  //取出第一个即可
					var key3 = "config_specs";
					//SKU的数据
					var name = eval('first.'+key1);  //String
					var total_price = eval('first.'+key2);  //String  
					var config1 = eval('first.'+key3);  //json形式的第一个config_specs的value(也是json)
					var config2 = eval('second.'+key3);
					var config3 = eval('third.'+key3);
					var config4 = eval('fourth.'+key3); 
					//config_specs第一个值
					var specs1 = JSON.stringify(config1);  //{"":"","",""}
					specs1 = specs1.substring(2, specs1.length-1).replace(/\"/g,"");
					//config_specs第二个值
					var specs2 = JSON.stringify(config2);
					specs2 = specs2.substring(2, specs2.length-1).replace(/\"/g,"");
					//config_specs第三个值
					var specs3 = JSON.stringify(config3);
					specs3 = specs3.substring(2, specs3.length-1).replace(/\"/g,"");
					//config_specs第四个值
					var specs4 = JSON.stringify(config4);
					specs4 = specs4.substring(2, specs4.length-1).replace(/\"/g,"");
					//替换product1.html部分内容
					document.getElementById("proName").innerHTML="&nbsp;&nbsp;"+name;
					document.getElementById("proConPrice").innerHTML=total_price;
					document.getElementById("config1").innerHTML=specs1;
					document.getElementById("config2").innerHTML=specs2;
					document.getElementById("config3").innerHTML=specs3;
					document.getElementById("config4").innerHTML=specs4;
					//替换picture的路径
					var pictu = document.getElementById("picture4").src;
					$("#proPicture").attr("src",pictu);
				}
			}
		})
    });
})

//选择config_specs
$(document).ready(function(){
    $('#sel1').change(function(){  //每次改变选择则更新specs
		var specss = $("#sel1 option:selected").text();
		$.ajax({
			url:'/src/Servlet/LoginServlet.java',  //路径要求：接收product name和config后，能去数据库SKU表返回total_price
            data:{	
				name:document.getElementById("proName").innerHTML,
				config_specs:"{"+specss+"}"
			},
			dataType:"json",  //返回类型text
			type:"Post",
			success:function(list){ 
				var sku = list[0]; //Object
				var key = "total_price";
				var skuPrice = eval('sku.'+key);  //String 
				document.getElementById("proConPrice").innerHTML=skuPrice;  //change configuration price(String)
				var n = document.getElementById("proAccPrice").innerHTML;  //get accessory price (String)
				document.getElementById("totalPrice").innerHTML = parseFloat(skuPrice)+parseFloat(n);
			}
		})
    });
})

//选择accessory
$(document).ready(function(){
    $('#sel2').change(function(){  //每次改变选择则更新specs
		var acc = $("#sel2 option:selected").text();
		if (acc == "none"){document.getElementById("proAccPrice").innerHTML="0";}
		else{
			$.ajax({
				url:'/src/Servlet/LoginServlet.java',  //路径要求：接收product name和config后，能去数据库SKU表返回total_price
				data:{	
					name:document.getElementById("proName").innerHTML,  //传给后端accessory名字
				},
				dataType:"json",  //返回类型text
				type:"Post",
				success:function(list){  //[{}]
					var acc = list[0];
					var key = "price";
					var accPrice = eval('acc.'+key);
					document.getElementById("proAccPrice").innerHTML=accPrice;  //change accessory price(String)
					var n = document.getElementById("proConPrice").innerHTML;  //get configuration price (String)
					document.getElementById("totalPrice").innerHTML = parseFloat(accPrice)+parseFloat(n);
        		}
			})
		}
    });
})



/************************************
*************未完成部分****************
*************************************/


//商品加入购物车
$(document).ready(function(){
    $('#addToCart').click(function(){
	var checkLog = sessionStorage.getItem("userName");   
	if (checkLog == ""){	alert("Please login first");	}//check whether login
	else{	
		$ajax({})
		}
    });
})

//购物车商品删除
$(document).ready(function(){
    $('#').click(function(){
		$ajax({})
    });
})

//订单生成
$(document).ready(function(){
    $('#generateOrder').click(function(){
		$ajax({})
			
    });
})

//订单查询
$(document).ready(function(){
    $('#addToCart').click(function(){
	
		$ajax({})
		
	});
})

//订单删除
$(document).ready(function(){
    $('#').click(function(){
	
		$ajax({})
		
	});
})

//订单排序
$(document).ready(function(){
    $('#').click(function(){
	
		$ajax({})
		
	});
})