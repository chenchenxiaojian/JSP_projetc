package org.shiyan4.entity;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/15 11:04
 */

public class order_info {
    private int id;
    private int order_id;
    private String book_name;
    private int book_account;
    private double book_price;

    public order_info(int id, int order_id, String book_name, int book_account, double book_price) {
        this.id = id;
        this.order_id = order_id;
        this.book_name = book_name;
        this.book_account = book_account;
        this.book_price = book_price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public int getBook_account() {
        return book_account;
    }

    public void setBook_account(int book_account) {
        this.book_account = book_account;
    }

    public double getBook_price() {
        return book_price;
    }

    public void setBook_price(double book_price) {
        this.book_price = book_price;
    }
}

