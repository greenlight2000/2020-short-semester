package com.webproject.project01.VO;

import com.webproject.project01.PO.Store;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

public class AccessoryVO {
    private long id;
    private String name;
    private double price;
    private int stockNum;
    private long storeId;

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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStockNum() {
        return stockNum;
    }

    public void setStockNum(int stockNum) {
        this.stockNum = stockNum;
    }

    public long getStoreId() {
        return storeId;
    }

    public void setStoreId(long storeId) {
        this.storeId = storeId;
    }
    public AccessoryVO(){}
    public AccessoryVO(long id, String name, double price, int stockNum, long storeId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.stockNum = stockNum;
        this.storeId = storeId;
    }
}
