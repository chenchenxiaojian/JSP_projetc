<%@ page import="java.util.ArrayList" %>
<%@ page import="org.shiyan4.entity.cart" %>
<%@ page import="org.shiyan4.entity.book_info" %>
<%@ page import="org.shiyan4.entity.order_table" %><%--
  Created by IntelliJ IDEA.
  User: 陈小坚
  Date: 2020/7/14
  Time: 7:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Config | 用户中心</title>
    <link rel="stylesheet" type="text/css" href="user/static/css/user_config.css">
</head>
<body>
<%
    String user_id = (String)session.getAttribute("id");
    if (user_id == null){
        response.sendRedirect("index.jsp");
    }
%>
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

<div id="content">
<%--标题--%>
    <div class="content-title">
        用户个人管理中心:欢迎你，<font color="green"><%=session.getAttribute("id")%></font>
        <button onclick="logout()">注销</button>
    </div>
<%--导航--%>
    <div class="content-nav">
        <span>信息管理</span>
        <span>购物车管理</span>
        <span>订单管理</span>
        <span>收货地址管理</span>
        <span>其他</span>
    </div>
    <%--用户信息模块--%>
    <div id="userconfig-box">
        <span>用户信息管理页面</span>
        <div class="user-messagebox">
            <div><span>🎈账&emsp;号 :</span><input name="user_id" maxlength="10" value="<%=session.getAttribute("id")%>"><font color="red" size="0.5rem">账号不能修改</font></div>
            <div><span>🎈用户名 :</span><input name="username" maxlength="20" required></div>
            <div><span>🎈密&emsp;码 :</span><input name="password" maxlength="20" required></div>
            <div><span>🎈年&emsp;龄 :</span><input name="age" required></div>
            <div><span>🎈电&emsp;话 :</span><input name="phone" maxlength="20" required></div>
            <div><span>🎈城&emsp;市 :</span><input name="city" maxlength="20" required></div>
            <div><span>🎈地&emsp;址 :</span><input name="address" maxlength="50" required value="222"></div>
            <button onclick="modify_userconfig()">修改</button>
        </div>
    </div>
<%--购物车管理--%>
    <div id="shoppingcar-box">
        <span>购物车管理页面</span>
        <div class="shopping-car-title">
            <span>图片</span>
            <span>书名</span>
            <span>购买数量</span>
            <span>单价</span>
            <span>小计</span>
        </div>
        <%
            ArrayList<cart>cart_list = (ArrayList<cart>) request.getAttribute("cart_list");
            ArrayList<book_info>book_info = (ArrayList<book_info>) request.getAttribute("book_info");
            if (cart_list !=null) {
                // 注意！！！，输出的格式一定要严格遵从，少一个空格都会出错，因为我们后面的js的选取DOM元素的子节点会考虑这些空格
                for (int i = 0; i < cart_list.size(); i++) {
                    out.print("<div class=\"shopping-car-items\"> ");
                    out.print("<input type=\"checkbox\" value=\"" + cart_list.get(i).getBook_ISBN() + "\"> ");
                    out.print("<span><img title=\"");
                    out.print(book_info.get(i).getName());
                    out.print("\" src=\"/shiyan4");
                    out.print(book_info.get(i).getBook_cover_path());
                    out.print("\"></span> ");
                    out.print("<span title=\"");
                    out.print(book_info.get(i).getName());
                    out.print("\">");
                    out.print(book_info.get(i).getName());
                    out.print("</span> ");
                    out.print("<strong class=\"sub\">-</strong><span>");
                    out.print(cart_list.get(i).getBook_accout());
                    out.print("</span><strong class=\"add\" >+</strong> ");
                    out.print("<span>￥" + book_info.get(i).getPrice() + "</span> ");
                    out.print("<span class=\"item-sum\"></span> <button>删除</button> </div> ");
                }
            }
        %>
        <%--结账 --%>
        <div class="settle-account">
            <div >
                <strong>收货人 : &emsp;</strong><input class="accept-people"/><br>
                <strong>收货电话 : </strong><input class="accept-phone"/><br>
                <strong >收货地址 : </strong><input class="accept-address" /><br>
            </div>
            <div class="buy">
                总计：<strong>￥</strong>
                <strong id="last-price">0.00</strong>
                <button onclick="buy()">结算</button>
            </div>
        </div>
