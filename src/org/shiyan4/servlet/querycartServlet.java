package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 0:08
 */

import org.shiyan4.dao.bookdao;
import org.shiyan4.dao.cartdao;
import org.shiyan4.entity.book_info;
import org.shiyan4.entity.cart;
import org.shiyan4.entity.order_table;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/querycartServlet")
public class querycartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 本来想用嵌套json传数据，但是不会，且明天deadline,no time
        System.out.println("querycartServlet");
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/json;charset=utf-8");  // 设置为json类型
        response.setCharacterEncoding("utf-8");
        String user_id = (String) request.getSession().getAttribute("id");
        String sql = "select * from cart where user_id=?";
        Object[] params = {user_id};
        ArrayList<cart>res = cartdao.query(sql,params);
        ArrayList<book_info>book_info = new ArrayList<book_info>();
        for (int i=0; i<res.size(); i++){
            String ISBN = res.get(i).getBook_ISBN();
            sql = "select * from book_info where ISBN=?";
            params = new Object[]{ISBN};
            ArrayList<book_info>temp = bookdao.QueryBook(sql, params);
            book_info.add(temp.get(0));
        }
        request.setAttribute("cart_list", res);
        request.setAttribute("book_info", book_info);
        ArrayList<order_table>order_tables = (ArrayList<order_table>) request.getAttribute("order_tables");
        request.getRequestDispatcher("user_config.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
