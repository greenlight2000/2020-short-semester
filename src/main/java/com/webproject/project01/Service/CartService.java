package com.webproject.project01.Service;

import com.webproject.project01.Dao.*;
import com.webproject.project01.PO.*;
import com.webproject.project01.VO.CartVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class CartService extends BaseService<Cart>{
    @Autowired
    private CartDao cartDao;
    @Autowired
    private SPUDao spuDao;
    @Autowired
    private SKUDao skuDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private OrderDao orderDao;

    //根据 cart.user.id == userId 读取购物车
    public List<Cart> getCartByUserId(long userId){
        Specification<Cart> spec = new Specification<Cart>() {
            @Override
            public Predicate toPredicate(Root<Cart> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Predicate equal = criteriaBuilder.equal(root.get("user").get("id"),userId);
                return equal;            }
        };
        //把构造好的谓词放入接口 搜索
        List<Cart> list = cartDao.findAll(spec);
        return list;
    }
    //删除cart
    public void delCartById(long cartId){
        cartDao.deleteById(cartId);
    }

    //添加cart
    public void postNewCartVo(CartVO cartVO){
        Cart cart = buildOneCart(cartVO);
        cartDao.save(cart);
    }
    //修改数量
    public void changeCartNum(long cartId, int newNum){
        Cart cart = cartDao.getOne(cartId);
        cart.setTotalPrice(cart.getTotalPrice()*newNum/cart.getNum());
        cart.setNum(newNum);
        cartDao.save(cart);
    }
    //获取某用户当前购物车内所有商品的总价
    public double getTotCartPrice(long userId){
        User user = userDao.getOne(userId);
        List<Cart> cartList = user.getCartList();
        double totCartPrice = 0;
        for(Cart cart : cartList){
            totCartPrice += cart.getTotalPrice();
        }
        return totCartPrice;
    }
    //购物车上传到订单
    public String dumpCartToOrder(long userId, String payStatus){
        List<Cart> cartList = getCartByUserId(userId);

        String orderTime = getRealTime();
        for(Cart cart : cartList){
            //把cart里的数据dump进order
            Order order = new Order(orderTime,cart.getConfigSpecs(),cart.getAccessory(),cart.getName(),cart.getNum(),cart.getTotalPrice(),payStatus,cart.getPicture(),cart.getSKU().getSPU(),cart.getSKU(),cart.getUser());
            if(order.getSKU().getStockNum() < order.getNum()){
                return "the invention stock number of some products has changed, please modify your cart and try to checkout again";
            }
            orderDao.save(order);
            SKU sku = order.getSKU();
            SPU spu = order.getSKU().getSPU();
            switch (payStatus){
                case "paid":
                    int sale = spu.getSales()+order.getNum();//增加SPU销量
                    spu.setSales(sale);
                    spuDao.save(spu);
                case "unpaid":
                    int stockNum = order.getSKU().getStockNum() - order.getNum();
                    sku.setStockNum(stockNum);
                    skuDao.save(sku);
                    break;
                case "canceled":
                    stockNum = order.getSKU().getStockNum() + order.getNum();
                    sku.setStockNum(stockNum);
                    skuDao.save(sku);
                    break;
            }
            //删除cart
            delCartById(cart.getId());
        }
        return "successful checkout";
    }

    private String getRealTime(){
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String orderTime = df.format(date);
        return orderTime;
    }

    /*
        vo-po转换
     */
    public List<CartVO> buildCartVoList(List<Cart> cartList){
        List<CartVO> cartVoList = new ArrayList<>();
        for(Cart cart : cartList){
            CartVO cartVO = buildOneCartVo(cart);
            cartVoList.add(cartVO);
        }

        return cartVoList;
    }
    public CartVO buildOneCartVo(Cart cart){
        CartVO cartVo = new CartVO(cart.getId(),cart.getConfigSpecs(),cart.getAccessory(),cart.getName(),cart.getPicture(),cart.getNum(),cart.getTotalPrice(),cart.getSPU().getId(),cart.getSKU().getId(),cart.getUser().getId());
        return cartVo;
    }
    public Cart buildOneCart(CartVO cartVo){
        Cart cart = new Cart(cartVo.getId(),cartVo.getConfigSpecs(),cartVo.getAccessory(),cartVo.getName(),cartVo.getPicture(),cartVo.getNum(),cartVo.getTotalPrice());
        User user = userDao.getOne(cartVo.getUserId());
        SKU sku = skuDao.getOne(cartVo.getSkuId());
        SPU spu = sku.getSPU();
        cart.setUser(user);
        cart.setSPU(spu);
        cart.setSKU(sku);

        return cart;
    }

}
