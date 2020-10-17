package com.webproject.project01.PO;

import javax.persistence.*;

@Entity
@Table(name="Cart")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "config_specs")
    private String configSpecs;
    @Column(name = "accessory")
    private String accessory;
    @Column(name = "name")
    private String name;
    @Column(name = "picture")
    private String picture;
    @Column(name = "num")
    private int num;
    @Column(name = "total_price")
    private double totalPrice;
    @ManyToOne(targetEntity = SPU.class)
    @JoinColumn(name = "SPU_id",referencedColumnName = "id")
    private SPU SPU;
    @ManyToOne(targetEntity = SKU.class)
    @JoinColumn(name = "SKU_id",referencedColumnName = "id")
    private SKU SKU;
    @ManyToOne(targetEntity = User.class)
    @JoinColumn(name = "user_id",referencedColumnName = "id")
    private User user;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getConfigSpecs() {
        return configSpecs;
    }

    public void setConfigSpecs(String configSpecs) {
        this.configSpecs = configSpecs;
    }

    public String getAccessory() {
        return accessory;
    }

    public void setAccessory(String accessory) {
        this.accessory = accessory;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
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

    public com.webproject.project01.PO.SKU getSKU() {
        return SKU;
    }

    public void setSKU(com.webproject.project01.PO.SKU SKU) {
        this.SKU = SKU;
    }

    public Cart() {
    }


    public Cart(long id, String configSpecs, String accessory, String name, String picture, int num, double totalPrice) {
        this.id = id;
        this.configSpecs = configSpecs;
        this.accessory = accessory;
        this.name = name;
        this.picture = picture;
        this.num = num;
        this.totalPrice = totalPrice;
    }
}
