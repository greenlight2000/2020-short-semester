package com.webproject.project01.PO;

import javax.persistence.*;

@Entity
@Table(name="Accessory")
public class Accessory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "name")
    private String name;
    @Column(name = "price")
    private double price;
    @Column(name = "stock_num")
    private int stockNum;
    @ManyToOne(targetEntity = Store.class)
    @JoinColumn(name = "store_id",referencedColumnName = "id")
    private Store store;

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

    public Store getStore() {
        return store;
    }

    public void setStore(Store store) {
        this.store = store;
    }

    public Accessory() {
    }

    public Accessory(String name, double price, int stockNum, Store store) {
        this.name = name;
        this.price = price;
        this.stockNum = stockNum;
        this.store = store;
    }
}
