package com.webproject.project01.Service;

import com.sun.istack.NotNull;
import com.webproject.project01.Dao.BaseDao;
import com.webproject.project01.Dao.SPUDao;
import com.webproject.project01.PO.SKU;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.VO.SPUVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.support.PageableExecutionUtils;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

@Service
public class SPUService extends BaseService<SPU>{
    @Autowired
    SPUDao spuDao;

    /**
     * 从该商店中按照键值搜索
     * @param storeId store id
     * @param key po层spu对象的属性名
     * @param value 查询条件中该属性的值
     * @param isFuzzy fuzzy search(boolean)
     * @param sort sort strategy
     * @return list of the result
     */
    public List<SPU> searchSpuByStoreAndKeyWithSort(long storeId, String key, String value, boolean isFuzzy, Sort sort)//throws RuntimeException
    {
        Specification<SPU> spec = new Specification<SPU>() {
            @Override
            public Predicate toPredicate(Root<SPU> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicatesList = new ArrayList<>();

                if (isFuzzy) {//like key:value模糊查询
                    predicatesList.add(
                            criteriaBuilder.like(
                                    root.get(key), "%" + value + "%"));
                }else{//equal key:value精准匹配
                    predicatesList.add(
                            criteriaBuilder.equal(
                                    root.get(key),value));
                }
                //查询当前store中的商品
                predicatesList.add(
                        criteriaBuilder.equal(
                                root.get("store").get("id"), storeId));
                System.out.println("size="+predicatesList.size());

                //PageRequest pageRequest = buildPageRequest(pageNumber, pageSize);
                return criteriaBuilder.and(
                        predicatesList.toArray(new Predicate[predicatesList.size()]));
            }
        };

        List<SPU> spuList = spuDao.findAll(spec,sort);
        return spuList;
    }

    /**
     * 分页查询po层spu list
     * @param storeId 商店id
     * @param key spu属性名
     * @param value 查询条件中key属性的值
     * @param isFuzzy 是否模糊查询
     * @param page 分页策略
     * @return po层spu的page对象
     */
    public Page<SPU> searchSpuByStoreAndKeyWithPage(long storeId, String key, String value, boolean isFuzzy, Pageable page)//throws RuntimeException
    {
        Specification<SPU> spec = new Specification<SPU>() {
            @Override
            public Predicate toPredicate(Root<SPU> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicatesList = new ArrayList<>();

                if (isFuzzy) {//like key:value模糊查询
                    predicatesList.add(
                            criteriaBuilder.like(
                                    root.get(key), "%" + value + "%"));
                }else{//equal key:value精准匹配
                    predicatesList.add(
                            criteriaBuilder.equal(
                                    root.get(key),value));
                }
                //查询当前store中的商品
                predicatesList.add(
                        criteriaBuilder.equal(
                                root.get("store").get("id"), storeId));

                //PageRequest pageRequest = buildPageRequest(pageNumber, pageSize);
                return criteriaBuilder.and(
                        predicatesList.toArray(new Predicate[predicatesList.size()]));
            }
        };

        Page<SPU> spuPage = spuDao.findAll(spec, page);
        return spuPage;
    }

    /**
     * po层list转成vo层list
     * @param spuList po层list
     * @return vo层list
     */
    public List<SPUVO> buildVoList(List<SPU> spuList){
        List<SPUVO> spuVoList = new ArrayList<>();
        for(SPU spu : spuList)
            spuVoList.add(spu.toVO());
        return spuVoList;
    }



}
