package org.shiyan4.dao;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/14 0:47
 */


import org.shiyan4.entity.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class cartdao {
    public static ArrayList<cart> query(String sql,Object[] params){
        ArrayList<cart> cart_list = new ArrayList<cart>();
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
                cart item = new cart(
                        rs.getInt("id"),
                        rs.getString("user_id"),
                        rs.getString("book_ISBN"),
                        rs.getInt("book_account")
                );
                System.out.println(item);
                cart_list.add(item);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            basedao.closeall(rs,ps,conn);
        }
        return cart_list;
    }

}
