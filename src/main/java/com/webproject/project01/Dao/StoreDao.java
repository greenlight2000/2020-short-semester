package com.webproject.project01.Dao;

import com.webproject.project01.PO.Store;
import com.webproject.project01.PO.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StoreDao extends BaseDao<Store> {
}
