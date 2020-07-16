package org.shiyan4.entity;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 9:47
 */

public class order_table {
    private int order_id;
    private String user_id;
    private String accept_username;
    private String accept_address;
    private String accept_phone;
    private String order_time;

    public order_table(int order_id, String user_id, String accept_username, String accept_address, String accept_phone, String order_time) {
        this.order_id = order_id;
        this.user_id = user_id;
        this.accept_username = accept_username;
        this.accept_address = accept_address;
        this.accept_phone = accept_phone;
        this.order_time = order_time;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getAccept_username() {
        return accept_username;
    }

    public void setAccept_username(String accept_username) {
        this.accept_username = accept_username;
    }

    public String getAccept_address() {
        return accept_address;
    }

    public void setAccept_address(String accept_address) {
        this.accept_address = accept_address;
    }

    public String getAccept_phone() {
        return accept_phone;
    }

    public void setAccept_phone(String accept_phone) {
        this.accept_phone = accept_phone;
    }

    public String getOrder_time() {
        return order_time;
    }

    public void setOrder_time(String order_time) {
        this.order_time = order_time;
    }
}
