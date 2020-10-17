package com.webproject.project01.PO;

import javax.persistence.*;

@Entity
@Table(name="SKU")
public class SKU {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "name")
    private String name;
    @Column(name = "total_price")
    private double totalPrice;
    @Column(name = "stock_num")
    private int stockNum;
    @Column(name = "picture")
    private String picture;
    @Column(name = "config_specs")
    private String configSpecs;
    @ManyToOne(targetEntity = SPU.class)
    @JoinColumn(name = "SPU_id",referencedColumnName = "id")
    private SPU SPU;

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

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getStockNum() {
        return stockNum;
    }

    public void setStockNum(int stockNum) {
        this.stockNum = stockNum;
    }

    public String getConfigSpecs() {
        return configSpecs;
    }

    public void setConfigSpecs(String configSpecs) {
        this.configSpecs = configSpecs;
    }

    public com.webproject.project01.PO.SPU getSPU() {
        return SPU;
    }

    public void setSPU(com.webproject.project01.PO.SPU SPU) {
        this.SPU = SPU;
    }

    public SKU() {
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public SKU(String name, double totalPrice, int stockNum, String configSpecs, com.webproject.project01.PO.SPU SPU) {
        this.name = name;
        this.totalPrice = totalPrice;
        this.stockNum = stockNum;
        this.configSpecs = configSpecs;
        this.SPU = SPU;
    }
}
