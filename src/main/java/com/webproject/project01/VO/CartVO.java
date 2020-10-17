package com.webproject.project01.VO;

public class CartVO {
    private long id;
    private String configSpecs;
    private String accessory;
    private String name;
    private String picture;
    private int num;
    private double totalPrice;
    private long spuId;
    private long skuId;
    private long userId;

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

    public long getSkuId() {
        return skuId;
    }

    public void setSkuId(long skuId) {
        this.skuId = skuId;
    }

    public CartVO() {
    }

    public CartVO(long id, String configSpecs, String accessory, String name, String picture, int num, double totalPrice, long spuId, long skuId, long userId) {
        this.id = id;
        this.configSpecs = configSpecs;
        this.accessory = accessory;
        this.name = name;
        this.picture = picture;
        this.num = num;
        this.totalPrice = totalPrice;
        this.spuId = spuId;
        this.skuId = skuId;
        this.userId = userId;
    }
}
