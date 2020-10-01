package com.webproject.project01.PO;

import com.fasterxml.jackson.core.JsonParser;
import com.webproject.project01.VO.SPUVO;
import jdk.nashorn.internal.parser.JSONParser;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="SPU")
public class SPU {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "name")
    private String name;
    @Column(name = "price")
    private double price;
    @Column(name = "launch_time")
    private String launchTime;
    @Column(name = "picture")
    private String picture;
    @Column(name = "description")
    private String description;
    @Column(name = "sales")
    private int sales;
    @ManyToOne(targetEntity = Classification.class)
    @JoinColumn(name = "classification_id",referencedColumnName = "id")
    private Classification classification;
    @ManyToOne(targetEntity = Store.class)
    @JoinColumn(name = "store_id",referencedColumnName = "id")
    private Store store;

    @OneToMany(mappedBy = "SPU",cascade = CascadeType.ALL)
    private List<SKU> SKUList;
    @OneToMany(mappedBy = "SPU",cascade = CascadeType.ALL)
    private List<Order> orderList;

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

    public void setLaunchTime(String time) {
        this.launchTime = time;
    }

    public Classification getClassification() {
        return classification;
    }

    public void setClassification(Classification classification) {
        this.classification = classification;
    }

    public Store getStore() {
        return store;
    }

    public void setStore(Store store) {
        this.store = store;
    }

    public List<SKU> getSKUList() {
        return SKUList;
    }

    public void setSKUList(List<SKU> SKUList) {
        this.SKUList = SKUList;
    }

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSales() {
        return sales;
    }

    public void setSales(int sales) {
        this.sales = sales;
    }

    public SPU() {
    }

    public SPU(String name, double price, String launchTime, String picture, String description, int sales, Classification classification, Store store, List<SKU> SKUList, List<Order> orderList) {
        this.name = name;
        this.price = price;
        this.launchTime = launchTime;
        this.picture = picture;
        this.description = description;
        this.sales = sales;
        this.classification = classification;
        this.store = store;
        this.SKUList = SKUList;
        this.orderList = orderList;
    }

    public SPU(String name, double price, String launchTime, Classification classification, Store store, List<SKU> SKUList, List<Order> orderList) {
        this.name = name;
        this.price = price;
        this.launchTime = launchTime;
        this.classification = classification;
        this.store = store;
        this.SKUList = SKUList;
        this.orderList = orderList;
    }

    private String concatConfigChoice(List<ConfigKey> configKeyList){
        StringBuilder choice = new StringBuilder("");
        for(ConfigKey key : configKeyList){
            choice.append(key.getKey()).append(",");
            for(ConfigValue value : key.getValueList()){
                choice.append(value.getValue()).append(",");
            }
            choice.append(";");
        }
        return choice.toString();
    }

    public SPUVO toVO() {

        SPUVO spuvo = new SPUVO();
        spuvo.setId(this.getId());
        spuvo.setName(this.getName());
        spuvo.setPrice(this.getPrice());
        spuvo.setLaunchTime(this.getLaunchTime());
        if(this.classification==null)
            System.out.println("null");
        else
            spuvo.setClassificationVO(this.classification.toVO());
        spuvo.setStoreId(this.getStore().getId());
        spuvo.setConfigChoice(concatConfigChoice(this.getClassification().getConfigKeyList()));
//        spuvo.setOrderNum(this.getOrderList().size());
        spuvo.setDescription(this.getDescription());
        spuvo.setPicture(this.getPicture());
        spuvo.setSales(this.getSales());
        return spuvo;
    }

    @Override
    public String toString() {
        return "SPU{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", launchTime='" + launchTime + '\'' +
                ", picture='" + picture + '\'' +
                ", description='" + description + '\'' +
                ", sales=" + sales +
                ", classification=" + classification +
                ", store=" + store +
                ", SKUList=" + SKUList +
                ", orderList=" + orderList +
                '}';
    }
}
