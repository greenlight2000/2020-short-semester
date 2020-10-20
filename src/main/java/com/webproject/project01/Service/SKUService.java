package com.webproject.project01.Service;

import com.webproject.project01.Dao.SKUDao;
import com.webproject.project01.Dao.SPUDao;
import com.webproject.project01.PO.SKU;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.VO.SKUVO;
import com.webproject.project01.VO.SPUVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service
public class SKUService {
    @Autowired
    SPUDao spuDao;
    @Autowired
    SKUDao skuDao;

    /**
     * 查询某spu下属的sku信息
     * @param spuId spu的id
     * @return po层sku list
     */
    public List<SKU> getSkuListBySpu(long spuId){
        SPU spu = spuDao.getOne(spuId);
        return spu.getSKUList();
    }
    public int getStockNum(long skuId){
        SKU sku = skuDao.getOne(skuId);
        return sku.getStockNum();
    }
    /**
     * 将一条po层数据转成po层数据
     * @param sku 一条po层数据
     * @return 一条vo层数据
     */
    public SKUVO buildVo(SKU sku){
        return new SKUVO(sku.getId(),sku.getName(), sku.getTotalPrice(),sku.getStockNum(),sku.getPicture(), sku.getConfigSpecs(),sku.getSPU().getId());
    }

    /**
     * 将po层list数据转层vo层list
     * @param skuList po层list
     * @return vo层list
     */
    public List<SKUVO> buildVoList(List<SKU> skuList){
        List<SKUVO> skuVoList = new ArrayList<>();
        for(SKU sku : skuList){
            skuVoList.add(buildVo(sku));
        }
        return skuVoList;
    }
}
