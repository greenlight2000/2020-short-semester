package com.webproject.project01.Service;

import com.webproject.project01.Dao.BaseDao;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

/**
 * Service抽象类，封装了复用性较强的1.单个条件查询函数2.排序函数3.分页函数
 * @param <T> 单个条件查询函数中的所查询的目标PO类
 */
public abstract class BaseService<T> {
    /**
     * 根据单个查询条件查询PO层数据
     * @param key PO层属性名
     * @param value 查询条件中属性的值
     * @param isFuzzy 是否模糊查询
     * @param TDao Dao层接口
     * @return 查询结果(List)
     */
    public List<T> searchTs(String key, String value, boolean isFuzzy, BaseDao<T> TDao)//throws RuntimeException
    {
        //定制检索条件，返回一个谓词实例
        Specification<T> spec = new Specification<T>() {
            @Override
            public Predicate toPredicate(Root<T> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Predicate equal = criteriaBuilder.equal(root.get(key),value);
                Predicate like = criteriaBuilder.like(root.get(key).as(String.class),"%"+value+"%");
                return (isFuzzy? like : equal);            }
        };
        //把构造好的谓词放入接口 搜索
        List<T> list = TDao.findAll(spec);
        return list;
    }
    /**
     * 构建排序策略（默认按照id降序排序）
     * @param key 根据key字段排序(String)
     * @param asc 是否升序(boolean)
     * @return 排序策略
     */
    public Sort makeSort(String key, boolean asc){
        if(key==null)
            key = "id";
        return Sort.by((asc?Sort.Direction.ASC: Sort.Direction.DESC),key);
    }

    /**
     * 构建分页策略
     * @param pageNum 查询第pageNum页的内容
     * @param pageSize 每页放pageSize条数据
     * @param sort 分页时的排序策略
     * @return 分页策略
     */
    public Pageable makePage(int pageNum, int pageSize, Sort sort){
        Pageable pageable = PageRequest.of(pageNum-1,pageSize,sort);
        return pageable;
    }


}
