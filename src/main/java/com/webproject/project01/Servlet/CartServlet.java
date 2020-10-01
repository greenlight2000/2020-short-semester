package com.webproject.project01.Servlet;

import com.webproject.project01.PO.Cart;
import com.webproject.project01.Service.CartService;
import com.webproject.project01.VO.CartVO;
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
import java.util.ArrayList;
import java.util.List;

@Component
@WebServlet(urlPatterns = "/cart/get")
public class CartServlet extends HttpServlet {
    @Autowired
    private CartService cartService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    //根据userId读取cart
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if(session.getAttribute("userId")==null){
            session.setAttribute("cartVoList", new ArrayList<>());
        }else {
            long userId = Long.parseLong((String) session.getAttribute("userId"));//Long.parseLong(req.getParameter("userId"));
            List<Cart> cartList = cartService.getCartByUserId(userId);
            List<CartVO> cartVoList = cartService.buildCartVoList(cartList);

            session.setAttribute("cartVoList", cartVoList);
        }
//        resp.sendRedirect("/front-end/get-cart-test.jsp");
    }

    //添加cart
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
