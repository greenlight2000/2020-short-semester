package com.webproject.project01.VO;

import com.webproject.project01.PO.SPU;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

public class SKUVO {
    private long id;
    private String name;
    private double totalPrice;
    private String stockNum;
    private String picture;
    private String configSpecs;
    private long SPUId;

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

    public String getStockNum() {
        return stockNum;
    }

    public void setStockNum(String stockNum) {
        this.stockNum = stockNum;
    }

    public String getConfigSpecs() {
        return configSpecs;
    }

    public void setConfigSpecs(String configSpecs) {
        this.configSpecs = configSpecs;
    }

    public long getSPUId() {
        return SPUId;
    }

    public void setSPUId(long SPUId) {
        this.SPUId = SPUId;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public SKUVO(long id, String name, double totalPrice, String stockNum, String picture, String configSpecs, long SPUId) {
        this.id = id;
        this.name = name;
        this.totalPrice = totalPrice;
        this.stockNum = stockNum;
        this.picture = picture;
        this.configSpecs = configSpecs;
        this.SPUId = SPUId;
    }
    public SKUVO(){}
}