<%--        <div class="shopping-car-items">--%>
<%--            <input type="checkbox" value="123456">--%>
<%--            <span><img title="python111111111111111111" src="manager/book_img/python/python0.jpg"></span>--%>
<%--            <span title="python111111111111111111">python111111111111111111</span>&lt;%&ndash;书名&ndash;%&gt;--%>
<%--            <strong class="sub">-</strong><span>10</span><strong class="add" >+</strong>--%>
<%--            <span>￥12.13</span>--%>
<%--            <span class="item-sum"></span><button>删除</button>--%>
<%--        </div>--%>
<%--        <div class="shopping-car-items">--%>
<%--            <input type="checkbox">--%>
<%--            <span><img title="python111111111111111111" src="manager/book_img/python/python0.jpg"></span>--%>
<%--            <span title="python111111111111111111">python111111111111111111</span>&lt;%&ndash;书名&ndash;%&gt;--%>
<%--            <strong class="sub">-</strong><span>1</span><strong class="add" >+</strong>--%>
<%--            <span>￥22.13</span>--%>
<%--            <span class="item-sum"></span>--%>
<%--            <button>删除</button>--%>
<%--        </div>--%>
    </div>
<%--订单管理--%>
    <div id="orderconfig-box">
        <span class="orderconfig-box-title">订单信息查看页面</span><br/>
        <%
            String tag = (String) session.getAttribute("update_ordertable");
            if (tag =="true" || tag == null){
                request.getRequestDispatcher("showOrderTableServlet").forward(request,response);
            }
            ArrayList<order_table>order_tables = (ArrayList<order_table>) session.getAttribute("order_tables");
            if(order_tables != null) {
                for (int i = 0; i < order_tables.size(); i++) {
                    out.print("        <div class=\"orderitem-box\">\n" +
                            "            <div>\n" +
                            "                订单号: <span class=\"order-id\">");
                    out.print(order_tables.get(i).getOrder_id());
                    out.print("</span>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
                            "                下单时间: <span>");
                    out.print(order_tables.get(i).getOrder_time());
                    out.print("</span>\n" +
                            "                <button>查看</button>\n" +
                            "            </div>\n" +
                            "            <div class=\"order-message\">\n" +
                            "                <span>收件人&emsp;：");
                    out.print(order_tables.get(i).getAccept_username());
                    out.print("</span>\n" +
                            "                <span>联系电话：");
                    out.print(order_tables.get(i).getAccept_phone());
                    out.print("</span><br>\n" +
                            "                <span>收货地址：");
                    out.print(order_tables.get(i).getAccept_address());
                    out.print("</span><br>\n" +
                            "                <span>购买图书：</span>\n" +
                            "                <span>购买数量：</span>\n" +
                            "                <span>图书单价：</span><br>\n" +
                            "                    <span class=\"append-bookinfo\"></span>\n" +
                            "\n" +
                            "            </div>\n" +
                            "        </div>");
                }
            }
        %>
<%--        <div class="orderitem-box">--%>
<%--            <div>--%>
<%--                订单号: <span >11111</span>&nbsp;&nbsp;&nbsp;&nbsp;--%>
<%--                下单时间: <span>111111111111</span>--%>
<%--                <button>查看</button>--%>
<%--            </div>--%>
<%--            <div class="order-message">--%>
<%--                <span>收件人&emsp;：</span>--%>
<%--                <span>联系电话：</span><br>--%>
<%--                <span>收货地址：</span><br>--%>
<%--                <span>购买图书：</span>--%>
<%--                <span>购买数量：</span>--%>
<%--                <span>图书单价：</span>--%>
<%--                <span class="appent-bookinfo"></span>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>

    <div id="acceptaddress-box">这里是收货地址表的管理，但是没时间了写了，.......😭😭😭😭😭😭</div>
