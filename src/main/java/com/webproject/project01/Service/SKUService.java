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
     * query the sku information belonging to one given spu
     * @param spuId spu id
     * @return po sku list
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
     * po -> po
     * @param sku po
     * @return vo
     */
    public SKUVO buildVo(SKU sku){
        return new SKUVO(sku.getId(),sku.getName(), sku.getTotalPrice(),sku.getStockNum(),sku.getPicture(), sku.getConfigSpecs(),sku.getSPU().getId());
    }

    /**
     * po list =>vo list
     * @param skuList po list
     * @return vo list
     */
    public List<SKUVO> buildVoList(List<SKU> skuList){
        List<SKUVO> skuVoList = new ArrayList<>();
        for(SKU sku : skuList){
            skuVoList.add(buildVo(sku));
        }
        return skuVoList;
    }
}
