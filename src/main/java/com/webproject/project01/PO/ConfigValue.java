package com.webproject.project01.PO;

import javax.persistence.*;
@Entity
@Table(name="Configuration_value")
public class ConfigValue {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "value")
    private String value;
    @Column(name = "price")
    private double price;
    @ManyToOne(targetEntity = ConfigKey.class)
    @JoinColumn(name = "key_id",referencedColumnName = "id")
    private ConfigKey key;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public ConfigKey getKey() {
        return key;
    }

    public void setKey(ConfigKey key) {
        this.key = key;
    }

    public ConfigValue() {
    }

    public ConfigValue(String value, double price, ConfigKey key) {
        this.value = value;
        this.price = price;
        this.key = key;
    }
}
