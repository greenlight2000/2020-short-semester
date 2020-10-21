package com.webproject.project01.VO;

import com.webproject.project01.Dao.ConfigKeyDao;
import com.webproject.project01.PO.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.persistence.*;
import java.util.List;

public class SPUVO {
    private long id;

    private String name;

    private double price;

    private String brand;

    private String launchTime;

    private ClassificationVO classificationVO;

    private long storeId;

    private String configChoice;

    private String description;

    private String picture;

    private int sales;

    public SPUVO() {

    }

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

    public String getLaunchTime() {
        return launchTime;
    }

    public void setLaunchTime(String launchTime) {
        this.launchTime = launchTime;
    }

    public ClassificationVO getClassificationVO() {
        return classificationVO;
    }

    public void setClassificationVO(ClassificationVO classificationVO) {
        this.classificationVO = classificationVO;
    }

    public long getStoreId() {
        return storeId;
    }

    public void setStoreId(long storeId) {
        this.storeId = storeId;
    }

    public String getConfigChoice() {
        return configChoice;
    }

    public void setConfigChoice(String configChoice) {
        this.configChoice = configChoice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public int getSales() {
        return sales;
    }

    public void setSales(int sales) {
        this.sales = sales;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public SPUVO(long id, String name, double price, String brand, String launchTime, ClassificationVO classificationVO, long storeId, String configChoice, String description, String picture, int sales) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.brand = brand;
        this.launchTime = launchTime;
        this.classificationVO = classificationVO;
        this.storeId = storeId;
        this.configChoice = configChoice;
        this.description = description;
        this.picture = picture;
        this.sales = sales;
    }

    @Override
    public String toString() {
        return "SPUVO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", launchTime='" + launchTime + '\'' +
                ", classificationVO=" + classificationVO +
                ", storeId=" + storeId +
                ", configChoice='" + configChoice + '\'' +
                ", description='" + description + '\'' +
                ", picture='" + picture + '\'' +
                ", sales=" + sales +
                '}';
    }

    //    public int getOrderNum() {
//        return orderNum;
//    }
//
//    public void setOrderNum(int orderNum) {
//        this.orderNum = orderNum;
//    }

//    private String concatConfigChoice(List<ConfigKey> configKeyList){
//        StringBuilder choice = new StringBuilder("");
//        for(ConfigKey key : configKeyList){
//            choice.append(key.getKey()).append(",");
//            for(ConfigValue value : key.getValueList()){
//                choice.append(value.getValue()).append(",");
//            }
//            choice.append(";");
//        }
//        return choice.toString();
//    }

//    public SPUVO(SPU SPU) {
//        this.id = SPU.getId();
//        this.name = SPU.getName();
//        this.price = SPU.getPrice();
//        this.launchTime = SPU.getLaunchTime();
//        //this.ClassificationVO = new ClassificationVO(SPU.classification);
//        this.storeId = SPU.getStore().getId();
//        this.configChoice = concatConfigChoice(SPU.getClassification().getConfigKeyList());
//        this.orderNum = SPU.getOrderList().size();
//    }
}
