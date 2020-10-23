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
 * Service abstract class，pre-defines 3 frequently used methods: 1.search by single index 2.sorting 3.paging
 * @param <T> objective PO class
 */
public abstract class BaseService<T> {
    /**
     * search data by a named index, and map the results onto PO layer
     * @param key index (consistent to PO's attribute name)
     * @param value corresponding value of the index
     * @param isFuzzy use fuzzy search or not
     * @param TDao Dao interface
     * @return results(in List)
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
     * build sorting strategy（sort by id by default）
     * @param key sorting index(String)
     * @param asc sorting order(boolean)
     * @return sorting strategy
     */
    public Sort makeSort(String key, boolean asc){
        if(key==null)
            key = "id";
        return Sort.by((asc?Sort.Direction.ASC: Sort.Direction.DESC),key);
    }

    /**
     * build paging strategy
     * @param pageNum pageNum^th page to return
     * @param pageSize put {pageSize} pieces of tuples in every page
     * @param sort sorting strategy
     * @return paging strategy
     */
    public Pageable makePage(int pageNum, int pageSize, Sort sort){
        Pageable pageable = PageRequest.of(pageNum-1,pageSize,sort);
        return pageable;
    }


}
