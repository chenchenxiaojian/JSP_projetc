package org.shiyan4.entity;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/14 0:38
 */

public class cart {
    private int id;
    private String user_id;
    private String book_ISBN;
    private int book_accout;

    public cart(int id, String user_id, String book_ISBN, int book_accout) {
        this.id = id;
        this.user_id = user_id;
        this.book_ISBN = book_ISBN;
        this.book_accout = book_accout;
    }

    @Override
    public String toString() {
        return "{" +
                "\"id\":\""+id+'\"'+
                ",\"user_id\":\""+user_id+'\"'+
                ", \"book_ISBN\":\""+book_ISBN+'\"'+
                ", \"book_accout\":\""+book_accout+'\"'
                +'}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getBook_ISBN() {
        return book_ISBN;
    }

    public void setBook_ISBN(String book_ISBN) {
        this.book_ISBN = book_ISBN;
    }

    public int getBook_accout() {
        return book_accout;
    }

    public void setBook_accout(int book_accout) {
        this.book_accout = book_accout;
    }
}
