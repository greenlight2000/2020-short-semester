package com.webproject.project01.Servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.Service.ClassService;
import com.webproject.project01.Service.SPUService;
import com.webproject.project01.VO.SPUVO;
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
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.List;

@Component
@WebServlet(urlPatterns = "/class/spu")
public class ClassSpuServlet extends HttpServlet {
    @Autowired
    private ClassService classService;
    @Autowired
    private SPUService spuService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }
    //获取该class下的所有spu
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long classId = Long.parseLong(req.getParameter("id"));
        List<SPU> spuList = classService.showSPU(classId);
        List<SPUVO> spuVoList = spuService.buildVoList(spuList);
        for(SPUVO spuVo : spuVoList){
            System.out.println(spuVo.toString());
        }
        Gson gson = new Gson();
//        Type type = new TypeToken<List<SPU>>(){}.getType();
//        String spuVoJson = gson.toJson(spuVoList,type);
//        System.out.println(spuVoJson);
        PrintWriter out = resp.getWriter();
        for(SPUVO spuvo : spuVoList){
            out.println(gson.toJson(spuvo,SPUVO.class)+"\n");
        }
        out.close();

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
