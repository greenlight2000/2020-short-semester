package com.webproject.project01.Dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;

@NoRepositoryBean//telling spring framework do not create this bean object when scanning the files(because this is just interface used for normalization, 'T' is not defined yet)
public interface BaseDao<T> extends JpaRepository<T,Long>, JpaSpecificationExecutor<T> {
}
