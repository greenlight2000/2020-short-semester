package com.webproject.project01.Servlet;

import com.webproject.project01.Service.CartService;
import com.webproject.project01.VO.CartVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionException;
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
import java.io.PrintWriter;

@Component
@WebServlet(urlPatterns = "/cart/post")
public class CartPostServlet extends HttpServlet {
    @Autowired
    private CartService cartService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            String configSpecs = req.getParameter("configSpecs");
            String accessory = req.getParameter("accessory");
            String name = req.getParameter("name");
            String picture = req.getParameter("picture");
            int num = Integer.parseInt(req.getParameter("num"));
            double totalPrice = Double.parseDouble(req.getParameter("totalPrice"));
            long spuId = Long.parseLong(req.getParameter("spuId"));
            long userId = Long.parseLong(req.getParameter("userId"));

            CartVO cartVo = new CartVO(0,configSpecs,accessory,name,picture,num,totalPrice,spuId,userId);
            cartService.postNewCartVo(cartVo);
            PrintWriter out = resp.getWriter();
            out.println("successful adding to cart");
            out.close();
        }catch (ConversionException e1){
            System.out.println(e1);
            PrintWriter out = resp.getWriter();
            out.println("fail to post cart");
            out.close();
        }catch (NullPointerException e2){
            System.out.println(e2);
        }
//        resp.sendRedirect("/front-end/get-cart-test?userId=1");
    }
}
