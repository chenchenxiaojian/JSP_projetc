package org.shiyan4.dao;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 11:06
 */

import org.shiyan4.entity.myuser;
import org.shiyan4.entity.order_info;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class order_infodao {

    public static  ArrayList<order_info> query(String sql,Object[] params){
        ArrayList<order_info> order_infos = new ArrayList<order_info>();
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
                order_info item = new order_info(
                        rs.getInt("id"),
                        rs.getInt("order_id"),
                        rs.getString("book_name"),
                        rs.getInt("book_account"),
                        rs.getDouble("book_price")
                );
                order_infos.add(item);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            basedao.closeall(rs,ps,conn);
        }
        return order_infos;
    }
}
