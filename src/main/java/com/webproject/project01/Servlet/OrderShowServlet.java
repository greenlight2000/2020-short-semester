package com.webproject.project01.Servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.webproject.project01.Dao.UserDao;
import com.webproject.project01.PO.Order;
import com.webproject.project01.Service.OrderService;
import com.webproject.project01.Utils.UtilVar;
import com.webproject.project01.VO.OrderVO;
import com.webproject.project01.VO.SPUVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.List;

@Component
@WebServlet(urlPatterns = "/showOrder")
public class OrderShowServlet extends HttpServlet {
    @Autowired
    private OrderService orderService;
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    //根据sortKey，sortAsc排序，查找payStatus的 orderVoList
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sortKey = req.getParameter("sortKey")==null?"orderTime":req.getParameter("sortKey");
        boolean sortAsc = Boolean.parseBoolean(req.getParameter("sortAsc")==null?"false":req.getParameter("sortAsc"));
        long userId = Long.parseLong(req.getSession().getAttribute("userId")==null?"0":(String)req.getSession().getAttribute("userId"));
        int pageNum = Integer.parseInt(req.getParameter("pageNum")==null?"1":req.getParameter("pageNum"));

        String payStatus = req.getParameter("payStatus");
        //排序查询
//        List<Order> orderList = orderService.getOrderWithSort(userId, orderService.makeSort(sortKey,sortAsc));
        //分页查询
//        Page<Order> orderPage = orderService.getOrderWithPage(userId,orderService.makePage(pageNum, UtilVar.orderPageSize, orderService.makeSort(sortKey,sortAsc)));
        Page<Order> orderPage = orderService.getOrderWithPage(userId, orderService.makePage(1,100,orderService.makeSort(sortKey,sortAsc)),payStatus);
        List<Order> orderList = orderPage.getContent();
        //转vo
        List<OrderVO> orderVoList = orderService.buildOrderVoList(orderList,payStatus);
        //放入session
        req.getSession().setAttribute("orderVoList",orderVoList);

//        resp.sendRedirect("orderPage.jsp");
//        PrintWriter out = resp.getWriter();
//        Gson gson = new Gson();
//        Type type = new TypeToken<List<OrderVO>>(){}.getType();
//        String str = gson.toJson(orderVoList,type);
//        System.out.println(str);
//        out.print(str);

//        for(OrderVO orderVO : orderVoList){
//            out.println(gson.toJson(orderVO,OrderVO.class)+"\n");
//        }
//        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
