package com.webproject.project01.Servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.webproject.project01.PO.Classification;
import com.webproject.project01.Service.ClassService;
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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

@Component
@WebServlet(urlPatterns = "/class")
public class ClassServlet extends HttpServlet {
    @Autowired
    private ClassService classService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String param = req.getParameter("param");
        List<Classification> classList = new ArrayList<>();
        List<ClassificationVO> classVoList = new ArrayList<>();
        HttpSession session = req.getSession();
        switch (param) {
            case "root":
                classList = classService.showRootClass();
                classVoList = classService.buildVoList(classList);
                session.setAttribute("rootClassVoList",classVoList);
                break;
            case "leave":
                classList = classService.showLeaveClass();
                classVoList = classService.buildVoList(classList);
                session.setAttribute("leaveClassVoList",classVoList);
                break;
            case "child":
                long parentId = Long.parseLong(req.getParameter("id"));
                classList = classService.showChildClass(parentId);
                classVoList = classService.buildVoList(classList);
//                session.setAttribute("childClassVoList",classVoList);
                Gson gson = new Gson();
                Type type = new TypeToken<List<ClassificationVO>>(){}.getType();
                String str = gson.toJson(classVoList,type);
                PrintWriter out = resp.getWriter();
//                for(ClassificationVO classificationVo : classVoList){
//                    System.out.println(classificationVo.toString());
//                    out.println(classificationVo.toString());
//                }
//                System.out.println(parentId);
                System.out.println(str);
                out.println(str);
                out.close();
                break;
        }
//        PrintWriter out = resp.getWriter();
//        for(ClassificationVO classificationVo : classVoList){
//            System.out.println(classificationVo.toString());
//            out.println(classificationVo.toString());
//        }
//
//        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
