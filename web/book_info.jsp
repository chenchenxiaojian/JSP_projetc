<%@ page import="org.shiyan4.entity.book_info" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: 陈小坚
  Date: 2020/7/12
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>i am show book_info page(book_info.jsp)</title>
    <link rel="stylesheet" type="text/css" href="user/static/css/book_info.css">
</head>
<body>
<div class="header">
    <a href="index.jsp" title="chenxiaojian的个人商城站点"><img src="user/static/img/new-logo.png"></a>
    <ul>
        <li><a href="index.jsp">home</a></li>
        <li><a href="index.jsp">categories</a>
            <ul>
                <li><a href="index.jsp?division=c/c++">C/C++</a></li>
                <li><a href="index.jsp?division=python">Python</a></li>
                <li><a href="index.jsp?division=java">Java</a></li>
                <li><a href="index.jsp?division=others">Othors</a></li>
            </ul>
        </li>
        <li><a href="#">about</a></li>
        <li><a href="#">contact</a></li>
    </ul>
    <div class="login-register">
        <img src="user/static/img/喇叭.svg">
        <span id="login-register-span">Please login! 😭😭😭</span>
        <span id="welcome-span">Welcome😘,id: <%=session.getAttribute("id")%>🎈🎈🎈</span>
        <%--登录注册链接--%>
        <a class="login-register-link" href="login.jsp" target="_blank">Login | Register</a>
        <%--用户中心--%>
        <a class="user-config" href="querycartServlet" title="User Config"><img src="user/static/img/user.svg"></a>
    </div>
</div>
<div class="content">
    <%
        ArrayList<book_info> book_info = (ArrayList<book_info>) request.getAttribute("book_list"); // 获取书籍的详细信息
    %>
    <div class="shopping-car">
        <button onclick="addShoppingCar()">🎈加入购物车</button>
        数量:
        <select id="add_nums">
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            <option>6</option>
            <option>7</option>
            <option>8</option>
            <option>9</option>
            <option>10</option>

        </select>
    </div>
    <img src="<%=request.getContextPath()%><%=book_info.get(0).getBook_cover_path()%>" title="<%=book_info.get(0).getName()%>">
    <div class="book-info">
        <span title="<%=book_info.get(0).getName()%>">🎈书名: <%=book_info.get(0).getName()%></span>
        <span>🎈价格: <%=book_info.get(0).getPrice()%></span>
        <span>🎈ISBN: <%=book_info.get(0).getISBN()%></span>
        <span>🎈作者: <%=book_info.get(0).getAuthor()%></span>
        <span>🎈出版社: <%=book_info.get(0).getPublish_house()%></span>
        <span>🎈出版日期: <%=book_info.get(0).getPublish_date()%></span>
        <span>🎈分类: <%=book_info.get(0).getDivision()%></span>
        <span>🎈页数: <%=book_info.get(0).getPage_number()%></span>
        <span>🎈库存: <%=book_info.get(0).getStock()%></span>
        <span>🎈销售量: <%=book_info.get(0).getSales_volume()%></span>
    </div>
    <div class="book-brief">
        <div class="book-brief-title">
            🎈简介🎈
        </div>
        <div class="book-brief-content" ><%=book_info.get(0).getBrief()%></div>
    </div>
    <div class="book-comment">
        书籍的评论区域，没时间写了，先挖个坑在这里😭😭😭😭😭😭😭😭
    </div>
</div>
<div id="footer">
    <p>Copyright © 2020 chenxiaojian<br>(广州大学计算机科学与网络工程学院网络172陈伟坚)保留所有权利</p>
</div>
<section id="backgroud-img"></section>  <%--设置背景图片--%>
<script>
    window.addEventListener("scroll",function () {
        var header = document.getElementsByClassName("header")[0];
        //设置当滚动条的滚动的距离大于0，就add class stick，否则就remove class stick
        header.classList.toggle("stick", window.scrollY > 0);
    })
    var user_id = <%=session.getAttribute("id")%>;
    console.log(user_id);
    var welcome_span = document.getElementById("welcome-span");
    var login_register_span = document.getElementById("login-register-span");
    var login_register_a = document.getElementsByClassName("login-register-link")[0];
    var user_config_a = document.getElementsByClassName("user-config")[0];
    if (user_id == null){       /*说明还未登录*/
        welcome_span.style.display = "none";
        login_register_span.style.display = "inline";
        login_register_a.style.display = "inline";
        user_config_a.style.display = "none";
    }
    else{
        welcome_span.style.display = "inline";
        login_register_span.style.display = "none";
        login_register_a.style.display = "none";
        user_config_a.style.display = "inline";
    }
    function addShoppingCar() {
        if (user_id == null){
            alert("Please Login or Register");
        }
        else {
            var add_nums = document.getElementById("add_nums").value;
            var param = "&&addNums=" + add_nums.toString();
            xmlHttpRequest  = new XMLHttpRequest();  // 全局变量
            xmlHttpRequest.open("post", "addShoppingCarServlet", true);
            xmlHttpRequest.onreadystatechange = callback;
            xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xmlHttpRequest.send("ISBN="+ <%=request.getParameter("ISBN")%> +"&&addNums="+add_nums);
            // xmlHttpRequest.send("addNums="+add_nums)
            <%--window.location.href = "/shiyan4/addShoppingCarServlet?ISBN=<%=request.getParameter("ISBN")%>" + param; // js 转到servlet中--%>
        }
    }
    function  callback() { // 回调函数
        if(xmlHttpRequest.readyState == 4 && xmlHttpRequest.status == 200){
            var data = xmlHttpRequest.responseText;
            if (data == "true"){
                alert("添加成功")
            }else{
                alert("添加失败")
            }
        }


    }
</script>
</body>
</html>
