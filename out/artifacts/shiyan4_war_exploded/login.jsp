<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>登录|注册</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <link rel="stylesheet" href="user/static/css/login.css">
    </head>
    <body>
        <div class="box">
            <div class="form-box">
                <div class="button-box">
                    <div id="btn"></div>
                    <button onclick="login()">Login</button>
                    <button onclick="register()">Register</button>
                </div>

                <form class="login-form" action="login.jsp" method="post" autocomplete="off">
                <%--设置不能自动填充，chrome自动填充会有样式问题                   --%>
                    <div class="input" placeholder="ID" ><input type="text" name="ID" maxlength="20" required/></div>
                    <div class="input" placeholder="Password"><input type="password" name="Password" maxlength="20" required/></div>
                    <div class="input-btn"><input type="submit" value="Login" name="pattern" /></div>
<%--                    <input type="hidden" value="<%=login_status%>"/>--%>
                </form>
                <form class="register-form" autocomplete="off" method="post" action="login.jsp">
                    <div class="input" placeholder="ID"><input type="text" name="ID" required maxlength="10"/></div>
                    <div class="input" placeholder="Username"><input type="text" name="Username" maxlength="20" required/></div>
                    <div class="input" placeholder="Password"><input id="pw1" name="Password" type="password" maxlength="20" required/></div>
                    <div class="input" placeholder="Repeat-Password"><input id="pw2" type="password" maxlength="20" required onkeyup="validate()"/><span id="tishi"></span></div>
                    <div class="input" placeholder="Phone"><input type="text" name="phone" maxlength="20" required/></div>
                    <div class="input" placeholder="Address"><input type="text" name="address" maxlength="50" required></div>
                    <div class="input" placeholder="Age"><input type="text" name="age" required/></div>
                    <div class="input" placeholder="City"><input type="text" name="city" maxlength="20" required/></div>
                    <div class="input-btn" ><input type="submit" value="Register" name="pattern"></div>
<%--                    <input type="hidden" value="<%=register_status%>"/>--%>
                </form>
            </div>
        </div>

        <script>
            var btn = document.getElementById('btn'); //切换按钮设置id=btn的定位
            var form_box = document.getElementsByClassName("form-box")[0];
            var login_form = document.getElementsByClassName('login-form')[0];
            var register_form = document.getElementsByClassName('register-form')[0];
            function login() {
                btn.style.left = "0";
                form_box.style.height = "380px";
                login_form.style.display = "block";
                register_form.style.display = "none";

            }
            function register() {
                btn.style.left = "120px"; //显示按钮选中的<div id='btn'>的样式
                form_box.style.height = "720px";
                register_form.style.display = "block";
                login_form.style.display = "none";
            }
            let input_list = document.getElementsByTagName("input")
            // console.log(input_list)
            for (i=0; i<input_list.length; i++){
                //获取焦点
                input_list[i].addEventListener("focus",function () {
                    let pa = this.parentNode;
                    pa.classList.add('focus');
                },true);
                //失去焦点， 注意要使用this，作用域还不清楚
                input_list[i].addEventListener("blur", function () {
                    if (this.value == "") {
                        let pa = this.parentNode;
                        pa.classList.remove('focus')
                    }
                },true)
            }
            function validate() { // 判断两次输入密码是否相同
                var pw1 = document.getElementById("pw1").value;
                var pw2 = document.getElementById("pw2").value;
                if(pw1 !=pw2){ //如果两次密码不停
                    document.getElementById("tishi").innerHTML="<font color='red'>密码不相同</font>";
                    document.getElementsByName("pattern")[1].disabled = true; //register按钮不能使用
                }
                else{
                    document.getElementById("tishi").innerHTML="";
                    document.getElementsByName("pattern")[1].disabled = false;
                }
            }
        </script>
        <%
            int register_status = 0; // 标志是否注册成功
            int login_status = 0; // 标志是否登录成功
            String session_id = (String)session.getAttribute("id"); // 标志之前是否登录过，没登录过为null
