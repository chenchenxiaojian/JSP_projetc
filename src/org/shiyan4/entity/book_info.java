package org.shiyan4.entity;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/12 20:57
 */

public class book_info {
    private String ISBN;
    private String author;
    private double price;
    private String name;
    private String division;
    private String brief;
    private String publish_date;
    private int page_number;
    private String publish_house;
    private int stock;
    private int sales_volume;
    private String book_cover_path;

    public book_info() {
    }
    public book_info(String ISBN,String author,double price,String name,String division,String brief,String publish_date,int page_number,String publish_house,int stock,int sales_volume,String book_cover_path){
        this.ISBN = ISBN;
        this.author = author;
        this.price = price;
        this.name = name;
        this.division = division;
        this.brief = brief;
        this.publish_date = publish_date;
        this.page_number = page_number;
        this.publish_house = publish_house;
        this.stock = stock;
        this.sales_volume = sales_volume;
        this.book_cover_path = book_cover_path;
    }

    public String getISBN() {
        return ISBN;
    }

    public String getAuthor() {
        return author;
    }

    public double getPrice() {
        return price;
    }

    public String getName() {
        return name;
    }

    public String getDivision() {
        return division;
    }

    public String getBrief() {
        return brief;
    }

    public String getPublish_date() {
        return publish_date;
    }

    public int getPage_number() {
        return page_number;
    }

    public String getPublish_house() {
        return publish_house;
    }

    public int getStock() {
        return stock;
    }

    public int getSales_volume() {
        return sales_volume;
    }

    public String getBook_cover_path() {
        return book_cover_path;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDivision(String division) {
        this.division = division;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public void setPublish_date(String publish_date) {
        this.publish_date = publish_date;
    }

    public void setPage_number(int page_number) {
        this.page_number = page_number;
    }

    public void setPublish_house(String publish_house) {
        this.publish_house = publish_house;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public void setSales_volume(int sales_volume) {
        this.sales_volume = sales_volume;
    }

    public void setBook_cover_path(String book_cover_path) {
        this.book_cover_path = book_cover_path;
    }
}
