package com.webproject.project01.Service;

import com.webproject.project01.Dao.OrderDao;
import com.webproject.project01.Dao.SKUDao;
import com.webproject.project01.Dao.SPUDao;
import com.webproject.project01.Dao.UserDao;
import com.webproject.project01.PO.Order;
import com.webproject.project01.PO.SKU;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.PO.User;
import com.webproject.project01.VO.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService extends BaseService<Order>{
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private SPUDao spuDao;
    @Autowired
    private SKUDao skuDao;
    /**
     * 查询某用户的所有订单
     * @param userId 用户的id
     * @return po层数据的list
     */
    public List<Order> getOrderByUser(long userId){
        List<Order> orderVoList = userDao.getOne(userId).getOrderList();
        return orderVoList;
    }
    /**
     * 查询某用户的所有订单，并排序
     * @param userId 用户的id
     * @param sort 排序策略
     * @return po层数据的list
     */
    public List<Order> getOrderWithSort(long userId, Sort sort){
        List<Order> orderList = orderDao.findAll(new Specification<Order>() {
            @Override
            public Predicate toPredicate(Root<Order> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                return criteriaBuilder.equal(root.get("user").get("id"),userId);
            }
        },sort);
        return orderList;
    }
    /**
     * 查询某用户的所有订单，并分页
     * @param userId 用户id
     * @param pageable 分页策略
     * @return po层数据的Page对象
     */
    public Page<Order> getOrderWithPage(long userId, Pageable pageable, String payStatus){
        Page<Order> orderPage = orderDao.findAll(new Specification<Order>() {
            @Override
            public Predicate toPredicate(Root<Order> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicatesList = new ArrayList<>();
                predicatesList.add(
                        criteriaBuilder.equal(root.get("user").get("id"),userId)
                );
                if (payStatus!=null && !payStatus.equals("")){
                    predicatesList.add(
                            criteriaBuilder.equal(root.get("payStatus"), payStatus)
                    );
                }
                return criteriaBuilder.and(predicatesList.toArray(new Predicate[predicatesList.size()]));
            }
        },pageable);
        return orderPage;
    }
    /**
     * 将查询到的po层list数据转成vo层list，并筛选订单的支付状态
     * @param orderList po层list
     * @param payStatus 选择查询支付状态为paid/unpaid的订单
     * @return
     */
    public List<OrderVO> buildOrderVoList(List<Order> orderList, String payStatus){
        List<OrderVO> orderVoList = new ArrayList<>();
        for(Order order : orderList){
//            if(order.getPayStatus().equals(payStatus))
                orderVoList.add(buildOrderVo(order));
        }
        return orderVoList;
    }
    /**
     * 将vo层list转换成po层list并上传数据库
     * @param orderVoList vo层list数据
     */
    public void uploadOrderList(List<OrderVO> orderVoList){
        for(OrderVO orderVo : orderVoList){
            Order order = buildOrder(orderVo);
            uploadOrder(order);
        }
    }
    /**
     * 上传一条新order 并根据payStatus增加SPU销量
     * @param order po层单条order数据
     */
    public void uploadOrder(Order order){
        if(order.getPayStatus().equals("paid")){
            SPU spu = order.getSKU().getSPU();
            int sale = spu.getSales()+order.getNum();//增加SPU销量
            spu.setSales(sale);
            spuDao.save(spu);
        }
        if(!order.getPayStatus().equals("canceled")) {
            int stockNum = order.getSKU().getStockNum() - order.getNum();
            order.getSKU().setStockNum(stockNum);
        }else{
            int stockNum = order.getSKU().getStockNum() + order.getNum();
            order.getSKU().setStockNum(stockNum);
        }
        orderDao.save(order);
    }
    /**
     * 将一条po层数据转化为vo层数据
     * @param order 一条po层数据
     * @return 一条vo层数据
     */
    public OrderVO buildOrderVo(Order order){
        return new OrderVO(order.getId(),order.getOrderTime(),order.getConfigSpecs(),order.getAccessory(),order.getName(),order.getNum(),order.getTotalPrice(),order.getPayStatus(),order.getPicture(),order.getSKU().getSPU().getId(),order.getSKU().getId(),order.getUser().getId());
    }
    /**
     * 将一条vp层数据转换层数据
     * @param orderVO 一条vo层数据
     * @return 一条po层数据
     */
    public Order buildOrder(OrderVO orderVO){
        SKU sku = skuDao.getOne(orderVO.getSkuId());
        SPU spu = sku.getSPU();
        User user = userDao.getOne(orderVO.getUserId());
        return new Order(orderVO.getOrderTime(),orderVO.getConfigSpecs(),orderVO.getAccessory(),orderVO.getName(),orderVO.getNum(),orderVO.getTotalPrice(),orderVO.getPayStatus(),orderVO.getPicture(),spu,sku,user);
    }
    /**
     * 删除订单（取消未支付订单）
     * @param orderId 要删除的订单id
     */
    public void cancelOrder(long orderId){
//        orderDao.deleteById(orderId);
        Order order = orderDao.getOne(orderId);
        order.setPayStatus("canceled");
        uploadOrder(order);
    }
    /**
     * 前端支付未支付订单，后端更新支付状态
     * @param orderId 被支付的订单id
     */
    public void payOrder(long orderId){
        Order order = orderDao.getOne(orderId);
        order.setPayStatus("paid");
        uploadOrder(order);
        //增加SPU销量
        SPU spu = order.getSPU();
        int sale = spu.getSales()+order.getNum();
        spu.setSales(sale);
        spuDao.save(spu);
    }

}
