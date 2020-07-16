package org.shiyan4.dao;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/12 22:25
 */

import org.shiyan4.entity.book_info;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class bookdao {
    // 通过参数查询书籍
    public static ArrayList<book_info> QueryBook(String sql, Object[] params){
        ArrayList<book_info> book_list = new ArrayList<book_info>();
        ResultSet rs = null; // 结果集
        Connection conn = basedao.getconn(); //获取连接对象
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(sql);
            if (params != null){
                for(int i=0; i<params.length; i++){
                    ps.setObject(i+1, params[i]);
                }
            }
            rs = ps.executeQuery();
            while (rs.next()){
                book_info item = new book_info(
                        rs.getString("ISBN"),
                        rs.getString("author"),
                        rs.getDouble("price"),
                        rs.getString("name"),
                        rs.getString("division"),
                        rs.getString("brief"),
                        rs.getString("publish_date"),
                        rs.getInt("page_number"),
                        rs.getString("publish_house"),
                        rs.getInt("stock"),
                        rs.getInt("sales_volume"),
                        rs.getString("book_cover_path")
                        );
                book_list.add(item);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            basedao.closeall(rs,ps,conn);
        }
        return book_list;
    }
    private static final int one_page_count = 15; //固定， 每个页面15本书展示
    /*
    * getSum(): 获取所有书籍的个数，总共的页数
    * */
    public static int[] getSum(String sql, Object[] params){
        int sum = 0;
        int page_sum = 1;
        int [] res = {sum, page_sum};
        Connection conn = basedao.getconn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
//            String sql = "select count(*) from book_info";
            ps = conn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    ps.setObject(i + 1, params[i]);
                }
            }
            rs = ps.executeQuery();
            if (rs.next()){
                sum = rs.getInt(1);
               // System.out.println("当前图书数量为："+sum);
            }
            page_sum = sum%bookdao.one_page_count==0?sum/bookdao.one_page_count:sum/bookdao.one_page_count+1;
            res = new int[]{sum, page_sum};
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }finally {
            basedao.closeall(rs,ps,conn);
        }
        return  res;
    }

    // 分页查询
    /*
    public static ArrayList<book_info> QueryBookByPage(int currentPage, int count, String division){
        ArrayList<book_info> book_list = new ArrayList<book_info>();
        ResultSet rs = null; // 结果集
        Connection conn = basedao.getconn(); //获取连接对象
        PreparedStatement ps = null;
        try{
            String sql = "select * from book_info where division=? order by ISBN desc limit ? ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, division);
            ps.setInt(2, (currentPage-1)*count);
            ps.setInt(3, count);
            rs = ps.executeQuery();
            while (rs.next()){
                book_info item = new book_info(
                        rs.getString("ISBN"),
                        rs.getString("author"),
                        rs.getDouble("price"),
                        rs.getString("name"),
                        rs.getString("division"),
                        rs.getString("brief"),
                        rs.getString("publish_date"),
                        rs.getInt("page_number"),
                        rs.getString("publish_house"),
                        rs.getInt("stock"),
                        rs.getInt("sales_volume"),
                        rs.getString("book_cover_path")
                );
                book_list.add(item);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            basedao.closeall(rs,ps,conn);
        }
        return  book_list;
    }
     */
}
