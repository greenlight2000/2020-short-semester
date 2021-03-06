package com.webproject.project01.VO;

import com.webproject.project01.PO.Classification;
import com.webproject.project01.PO.ConfigKey;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.PO.Store;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

public class ClassificationVO{
    private long id;

    private String name;

    private long storeId;

    private long parentId;

    private String parentName;

    private List<Long> childIdList = new ArrayList<>();

    private int spuNum;

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

    public long getStoreId() {
        return storeId;
    }

    public void setStoreId(long storeId) {
        this.storeId = storeId;
    }

    public long getParentId() {
        return parentId;
    }

    public void setParentId(long parentId) {
        this.parentId = parentId;
    }

    public List<Long> getChildIdList() {
        return childIdList;
    }

    public void setChildIdList(List<Long> childIdList) {
        this.childIdList = childIdList;
    }

    public int getSpuNum() {
        return spuNum;
    }

    public void setSpuNum(int spuNum) {
        this.spuNum = spuNum;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public ClassificationVO() {
    }

    public ClassificationVO(long id, String name, long storeId, long parentId, String parentName, List<Long> childIdList, int spuNum) {
        this.id = id;
        this.name = name;
        this.storeId = storeId;
        this.parentId = parentId;
        this.parentName = parentName;
        this.childIdList = childIdList;
        this.spuNum = spuNum;
    }

    @Override
    public String toString() {
        return "ClassificationVO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", storeId=" + storeId +
                ", parentId=" + parentId +
                ", childIdList=" + childIdList +
                '}';
    }
}
