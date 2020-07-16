package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/14 12:36
 */

import org.shiyan4.dao.basedao;
import org.shiyan4.dao.myuserdao;
import org.shiyan4.entity.myuser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/ShowUserInfoServlet")
public class ShowUserInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/json;charset=utf-8");  // 设置为json类型
        response.setCharacterEncoding("utf-8");         // 设置响应数据类型，作用于post方式，这样才不会出现中文乱码
        String action = request.getParameter("action");
        if (action == null){
            get_userinfo(request,response);
        }else if (action.equals("modify")){
            HttpSession session = request.getSession();
            String user_id = (String) session.getAttribute("id"); // 获取用户id
            String username = request.getParameter("username");
            String age = request.getParameter("age");
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            String sql = "update myuser set name=?,psw=?,age=?,city=?,address=?,phone=? where id=?";
            Object[] params = {username,password,age,city,address,phone,user_id};
            int res = basedao.executeIUD(sql,params);
            PrintWriter out = response.getWriter();
            if (res>0){
                out.write("true");
            }else {
                out.write("false");
            }
        }
    }

    // 处理查询用户信息的ajax
    public static void get_userinfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("id"); // 获取用户id
        String sql = "select * from myuser where id=?";
        Object[] params = {user_id};
        ArrayList<myuser> res = myuserdao.query(sql, params);
        PrintWriter out = response.getWriter();
        out.write(res.get(0).toString());   // 返回json字符串
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
