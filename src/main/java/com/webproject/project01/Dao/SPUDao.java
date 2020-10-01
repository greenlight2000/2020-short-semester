package com.webproject.project01.Dao;

import com.webproject.project01.PO.SPU;

import java.util.List;

public interface SPUDao extends BaseDao<SPU> {
    List<SPU> findByStoreIdAndNameOrderByPriceAsc(long storeId, String name);
}
