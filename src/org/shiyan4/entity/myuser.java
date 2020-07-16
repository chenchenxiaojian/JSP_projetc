package org.shiyan4.entity;
/*
 **@author: chenxiaojian
 **@Date: 2020/7/14 12:39
 */

public class myuser {
    private  String id;
    private  String password;
    private  String username;
    private  int age;
    private  String phone;
    private  String city;
    private  String address;


    public myuser(String id, String password, String username, int age, String phone, String city, String address) {
        this.id = id;
        this.password = password;
        this.username = username;
        this.age = age;
        this.phone = phone;
        this.city = city;
        this.address = address;
    }
    @Override
    public String toString() {  // 返回json字符串
        return "{" +
                "\"id\":\""+id+'\"'+
                ",\"username\":\""+username+'\"'+
                ", \"password\":\""+password+'\"'+
                ",\"age\":\""+age+'\"'+
                ", \"phone\":\""+phone+'\"'+
                ", \"city\":\""+city+'\"'+
                ", \"address\":\""+address+'\"'
                +'}';
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
