package com.webproject.project01.PO;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="Configuration_key")
public class ConfigKey {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "key")
    private String key;
    @ManyToOne(targetEntity = Classification.class)
    @JoinColumn(name = "classification_id",referencedColumnName = "id")
    private Classification classification;

    @OneToMany(mappedBy = "key",cascade = CascadeType.ALL)
    private List<ConfigValue> valueList;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public Classification getClassification() {
        return classification;
    }

    public void setClassification(Classification classification) {
        this.classification = classification;
    }

    public List<ConfigValue> getValueList() {
        return valueList;
    }

    public void setValueList(List<ConfigValue> valueList) {
        this.valueList = valueList;
    }

    public ConfigKey() {
    }

    public ConfigKey(String key, Classification classification, List<ConfigValue> valueList) {
        this.key = key;
        this.classification = classification;
        this.valueList = valueList;
    }
}
