package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 12:59
 */

import org.shiyan4.dao.order_tabledao;
import org.shiyan4.entity.order_table;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/showOrderTableServlet")
public class showOrderTableServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_id = (String) request.getSession().getAttribute("id");
        String sql = "select * from order_table where user_id=?";
        Object[] params = {user_id};
        ArrayList<order_table>order_tables = order_tabledao.query(sql,params);
        request.getSession().setAttribute("order_tables", order_tables);
        request.getSession().setAttribute("update_ordertable", "false");
        request.getRequestDispatcher("querycartServlet").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
