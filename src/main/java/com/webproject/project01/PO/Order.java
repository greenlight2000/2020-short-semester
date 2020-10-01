package com.webproject.project01.PO;

import javax.persistence.*;

@Entity
@Table(name="Ordering")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "order_time")
    private String orderTime;
    @Column(name = "config_specs")
    private String configSpecs;
    @Column(name = "accessory")
    private String accessory;
    @Column(name = "name")
    private String name;
    @Column(name = "num")
    private int num;
    @Column(name = "total_price")
    private double totalPrice;
    @Column(name = "pay_status")
    private String payStatus;
    @Column(name = "picture")
    private String picture;
    @ManyToOne(targetEntity = SPU.class)
    @JoinColumn(name = "SPU_id",referencedColumnName = "id")
    private SPU SPU;
    @ManyToOne(targetEntity = User.class)
    @JoinColumn(name = "user_id",referencedColumnName = "id")
    private User user;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public String getConfigSpecs() {
        return configSpecs;
    }

    public void setConfigSpecs(String configSpecs) {
        this.configSpecs = configSpecs;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public com.webproject.project01.PO.SPU getSPU() {
        return SPU;
    }

    public void setSPU(com.webproject.project01.PO.SPU SPU) {
        this.SPU = SPU;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAccessory() {
        return accessory;
    }

    public void setAccessory(String accessory) {
        this.accessory = accessory;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Order() {
    }

    public Order(String orderTime, String configSpecs, String accessory, String name, int num, double totalPrice, String payStatus, String picture, com.webproject.project01.PO.SPU SPU, User user) {
        this.orderTime = orderTime;
        this.configSpecs = configSpecs;
        this.accessory = accessory;
        this.name = name;
        this.num = num;
        this.totalPrice = totalPrice;
        this.payStatus = payStatus;
        this.picture = picture;
        this.SPU = SPU;
        this.user = user;
    }

}
