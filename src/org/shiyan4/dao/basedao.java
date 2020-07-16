package org.shiyan4.dao;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/12 21:30
 * basedao类，mysql的连接，增删该，关闭连接
 */

import java.sql.*;

public class basedao {
    static { // 静态块，在类初次加载时会执行且执行一次
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); //驱动程序名
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static Connection getconn() {
        Connection conn = null;
        String url = "jdbc:mysql://localhost:3306/company?useSSL=false&serverTimezone=UTC&characterEncoding=utf-8"; // 数据库名
        String mysql_username = "root"; //数据库用户名
        String mysql_password = "u%SrtoF<U1V<"; // 数据库用户密码
        try {
            conn = DriverManager.getConnection(url,mysql_username,mysql_password);
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
        return conn;
    }
    public static int executeIUD(String sql, Object[] params)  {
        int count = 0;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
            conn = basedao.getconn();
            ps = conn.prepareStatement(sql);
            for (int i=0; i<params.length; i++){
                ps.setObject(i+1, params[i]);
            }
            count = ps.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        } finally {
            basedao.closeall(null, ps,conn);
        }
        return count;
    }
    public static void closeall(ResultSet rs, PreparedStatement ps, Connection conn){
        try {
            if (rs !=null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
