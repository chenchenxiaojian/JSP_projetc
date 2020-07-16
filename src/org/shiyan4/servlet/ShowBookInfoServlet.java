package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/12 17:51
 */

import org.shiyan4.dao.bookdao;
import org.shiyan4.entity.book_info;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

// 使用MVC模式，servlet做控制层
// 对于3层架构来说，servlet不做控制，控制交给service的java代码使用
// 本项目使用MVC模式
@WebServlet("/ShowBookInfoServlet")
public class ShowBookInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        System.out.println("book info servlet");
        String ISBN = request.getParameter("ISBN"); // 获取前台jsp传递过来的参数：书籍的主键号
        System.out.println("isbn:"+ISBN);
        Object[] params = {ISBN};
        String sql = "select * from book_info where ISBN=?";  // 本来这个sql可以放在service服务层封装成函数，servlet在调用的
        ArrayList<book_info> book_list = bookdao.QueryBook(sql, params);
//        for(int i=0; i<book_list.size(); i++){
//            System.out.println(book_list.get(i));
//        }
//        将数据放在请求域中
//        HttpSession session = request.getSession(); // 创建jsp的session对象
        request.setAttribute("book_list", book_list);
//        String nexturl = "book_info.jsp?ISBN"+ISBN;
        request.getRequestDispatcher("book_info.jsp").forward(request,response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
