package com.webproject.project01.VO;

import com.webproject.project01.PO.SPU;
import com.webproject.project01.PO.User;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

public class OrderVO {
    private long id;
    private String orderTime;
    private String configSpecs;
    private String accessory;
    private String name;
    private int num;
    private double totalPrice;
    private String payStatus;
    private String picture;
    private long spuId;
    private long skuId;
    private long userId;

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

    public long getSpuId() {
        return spuId;
    }

    public void setSpuId(long spuId) {
        this.spuId = spuId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
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

    public long getSkuId() {
        return skuId;
    }

    public void setSkuId(long skuId) {
        this.skuId = skuId;
    }

    public OrderVO(){}

    public OrderVO(long id, String orderTime, String configSpecs, String accessory, String name, int num, double totalPrice, String payStatus, String picture, long spuId, long skuId, long userId) {
        this.id = id;
        this.orderTime = orderTime;
        this.configSpecs = configSpecs;
        this.accessory = accessory;
        this.name = name;
        this.num = num;
        this.totalPrice = totalPrice;
        this.payStatus = payStatus;
        this.picture = picture;
        this.spuId = spuId;
        this.skuId = skuId;
        this.userId = userId;
    }
}
