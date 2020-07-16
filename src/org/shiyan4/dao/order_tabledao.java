package org.shiyan4.dao;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 10:03
 */

import org.shiyan4.entity.book_info;
import org.shiyan4.entity.myuser;
import org.shiyan4.entity.order_table;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class order_tabledao {
    public static ArrayList<order_table> query(String sql, Object[] params){
        ArrayList<order_table> order_tables = new ArrayList<order_table>();
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
                order_table item = new order_table(
                        rs.getInt("order_id"),
                        rs.getString("user_id"),
                        rs.getString("accept_username"),
                        rs.getString("accept_address"),
                        rs.getString("accept_phone"),
                        rs.getString("order_time")
                );
                order_tables.add(item);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            basedao.closeall(rs,ps,conn);
        }
        return order_tables;
    }
}
