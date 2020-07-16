package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 14:43
 */

import org.shiyan4.dao.order_infodao;
import org.shiyan4.entity.order_info;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/showOrderInfoServlet")
public class showOrderInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");  // 设置为json类型
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html charset=uft-8");
        String order_id = request.getParameter("order_id");
        String sql = "select * from order_info where order_id=?";
        Object[] params = {order_id};
        ArrayList<order_info> order_infodaos = order_infodao.query(sql,params);
        String res = "";
        for (int i=0; i<order_infodaos.size(); i++){
            res += order_infodaos.get(i).getBook_name() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "
                    + order_infodaos.get(i).getBook_account() + "本&nbsp;&nbsp;&nbsp;&nbsp; ￥"
                    + order_infodaos.get(i).getBook_price() + "<br/>";
        }
        System.out.println(res);
        if (order_infodaos.size() >0){
            PrintWriter out = response.getWriter();
            out.write(res);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
