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
     * query all the accessories in the store
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
     * convert PO's list to VO's list
     * @param poList po layer list object
     * @return vo layer list object
     */
    public List<AccessoryVO> buildVoList(List<Accessory> poList){
        List<AccessoryVO> voList = new ArrayList<>();
        for(Accessory accessory : poList){
            voList.add(this.buildVo(accessory));
        }
        return voList;
    }

    /**
     * convert one PO to one VO
     * @param accessory one po of accessory
     * @return one vo of accessory
     */
    public AccessoryVO buildVo(Accessory accessory){
        return new AccessoryVO(accessory.getId(),accessory.getName(),accessory.getPrice(),accessory.getStockNum(),accessory.getStore().getId());
    }
}
