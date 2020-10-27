package com.webproject.project01.Dao;

import com.webproject.project01.PO.Order;
import org.springframework.data.jpa.repository.Query;

public interface OrderDao extends BaseDao<Order> {
    @Query(value = "select sum(o.total_price) from ordering o where o.user_id=?1 and o.pay_status='paid' and (cast(NOW() as date)-cast(o.order_time as date))<?2",nativeQuery = true)
    double findDaysConsumption(long userId, int dayInterval);
    @Query(value = "select sum(o.totalPrice) from Order o where o.user.id=?1 and o.payStatus='paid'")
    double findTotalConsumption(long userId);
    @Query(value = "select sum(o.num) from ordering o where o.user_id=?1 and o.pay_status='paid' and (cast(NOW() as date)-cast(o.order_time as date))<?2",nativeQuery = true)
    int findDaysSkuNum(long userId, int daysInterval);
    @Query(value = "select sum(o.num) from Order o where o.user.id=?1 and o.payStatus='paid'")
    int findTotalSkuNum(long userId);
}
