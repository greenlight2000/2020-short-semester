package com.webproject.project01.PO;

import com.webproject.project01.VO.UserVO;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="User")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "name")
    private String name;
    @Column(name = "phone")
    private String phone;
    @Column(name = "email")
    private String email;
    @Column(name = "password")
    private String password;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    private List<Order> orderList;
    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    private List<Cart> cartList;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }

    public List<Cart> getCartList() {
        return cartList;
    }

    public void setCartList(List<Cart> cartList) {
        this.cartList = cartList;
    }

    public User(){}

    public User(String name, String phone, String email, String password, List<Order> orderList) {
        this.id = 0L;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.password = password;
        this.orderList = orderList;
        this.cartList = new ArrayList<>();
    }
    public UserVO toVo(){
        UserVO userVO = new UserVO(getId(),getName(),getPhone(),getEmail(),getPassword());
        return userVO;
    }
}
