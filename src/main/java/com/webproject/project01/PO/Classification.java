package com.webproject.project01.PO;

import com.webproject.project01.VO.ClassificationVO;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="Classification")
public class Classification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;
    @Column(name = "name")
    private String name;
    @ManyToOne(targetEntity = Store.class)
    @JoinColumn(name = "store_id",referencedColumnName = "id")
    private Store store;
    @ManyToOne(targetEntity = Classification.class, cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
    @JoinColumn(name = "parent_id", referencedColumnName = "id")
    private Classification parentClass;

    @OneToMany(mappedBy = "parentClass", cascade = {CascadeType.REMOVE, CascadeType.REFRESH}, fetch = FetchType.EAGER)
    private List<Classification> childClassList;
    @OneToMany(mappedBy = "classification",cascade = CascadeType.ALL)
    private List<ConfigKey> configKeyList;
    @OneToMany(mappedBy = "classification",cascade = CascadeType.ALL)
    private List<SPU> SPUList;


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

    public Store getStore() {
        return store;
    }

    public void setStore(Store store) {
        this.store = store;
    }

    public Classification getParentClass() {
        return parentClass;
    }

    public void setParentClass(Classification parentClass) {
        this.parentClass = parentClass;
    }

    public List<Classification> getChildClassList() {
        return childClassList;
    }

    public void setChildClassList(List<Classification> childClassList) {
        this.childClassList = childClassList;
    }

    public List<ConfigKey> getConfigKeyList() {
        return configKeyList;
    }

    public void setConfigKeyList(List<ConfigKey> configKeyList) {
        this.configKeyList = configKeyList;
    }

    public List<SPU> getSPUList() {
        return SPUList;
    }

    public void setSPUList(List<SPU> SPUList) {
        this.SPUList = SPUList;
    }

    public Classification() {
    }

    public Classification(String name, Store store, Classification parentClass, List<Classification> childClassList, List<ConfigKey> configKeyList, List<SPU> SPUList) {
        this.name = name;
        this.store = store;
        this.parentClass = parentClass;
        this.childClassList = childClassList;
        this.configKeyList = configKeyList;
        this.SPUList = SPUList;
    }

    public ClassificationVO toVO(){
        ClassificationVO classificationVO = new ClassificationVO();
        classificationVO.setId(id);
        classificationVO.setName(name);
        classificationVO.setStoreId(store.getId());
        if(parentClass==null)
            classificationVO.setParentId(0);
        else
            classificationVO.setParentId(parentClass.getId());
        for(Classification child : childClassList){
            classificationVO.getChildIdList().add(child.getId());
        }
        return classificationVO;
    }

//    @Override
//    public String toString() {
//        return "Classification{" +
//                "id=" + id +
//                ", name='" + name + '\'' +
//                ", store=" + store +
//                ", parentClass=" + parentClass +
//                ", childClassList=" + childClassList +
//                ", configKeyList=" + configKeyList +
//                ", SPUList=" + SPUList +
//                '}';
//    }
}
