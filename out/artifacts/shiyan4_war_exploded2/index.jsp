<%@ page import="com.mysql.cj.Session" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.shiyan4.entity.book_info" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>chenxiaojian</title>
    <link rel="stylesheet" type="text/css" href="user/static/css/index.css">
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
<div id="content">
    <div class="allbook-box">
        <%--            <div class="book-box">--%>
        <%
            request.setCharacterEncoding("utf-8");
            response.setContentType("text/html charset=utf-8");

            ArrayList<book_info> book_info = (ArrayList<book_info>) request.getAttribute("book_list");
            Integer cpage = (Integer) request.getAttribute("cpage");
            // 判断是否为空，如果为空，说明是第一次，那就转到servlet取数据
            // 其实应该执行的顺序，访问servlet->jsp，不然这样先访问jsp，但是此时没数据，所以得写逻辑在jsp中，不太好
            // 问题：servlet中设置session.setAttribute,然后重定向转发到index.jsp，但是在index.jsp中获取不到session.getAttribute()
            // 请求转发可以，但是网站的入口url：访问index.jsp，会自动请求转发到servlet:ShowBookListServlet
            // 第一次访问,index.jsp，此时session域中没有值，所以转向servlet:ShowBookListServlet;新一个页面访问index.jsp即可
            if (book_info == null){ //一开始访问index.jsp，为空，所以需要去请求servlet
//                System.out.println("empty!!");
                request.getRequestDispatcher("ShowBookListServlet").forward(request,response);
            }
            else{
                for (int i=0; i<book_info.size(); i++){
                    book_info book = book_info.get(i);
                    String res_0 = "<div class='book-box'>";
                    String res_1= "<a href='ShowBookInfoServlet?ISBN=" + book.getISBN() + "' target='_blank' title='" +book.getName()+"'>" ;
                    String res_2 = "<img src='" + request.getContextPath() + book.getBook_cover_path() + "'>";
                    String res_3 = "<div>" + book.getName() + "</div>";
                    String res_4 = "<div><strong>￥" + book.getPrice() + "</strong></div></a></div>";
                    String res = res_0+res_1+res_2+res_3+res_4;
                    out.print(res);
                }
            }
        %>
        <%--注意ISBN,别写错参数=.=--%>
        <%--                <a href="ShowBookInfoServlet?ISBN=9787115428028" target="_blank">--%>
        <%--                    <img src="<%=request.getContextPath()%>/manager/book_img/python/python0.jpg">--%>
        <%--                    <div>Python自动化测试实战</div>--%>
        <%--                    <div><strong>￥30.00</strong></div>--%>
        <%--                </a>--%>
        <%--            </div>--%>
    </div>
    <div class="fenye-box">
        <a href="index.jsp?currentPage=1&&division=<%=request.getAttribute("division")%>">首页</a>
        <a href="index.jsp?currentPage=<%=request.getAttribute("lastpage")%>&&division=<%=request.getAttribute("division")%>">上一页</a>
        <a href="index.jsp?currentPage=<%=request.getAttribute("nextpage")%>&&division=<%=request.getAttribute("division")%>">下一页</a>
        <a href="index.jsp?currentPage=<%=request.getAttribute("page_sum")%>&&division=<%=request.getAttribute("division")%>">尾页</a>
        &nbsp&nbsp&nbsp&nbsp总共：<%=request.getAttribute("book_sum")%>本</span>
        &nbsp&nbsp&nbsp&nbsp当前：<%=request.getAttribute("cpage")%>/<%=request.getAttribute("page_sum")%>页</span>
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
</script>
</body>
</html>
