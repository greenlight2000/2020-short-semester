package com.webproject.project01.Servlet;

import com.webproject.project01.Dao.SPUDao;
import com.webproject.project01.PO.SKU;
import com.webproject.project01.Service.SKUService;
import com.webproject.project01.Service.SPUService;
import com.webproject.project01.VO.SKUVO;
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
import java.io.PrintWriter;
import java.util.List;

/**
 * 根据spuId获取该spu所有sku信息
 */
@Component
@WebServlet(urlPatterns = "/detail")
public class SPUDetailServlet extends HttpServlet {
    @Autowired
    private SKUService skuService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        long spuId = Long.parseLong(req.getParameter("spuId"));
        List<SKU> skuList = skuService.getSkuListBySpu(spuId);
        List<SKUVO> skuVoList = skuService.buildVoList(skuList);
        session.setAttribute("skuVoList",skuVoList);
        System.out.println(spuId);
        System.out.println(skuVoList);
        System.out.println("I'm here");

//        PrintWriter out = resp.getWriter();
//        out.print("here");
//        out.write("here2");
//        out.print(skuVoList);
//        resp.sendRedirect("/DetailSPU.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
