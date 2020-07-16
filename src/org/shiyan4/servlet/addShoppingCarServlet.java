package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/13 23:04
 */

import org.shiyan4.dao.basedao;
import org.shiyan4.dao.cartdao;
import org.shiyan4.entity.cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/addShoppingCarServlet")
public class addShoppingCarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 之前：如果当前书籍的数量为空，那么就不能加入购物车
        // 之前：需要注意的是，加入购物车并不会对库存的数量有影响，有影响是支付结算的时候
        // 现在：简单处理吧，直接加入购物车，结算的时候在进行判断吧。。

        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        String user_id = (String) session.getAttribute("id");
        String book_ISBN = request.getParameter("ISBN");
        int addNums = Integer.parseInt(request.getParameter("addNums"));
        String sql = "select * from cart where book_ISBN=? and user_id=?";
        Object[] params = {book_ISBN, user_id};
        ArrayList<cart> res = cartdao.query(sql, params);
        System.out.println("res"+res);
        if (res.size()>0){  // 存在，更新
            sql = "update cart set book_account=book_account+? where book_ISBN=? and user_id=?";
            params = new Object[]{addNums, book_ISBN, user_id};
        }else{      // 不存在， 插入
            sql = "insert into cart(user_id, book_ISBN, book_account) values(?,?,?)";
            params = new Object[]{user_id, book_ISBN, addNums};
        }
        int r = basedao.executeIUD(sql, params);
        if (r>0){  // 插入或者更新成功
            out.write("true");
        }else{
            out.write("false");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
