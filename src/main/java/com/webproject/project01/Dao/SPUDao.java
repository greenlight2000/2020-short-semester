package com.webproject.project01.Dao;

import com.webproject.project01.PO.SPU;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SPUDao extends BaseDao<SPU> {
    List<SPU> findByStoreIdAndNameOrderByPriceAsc(long storeId, String name);
    @Query("select spu from SPU spu where spu.price >= ?1 and spu.price <=?2")
    List<SPU> findAllByPrice(double min_price, double max_price);
    @Query(value = "select max(spu.price) from SPU spu",nativeQuery = true)
    double findMaxSPUPrice();
    @Query(value = "select min(spu.price) from SPU spu",nativeQuery = true)
    double findMinSPUPrice();
}
