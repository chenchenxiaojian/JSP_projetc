package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 9:17
 */

import org.shiyan4.dao.basedao;
import org.shiyan4.dao.order_tabledao;
import org.shiyan4.entity.order_table;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet("/addOrderTableServlet")
public class addOrderTableServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html charset=uft-8");
        request.getSession().setAttribute("update_ordertable", "true");
        String user_id = (String)request.getSession().getAttribute("id");
        String accept_people = request.getParameter("accept_people");
        String accept_phone = request.getParameter("accept_phone");
        String accept_address = request.getParameter("accept_address");
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String order_time = time.format( new java.util.Date());  // 获取当前时间戳
        String sql = "insert into order_table(user_id,accept_username,accept_address,accept_phone,order_time) values(?,?,?,?,?)";
        Object[] params = {user_id,accept_people,accept_address,accept_phone,order_time};
        int res = basedao.executeIUD(sql,params);

        if(res>0){
            sql = "select * from order_table where order_time=? ";
            params = new Object[]{order_time};
            ArrayList<order_table>order_tables = order_tabledao.query(sql, params);
            int order_id = order_tables.get(0).getOrder_id();
            System.out.println("order_id:"+order_id);
            PrintWriter out = response.getWriter();
            out.write(Integer.toString(order_id));
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
