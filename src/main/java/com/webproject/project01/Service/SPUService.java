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
     * query with sorting strategy
     * @param storeId store id
     * @param key spu's index
     * @param value corresponding value
     * @param isFuzzy use fuzzy search pr not
     * @param sort sorting strategy
     * @return spu list object
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
    public String getSpuMoreDetail(long spuId){
        SPU spu = spuDao.getOne(spuId);
        return spu.getMoreDetail();
    }

    /**
     * query po spu list
     * @param storeId store id
     * @param key spu's index
     * @param value corresponding value
     * @param isFuzzy use fuzzy search pr not
     * @param page paging strategy
     * @return spu's page object
     */
    public Page<SPU> searchSpuByStoreAndKeyWithPage(long storeId, String key, String value, boolean isFuzzy, Pageable page)//throws RuntimeException
    {
        Specification<SPU> spec = new Specification<SPU>() {
            @Override
            public Predicate toPredicate(Root<SPU> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicatesList = new ArrayList<>();

                if (isFuzzy) {//like
                    predicatesList.add(
                            criteriaBuilder.like(
                                    root.get(key), "%" + value + "%"));
                }else{//equal
                    predicatesList.add(
                            criteriaBuilder.equal(
                                    root.get(key),value));
                }
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
     * po list => vo list
     * @param spuList po list
     * @return vo list
     */
    public List<SPUVO> buildVoList(List<SPU> spuList){
        List<SPUVO> spuVoList = new ArrayList<>();
        for(SPU spu : spuList)
            spuVoList.add(spu.toVO());
        return spuVoList;
    }



}