//            boolean login_status = false;    // 标志是否登录成功，好像没啥作用，注释
            request.setCharacterEncoding("utf-8"); // 设置请求编码，注意这种方式对get请求不起作用
            try{
                Class.forName("com.mysql.cj.jdbc.Driver"); //驱动程序名
                String url = "jdbc:mysql://localhost:3306/company?useSSL=false&serverTimezone=UTC"; // 数据库名
                String mysql_username = "root"; //数据库用户名
                String mysql_password = "1234"; // 数据库用户密码
                Connection conn = DriverManager.getConnection(url, mysql_username, mysql_password); // 连接状态
                if (conn != null){
//                    out.println("数据库连接成功");
                    String pattern = request.getParameter("pattern"); // 判断是登录还是注册
                    if (pattern.equals("Login")){   // 登录
                        String id = request.getParameter("ID"); //获取传来的id值
                        String password = request.getParameter("Password"); //获取传来的密码
                        String sql = "select id,psw from myuser where id=? and psw=?";
                        try{
                            PreparedStatement ps = conn.prepareStatement(sql);
                            ps.setString(1,id);
                            ps.setString(2,password);
                            ResultSet res = ps.executeQuery();
                            if (res.next()){
                                //设置session
                                session.setAttribute("id", id);
//                                request.getRequestDispatcher("main.jsp").forward(request,response);
                                // 可能session的设置生效时间需要重新刷新才能生效，需要在这里跳转，请求转发 重定向都行，
                                response.sendRedirect("index.jsp"); //新的请求，上一次请求的信息不保留，主要是href变换，读取数据用session即可
                            }else{
                                login_status = -1; // 登录失败
                                out.print("id账号密码错误or不存在");
                            }
                            res.close();
                            ps.close();
                        }catch (Exception e){
                            out.print("sql语句错误");
                        }
                    }else if (pattern.equals("Register")){ // 注册
                        String id = request.getParameter("ID");
                        String name = request.getParameter("Username");
                        String password = request.getParameter("Password");
                        String phone = request.getParameter("phone");
                        String address = request.getParameter("address");
                        int age = Integer.parseInt(request.getParameter("age"));

                        String city = request.getParameter("city");
                        //判断用户名是否合法
                        String sql = "select * from myuser where id=?";
                        try {
                            PreparedStatement ps = conn.prepareStatement(sql);
                            ps.setString(1, id);
                            ResultSet res = ps.executeQuery();
                            if (res.next()){
                                register_status = -1; // 注册失败
                            }else{
                                try {
                                    String insert_sql = "insert into myuser(id,name, psw, age,phone,address,city) values (?,?,?,?,?,?,?)";
                                    PreparedStatement ps1 = conn.prepareStatement(insert_sql);
                                    ps1.setString(1, id);
                                    ps1.setString(2, name);
                                    ps1.setString(3, password);
                                    ps1.setInt(4, age);
                                    ps1.setString(5,phone);
                                    ps1.setString(6,address);
                                    ps1.setString(7,city);
                                    ps1.execute();
                                    register_status = 1; // 表示注册成功
                                }catch (Exception e){
                                    out.print(e);
                                }
                            }
                            res.close();
                            ps.close();
                        }catch (Exception e){
                            out.print("sql语句错误");
                        }
                    }
                }
                conn.close();
            }catch (Exception e){
                out.println(e);
            }
        %>
        <script>
            // 设置用户注册提示信息，优化代码的地方，使用ajax请求 判断用户名是否合法
            var register_status = <%=register_status%>;
            var login_status = <%=login_status%>;
            var session_status = <%=session_id%>;
            console.log(session_status)
            if (login_status == -1){
                alert("ID或者密码错误，请重新登录！")
            }
            if (register_status == -1){   //用户名重复
                alert("该用户ID已被注册，请重新注册!");
            }
            else if(register_status == 1){ //用户注册成功
                alert("注册成功，可进行登录！");
            }
            if (session_status){ // 之前登录过，访问index.jsp，直接跳转到main.jsp
                window.location.href = 'index.jsp';// 之前是否登录过
                // window.location.href
            }
            else{
                alert("请进行登录或者注册"); // 提示进行登录或者注册

            }

        </script>


    </body>

</html>