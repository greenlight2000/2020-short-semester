package com.webproject.project01.Servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.Service.SPUService;
import com.webproject.project01.Utils.UtilVar;
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
import java.util.ArrayList;
import java.util.List;

@Component
@WebServlet(urlPatterns = "/SPU/load")
public class SPULoadServlet extends HttpServlet {
    @Autowired
    private SPUService spuService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String key = req.getParameter("key")==null?"name":req.getParameter("key");//默认搜name
        String value = req.getParameter("value")==null?"":req.getParameter("value");//默认搜空
        boolean isFuzzy = Boolean.parseBoolean(req.getParameter("isFuzzy")==null?"true":req.getParameter("isFuzzy"));//默认模糊搜索
        String sortKey = req.getParameter("sortKey")==null?"id":req.getParameter("sortKey");//默认排id
        boolean sortAsc = Boolean.parseBoolean(req.getParameter("sortAsc")==null?"false":req.getParameter("sortAsc"));//默认升序
        boolean usePage = Boolean.parseBoolean(req.getParameter("usePage")==null?"true":req.getParameter("usePage"));//默认分页

        int pageSize = Integer.parseInt(req.getParameter("pageSize")==null?String.valueOf(UtilVar.spuHomePageSize):req.getParameter("pageSize"));//默认9条数据一页
        int pageNum = Integer.parseInt(req.getParameter("pageNum")==null?String.valueOf(1):req.getParameter("pageNum"));//默认第一页
        Page<SPU> spuPage = spuService.searchSpuByStoreAndKeyWithPage(UtilVar.storeId,key,value,isFuzzy,spuService.makePage(pageNum,pageSize,spuService.makeSort(sortKey,sortAsc)));
        List<SPU> spuList = spuPage.getContent();
        List<SPUVO> spuVoList = new ArrayList<>();
        for(SPU spu : spuList){
            spuVoList.add(spu.toVO());
        }

        Type type = new TypeToken<List<SPUVO>>(){}.getType();
        Gson gson = new Gson();
        String str = gson.toJson(spuVoList,type);
        resp.setContentType("text/text;charset=utf-8");
        PrintWriter out = resp.getWriter();
        out.print(str);
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
