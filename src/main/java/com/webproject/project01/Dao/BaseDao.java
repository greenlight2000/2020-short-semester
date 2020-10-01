package com.webproject.project01.Dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;

@NoRepositoryBean//告诉spring在扫描时不要创建这个接口的bean对象
public interface BaseDao<T> extends JpaRepository<T,Long>, JpaSpecificationExecutor<T> {
}
