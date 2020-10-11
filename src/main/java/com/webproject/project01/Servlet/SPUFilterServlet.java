package com.webproject.project01.Servlet;

import com.webproject.project01.Dao.SPUDao;
import com.webproject.project01.PO.SPU;
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
import java.io.IOException;
import java.util.List;

@Component
@WebServlet(urlPatterns = "/spu/filter")
public class SPUFilterServlet extends HttpServlet {
    @Autowired
    SPUDao spuDao;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("max="+spuDao.findMaxSPUPrice());
        System.out.println("min="+spuDao.findMinSPUPrice());
        double min = Double.parseDouble(req.getParameter("min"));
        double max = Double.parseDouble(req.getParameter("max"));
        List<SPU> spuList = spuDao.findAllByPrice(min,max);
        System.out.println(spuList.size());
    }
}
