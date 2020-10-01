package com.webproject.project01.Servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.webproject.project01.Dao.SPUDao;
import com.webproject.project01.PO.Accessory;
import com.webproject.project01.Service.AccessoryService;
import com.webproject.project01.Service.SKUService;
import com.webproject.project01.VO.AccessoryVO;
import com.webproject.project01.VO.ClassificationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
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
@WebServlet(urlPatterns = "/accessory")
public class AccessoryServlet extends HttpServlet {
    @Autowired
    private AccessoryService accessoryService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    //查找该store中的所有accessory信息
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Accessory> accessoryList =  accessoryService.showAccessory();
        List<AccessoryVO> accessoryVoList = accessoryService.buildVoList(accessoryList);

        req.getSession().setAttribute("accessoryVoList",accessoryVoList);
        System.out.println("hello");

//        Gson gson = new Gson();
//        Type type = new TypeToken<List<AccessoryVO>>(){}.getType();
//        String accessoryVoJson = gson.toJson(accessoryVoList,type);
//        PrintWriter out = resp.getWriter();
//        out.print(accessoryVoJson);
//        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
