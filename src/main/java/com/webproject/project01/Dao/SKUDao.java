package com.webproject.project01.Dao;

import com.webproject.project01.PO.SKU;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.VO.SPUVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SKUDao extends BaseDao<SKU> {
}
