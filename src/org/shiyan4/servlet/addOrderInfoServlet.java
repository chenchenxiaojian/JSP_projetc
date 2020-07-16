package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 11:03
 */

import org.shiyan4.dao.basedao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/addOrderInfoServlet")
public class addOrderInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html charset=uft-8");
        String order_id = request.getParameter("order_id");
        String book_account = request.getParameter("book_account");
        String book_name = request.getParameter("book_name");
        String book_price = request.getParameter("book_price");
        // 写入order_info
        String sql = "insert into order_info(order_id,book_name,book_price,book_account) values(?,?,?,?)";
        Object[] params = {order_id,book_name,book_price,book_account};
        int res = basedao.executeIUD(sql,params);
        if (res>0){
            PrintWriter out = response.getWriter();
            out.write("true");
        }
        // 将此表项从购物车表中删除
        String user_id = (String)request.getSession().getAttribute("id");
        String ISBN = request.getParameter("ISBN");
        System.out.println("要删除的ISBN"+ISBN);
        sql = "delete from cart where user_id=? and book_ISBN=?";
        params = new Object[]{user_id,ISBN};
        res = basedao.executeIUD(sql,params);
        if (res>0){
            System.out.println("删除成功");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
