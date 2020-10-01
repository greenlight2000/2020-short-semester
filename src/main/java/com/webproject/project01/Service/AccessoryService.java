package com.webproject.project01.Service;

import com.webproject.project01.Dao.AccessoryDao;
import com.webproject.project01.PO.Accessory;
import com.webproject.project01.Utils.UtilVar;
import com.webproject.project01.VO.AccessoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

@Service
public class AccessoryService extends BaseService<Accessory> {
    @Autowired
    private AccessoryDao accessoryDao;

    /**
     * 查询该store中的所有accessory
     * @return accessory的list
     */
    public List<Accessory> showAccessory(){
        Specification<Accessory> spec = new Specification<Accessory>() {
            @Override
            public Predicate toPredicate(Root<Accessory> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                return criteriaBuilder.equal(root.get("store").get("id"),UtilVar.storeId);
            }
        };
        return accessoryDao.findAll(spec);
    }

    /**
     * po层List数据转换成vo层List
     * @param poList po层list
     * @return vo层list
     */
    public List<AccessoryVO> buildVoList(List<Accessory> poList){
        List<AccessoryVO> voList = new ArrayList<>();
        for(Accessory accessory : poList){
            voList.add(this.buildVo(accessory));
        }
        return voList;
    }

    /**
     * po层单条数据转换成vo层单条数据
     * @param accessory po层单条数据
     * @return vo层单条数据
     */
    public AccessoryVO buildVo(Accessory accessory){
        return new AccessoryVO(accessory.getId(),accessory.getName(),accessory.getPrice(),accessory.getStockNum(),accessory.getStore().getId());
    }
}
