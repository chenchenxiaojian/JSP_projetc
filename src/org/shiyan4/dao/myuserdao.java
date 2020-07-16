package org.shiyan4.dao;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/14 12:49
 */

import org.shiyan4.entity.cart;
import org.shiyan4.entity.myuser;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class myuserdao {
    public static ArrayList<myuser> query(String sql, Object[] params){
        ArrayList<myuser> user_list = new ArrayList<myuser>();
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
                myuser item = new myuser(
                        rs.getString("id"),
                        rs.getString("psw"),
                        rs.getString("name"),
                        rs.getInt("age"),
                        rs.getString("phone"),
                        rs.getString("city"),
                        rs.getString("address")
                );
                user_list.add(item);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            basedao.closeall(rs,ps,conn);
        }
        return user_list;
    }
}
