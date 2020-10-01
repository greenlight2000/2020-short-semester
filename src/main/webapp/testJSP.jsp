<%--
  Created by IntelliJ IDEA.
  User: wangyunkun
  Date: 2020/9/4
  Time: 4:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>test jsp</title>
</head>
<body>
    <section id="jspVue">
        <input type="text" v-model="data1"/>
        <%
            out.println("here");

        %>
    </section>
    hello
    <%
        out.print("123");
        int a = 1;
        int[] arr = (int[])request.getAttribute("arr");
    %>
    
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script>
        var app=new Vue({
            el: "#jspVue",
            data: {
                list: ["写代码", "吃饭饭", "睡觉觉"],
                inputValue: "好好学习,天天向上",
                data1:"a piece of data"
            },
            methods: {
                add: function () {
                    this.list.push(this.inputValue);
                },
                remove: function (index) {
                    console.log("删除");
                    console.log(index);
                    this.list.splice(index, 1);
                },
                clear: function () {
                    this.list = [];
                }
            }
        })
    </script>
</body>
</html>
