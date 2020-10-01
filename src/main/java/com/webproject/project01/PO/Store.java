package com.webproject.project01.PO;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="Store")
public class Store {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;

    @OneToMany(mappedBy = "store",cascade = CascadeType.ALL)
    private List<Accessory> accessoryList;
    @OneToMany(mappedBy = "store",cascade = CascadeType.ALL)
    private List<Classification> classList;
    @OneToMany(mappedBy = "store",cascade = CascadeType.ALL)
    private List<SPU> SPUList;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public List<Accessory> getAccessoryList() {
        return accessoryList;
    }

    public void setAccessoryList(List<Accessory> accessoryList) {
        this.accessoryList = accessoryList;
    }

    public List<Classification> getClassList() {
        return classList;
    }

    public void setClassList(List<Classification> classList) {
        this.classList = classList;
    }

    public List<SPU> getSPUList() {
        return SPUList;
    }

    public void setSPUList(List<SPU> SPUList) {
        this.SPUList = SPUList;
    }

    public Store() {
    }

    public Store(List<Accessory> accessoryList, List<Classification> classList, List<SPU> SPUList) {
        this.accessoryList = accessoryList;
        this.classList = classList;
        this.SPUList = SPUList;
    }
}
