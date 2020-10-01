package com.webproject.project01.Servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.webproject.project01.PO.Classification;
import com.webproject.project01.PO.SPU;
import com.webproject.project01.Service.ClassService;
import com.webproject.project01.Service.SPUService;
import com.webproject.project01.VO.ClassificationVO;
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
@WebServlet(urlPatterns = "/class/child")
public class ClassChildServlet extends HttpServlet {
    @Autowired
    private ClassService classService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }
    //获取该classification下的所有子分类
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        List<Classification> classList = classService.showChildClass(id);
        List<ClassificationVO> classVoList = classService.buildVoList(classList);

        Gson gson = new Gson();
        Type type = new TypeToken<List<ClassificationVO>>(){}.getType();
        String classVoJson = gson.toJson(classVoList,type);
//        System.out.println(spuVoJson);
        PrintWriter out = resp.getWriter();
        out.print(classVoJson);
        out.close();

    }
}
