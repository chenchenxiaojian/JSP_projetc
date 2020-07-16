package org.shiyan4.servlet;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/13 0:38
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
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/ShowBookListServlet")
public class ShowBookListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        PrintWriter out = response.getWriter();
//        System.out.println("this is ShowBookListServlet");
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html charset=uft-8");

        String currentPage = request.getParameter("currentPage");  // 获取请求页面编号
        String divsion = request.getParameter("division"); // 根据division判断书籍展示的类别
        System.out.println("divsion::"+divsion);


        int [] res;                                 // {书籍总数， 页数（分成多少页）}
        int count = 15;                             // 每页15个数据
        int cpage = 1; // 默认第一页
        if (currentPage != null){
            cpage = Integer.parseInt(currentPage);
        }
        ArrayList<book_info> book_list;             // 查询的书籍列表
        // 判断是否有类别division
        Object[] params;
        if (divsion != null && !divsion.equals("null")){
            // 带division查询
                params = new Object[]{divsion, (cpage - 1) * count, count};
                String sql = "select * from book_info where division=? order by 'ISBN' desc limit ?,?";
                book_list = bookdao.QueryBook(sql, params);
                String s = "select count(*) from book_info where division=?";
                params = new Object[]{divsion};
                res = bookdao.getSum(s, params);

        }else{              // 查询全部类别，没有division参数或者division==null
            params = new Object[]{(cpage-1)*count, count};
            String sql = "select * from book_info order by 'ISBN' desc limit ?,?";
            book_list = bookdao.QueryBook(sql, params);
            String s = "select count(*) from book_info";
            params = null;
            res = bookdao.getSum(s,params);
        }
        int lastpage = 1;
        int nextpage = res[1];
        if (cpage != 1){
            lastpage = cpage-1;
        }
        if (cpage != res[1]){
            nextpage = cpage+1;
        }
        HttpSession session = request.getSession();
        request.setAttribute("book_list", book_list);
        request.setAttribute("cpage", cpage);
        request.setAttribute("lastpage", lastpage);
        request.setAttribute("nextpage", nextpage);
        request.setAttribute("book_sum", res[0]);
        request.setAttribute("page_sum", res[1]);
        request.setAttribute("division", divsion);
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