<%--其他模块--%>
    <div id="otherconfig-box">这里是其他东西的管理，但是没时间了写了，.......😭😭😭😭😭😭</div>
</div>

<div id="footer">
    <p>Copyright © 2020 chenxiaojian<br>(广州大学计算机科学与网络工程学院网络172陈伟坚)保留所有权利</p>
</div>
<section id="background-img"></section>  <%--设置背景图片--%>

<script>
    window.addEventListener("scroll",function () {
        var header = document.getElementsByClassName("header")[0];
        //设置当滚动条的滚动的距离大于0，就add class stick，否则就remove class stick
        header.classList.toggle("stick", window.scrollY > 0);
    })
    var user_id = <%=session.getAttribute("id")%>;
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
    //注销，ajax请求注销，注销后跳转到index.jsp
    function logout() {
        xmlHttpRequest = new XMLHttpRequest();
        xmlHttpRequest.open("post", "logoutServlet", true);
        xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
        xmlHttpRequest.send(null);
        xmlHttpRequest.onreadystatechange = logout_callback;
    }
    function logout_callback() {
        if(xmlHttpRequest.readyState==4 && xmlHttpRequest.status==200){
            var data = xmlHttpRequest.responseText;
            if (data == "true"){
                alert("注销成功（logout succeed!）");
                window.location.href = "/shiyan4/index.jsp";
            }
        }
    }

    var user_id = document.querySelectorAll(".user-messagebox>div>input")[0];
    var username = document.querySelectorAll(".user-messagebox>div>input")[1];
    var password = document.querySelectorAll(".user-messagebox>div>input")[2];
    var age = document.querySelectorAll(".user-messagebox>div>input")[3];
    var phone = document.querySelectorAll(".user-messagebox>div>input")[4];
    var city = document.querySelectorAll(".user-messagebox>div>input")[5];
    var address = document.querySelectorAll(".user-messagebox>div>input")[6];
    function getUserMessage() {// ajax请求获取用户的信息
        user_id.value = <%=session.getAttribute("id")%>;
        user_id.readOnly = 'true';  // 设置只读
        xmlHttpRequest = new XMLHttpRequest();
        // 注意 必须先连接，然后在设置头部信息
        xmlHttpRequest.open("post", "ShowUserInfoServlet", true);
        xmlHttpRequest.setRequestHeader("Content-Type", "application/json; charset=uft-8");
        xmlHttpRequest.send(null);
        xmlHttpRequest.onreadystatechange = getUserMessage_callback;
    }
    function getUserMessage_callback() {
        if(xmlHttpRequest.readyState==4 && xmlHttpRequest.status==200){
            var data = JSON.parse(xmlHttpRequest.responseText); // 解析json,将字符串解析成object
            username.value = data["username"];
            password.value = data["password"];
            age.value = data["age"];
            phone.value = data["phone"];
            city.value = data["city"];
            address.value = data["address"];
        }
    }
    function modify_userconfig() {
        xmlHttpRequest = new XMLHttpRequest();
        xmlHttpRequest.open("post", "ShowUserInfoServlet", true);
        xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
        var data = "action=modify"+"&&username="
            +username.value + "&&password="+password.value
            + "&&age="+age.value + "&&phone="+phone.value
            + "&&city="+city.value + "&&address=" + address.value;
        xmlHttpRequest.send(data);
        xmlHttpRequest.onreadystatechange = modify_userconfig_callback;
    }
    function modify_userconfig_callback() {
        if(xmlHttpRequest.readyState==4 && xmlHttpRequest.status==200){
            if (xmlHttpRequest.responseText == "true"){
                alert("修改成功！");
                getUserMessage();
            }else {
                alert("修改失败");
            }
        }
    }
    getUserMessage();

    // 控制 导航栏的样式
    var userconfig_box = document.getElementById("userconfig-box");
    var shoppingcar_box = document.getElementById("shoppingcar-box");
    var orderconfig_box = document.getElementById("orderconfig-box");
    var acceptaddress_box = document.getElementById("acceptaddress-box");
    var otherconfig_box = document.getElementById("otherconfig-box");
    var span_list = document.querySelectorAll(".content-nav>span");
    span_list[1].style.color = "red";

    var temp = [userconfig_box,shoppingcar_box,orderconfig_box,acceptaddress_box,otherconfig_box];
    function setdiv_displaynone(){
        for(let i=0; i<temp.length; i++){
            temp[i].style.display = "none";
        }
        for (let i=0; i<span_list.length; i++){
            span_list[i].style.color = 'white';
        }
    }
    // 注意这里的i必须用let声明，作为局部变量
    for(let i=0; i<span_list.length; i++){
        span_list[i].addEventListener("click",function () {
            setdiv_displaynone();
            temp[i].style.display = "block";
            span_list[i].style.color = "red";
        });
    }


    // 计算每种图书的假期，调整购买数量
    var item_list = document.getElementsByClassName("item-sum");
    for (let j=0; j<item_list.length; j++){
        let father = item_list[j].parentNode;
        let book_account = father.childNodes[8];    // 购买数量
        let book_price = father.childNodes[11];     // 单价
        let item_sum = father.childNodes[13];       // 小计
        let sub = father.childNodes[7];   // 减少节点
        let add = father.childNodes[9];   // 增加节点
        let del = father.childNodes[15];  // 删除节点
        let select = father.childNodes[1];  // 选择框
        item_sum.innerText = (parseInt(book_account.innerText) * parseFloat(book_price.innerText.substr(1))).toFixed(2);
        // 如果选择框被选中，那么 - + 不可被使用
        sub.addEventListener("click",function () {
            select.checked = false;
            if ((parseInt(book_account.innerText)-1) >=1){
                book_account.innerText = parseInt(book_account.innerText)-1;
                item_sum.innerText = (parseInt(book_account.innerText) * parseFloat(book_price.innerText.substr(1))).toFixed(2);
            }else{
                alert("可以点击删除，从购物车清除");
            }
        });
        add.addEventListener("click",function () {
            select.checked = false;
            book_account.innerText = parseInt(book_account.innerText) + 1;
            item_sum.innerText = (parseInt(book_account.innerText) * parseFloat(book_price.innerText.substr(1))).toFixed(2);
        });
        del.addEventListener("click",function () {
            // select.checked 返回true/fasle
            if (select.checked === false){   // 没有选中
                alert("Please select item then delelte!!")
            }else{  // 选中，那要去删除
                xmlHttpRequest = new XMLHttpRequest();
                xmlHttpRequest.open("post", "deletecartServlet", true);
                xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xmlHttpRequest.send("ISBN="+select.value);
                xmlHttpRequest.onreadystatechange = del_callback;
            }
        });
        select.addEventListener("click",function () {
            let lastPrice = document.getElementById("last-price");
            let data = parseFloat(lastPrice.innerText) * 1;  // * 1 number
            let temp = parseFloat(item_sum.innerText)
            if (select.checked == true){
                data += temp;
                add.style.display = "none";
                sub.style.display = "none";
            }else{
                data -= temp;
                add.style.display = "inline";
                sub.style.display = "inline";
            }
            lastPrice.innerText = data.toFixed(2);
        });
    }
    function del_callback() {
        if (xmlHttpRequest.status==200 && xmlHttpRequest.readyState==4){
            var data = xmlHttpRequest.responseText;
            if (data == "true"){
                alert("删除成功");
                window.location.href = "/shiyan4/querycartServlet";
            }
        }
    }
    // 刷新页面，选择框置为false;
    var checkbox_list = document.querySelectorAll("input[type=checkbox]");
    for (let i=0; i<checkbox_list.length; i++){
        checkbox_list[i].checked = false;
    }

    function buy() {
        let statue = false;
        let checkbox_list = document.querySelectorAll("input[type=checkbox]");
        for (let i = 0; i < checkbox_list.length; i++) {
            if (checkbox_list[i].checked == true) {
                statue = true;
                break;
            }
        }
        if (statue == false) {
            alert("请选择商品进行结算");
        } else {
            xmlHttpRequest = new XMLHttpRequest();
            xmlHttpRequest.open("post", "addOrderTableServlet", true);
            xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            let accept_people = document.getElementsByClassName("accept-people")[0].value;
            let accept_phone = document.getElementsByClassName("accept-phone")[0].value;
            let accept_address = document.getElementsByClassName("accept-address")[0].value;
            if (accept_people == "" || accept_address =="" || accept_phone==""){
                alert("请填写好收货信息");
            }else{
                xmlHttpRequest.send("accept_people="+accept_people+
                    "&&accept_phone="+accept_people+"&&accept_address="+accept_address);
                xmlHttpRequest.onreadystatechange = buy_callback;
                alert("购买成功！");
                window.location.href = "/shiyan4/querycartServlet";
            }
        }
    }
    function buy_callback() {
        if(xmlHttpRequest.status==200 && xmlHttpRequest.readyState == 4){
            let order_id = xmlHttpRequest.responseText;
            sendBookMessage(order_id);
        }
    }
    function sendBookMessage(order_id) {
        let checkbox_list = document.querySelectorAll("input[type=checkbox]");
        for (let i=0; i<checkbox_list.length; i++){
            if (checkbox_list[i].checked == true){
                let childrenNodeList = checkbox_list[i].parentNode.childNodes;
                let bookname = childrenNodeList[5].innerText
                let bookaccount = childrenNodeList[8].innerText;
                let bookprice = childrenNodeList[11].innerText.substr(1);
                let ISBN = childrenNodeList[1].value;
                xmlHttpRequest = new XMLHttpRequest();
                xmlHttpRequest.open("post", "addOrderInfoServlet", true);
                xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xmlHttpRequest.send("order_id="+order_id
                    +"&&book_name="+bookname
                    +"&&book_account="+bookaccount
                    +"&&book_price="+bookprice
                    +"&&ISBN="+ISBN
                )
                xmlHttpRequest.onreadystatechange = sendBookMessage_callback;
            }
        }
    }
    function sendBookMessage_callback() {
        if(xmlHttpRequest.status==200 && xmlHttpRequest.readyState == 4){
            console.log(xmlHttpRequest.responseText);
        }
    }
    let showOrderButtons = document.querySelectorAll(".orderitem-box button");
    var button_index = 10;
    for (let i=0; i<showOrderButtons.length; i++){
        showOrderButtons[i].addEventListener("click",function () {
            let order_message = document.getElementsByClassName("order-message")[i];
            if(order_message.style.display == "block"){
                order_message.style.display = "none";
            }else{
                order_message.style.display = "block";
            }
            let order_id = document.getElementsByClassName("order-id")[i].innerHTML;
            // alert("order_id"+order_id);
            xmlHttpRequest = new XMLHttpRequest();
            xmlHttpRequest.open("post", "showOrderInfoServlet", true);
            xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            // xmlHttpRequest.setRequestHeader("Content-Type", "application/json; charset=uft-8");
            xmlHttpRequest.send("order_id="+order_id);
            button_index = i
            xmlHttpRequest.onreadystatechange = showOrderButtons_callback;
        });

    }
    function showOrderButtons_callback() {
        console.log("回调中！！")
        if(xmlHttpRequest.status==200 && xmlHttpRequest.readyState == 4){
            // alert(button_index);
            let appendbookinfo = document.getElementsByClassName("append-bookinfo")[button_index];
            console.log(appendbookinfo);
            appendbookinfo.innerHTML = xmlHttpRequest.responseText;
        }
    }



</script>
</body>
</html>
