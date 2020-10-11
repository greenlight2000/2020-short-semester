package com.webproject.project01.Service;

import com.webproject.project01.Dao.ClassificationDao;
import com.webproject.project01.Dao.SPUDao;
import com.webproject.project01.PO.Classification;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.VO.ClassificationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class ClassService extends BaseService<Classification> {
    @Autowired
    private ClassificationDao classificationDao;

    /**
     * 查询该store中的根分类
     * @return po层list
     */
    public List<Classification> showRootClass(){
        Specification<Classification> spec = new Specification<Classification>() {
            @Override
            public Predicate toPredicate(Root<Classification> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                return criteriaBuilder.isNull(root.get("parentClass"));
            }
        };
        return classificationDao.findAll(spec);
    }
    /**
     * 查询该store中的叶子分类
     * @return po层list
     */
    public List<Classification> showLeaveClass(){
        Specification<Classification> spec = new Specification<Classification>() {
            @Override
            public Predicate toPredicate(Root<Classification> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                return criteriaBuilder.isEmpty(root.get("childClassList"));
            }
        };
        return classificationDao.findAll(spec);
    }
    public List<Classification> showAncestorClass(long id){
        Classification initClass = classificationDao.getOne(id);
        List<Classification> ancestorClassList = new ArrayList<>();
        ancestorClassList.add(initClass);

        for(Classification p = initClass.getParentClass(); p!=null; p = p.getParentClass()){
            ancestorClassList.add(p);
        }
        Collections.reverse(ancestorClassList);
        return ancestorClassList;
    }
    /**
     * 查询某一父分类的下一层孩子分类
     * @param id 父分类的id
     * @return po层list
     */
    public List<Classification> showChildClass(long id){
        Classification classification = classificationDao.getOne(id);
        return classification.getChildClassList();
    }
    /**
     * 查询某一个分类树下所有叶子结点包含的spu
     * @param id 根分类结点id
     * @return spuList
     */
    public List<SPU> showSPU(long id){
        Classification classification = classificationDao.getOne(id);
        List<SPU> spuList = new ArrayList<>();
        concatList(classification,spuList);
        return spuList;
    }
    /**
     * po层list转换成vo层list
     * @param classList po层list
     * @return vo层list
     */
    public List<ClassificationVO> buildVoList(List<Classification> classList){
        List<ClassificationVO> classificationVOList = new ArrayList<>();
        for(Classification classification : classList){
            classificationVOList.add(classification.toVO());
        }
        return classificationVOList;
    }
    /**
     * po数据转成vo数据
     * @param classification po数据
     * @return vo数据
     */
    public ClassificationVO buildVo(Classification classification){
        return classification.toVO();
    }

    //private方法
    /**
     * 递归拼接classification树的所有子结点下面的spu，装入spuList
     * @param classification 父结点分类
     * @param spuList 初始list
     */
    private void concatList(Classification classification, List<SPU> spuList){
        if(classification.getChildClassList().isEmpty()){//如果这个类无孩子类，则它是有spu的，拼接进list
            for(SPU spu : classification.getSPUList()){
                spuList.add(spu);
            }
        }else{//如果有孩子，说明它没有spu，递归访问它的孩子类
            for (Classification childClass : classification.getChildClassList())
                concatList(childClass, spuList);
        }
    }

}
