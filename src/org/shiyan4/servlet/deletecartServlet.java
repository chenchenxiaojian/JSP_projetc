package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 0:02
 */

import org.shiyan4.dao.basedao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/deletecartServlet")
public class deletecartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ISBN = request.getParameter("ISBN");
        String user_id = (String) request.getSession().getAttribute("id");
        String sql = "delete from cart where book_ISBN=? and user_id=?";
        Object[] params = {ISBN,user_id};
        int res = basedao.executeIUD(sql,params);
        PrintWriter out = response.getWriter();
        if (res > 0){  // 删除成功
            out.write("true");
        }else {
            out.write("false");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
