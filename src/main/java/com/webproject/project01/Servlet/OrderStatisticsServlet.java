package com.webproject.project01.Servlet;

import com.webproject.project01.Service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
@WebServlet(urlPatterns = "/order/statistics")
public class OrderStatisticsServlet extends HttpServlet {
    @Autowired
    private OrderService orderService;
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long userId = Long.parseLong(req.getParameter("userId"));
        System.out.println(orderService.totalConsumption(userId));
        System.out.println(orderService.monthConsumption(userId));
        System.out.println(orderService.monthSpuNum(userId));
        HttpSession session = req.getSession();
        session.setAttribute("totalConsumption",orderService.totalConsumption(userId));
        session.setAttribute("monthConsumption",orderService.monthConsumption(userId));
        session.setAttribute("monthSpuNum",orderService.monthSpuNum(userId));
        session.setAttribute("totalSpuNum",orderService.totalSkuNum(userId));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
