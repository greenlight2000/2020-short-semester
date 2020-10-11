package com.webproject.project01.Servlet;

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
import java.util.List;

@Component
@WebServlet(urlPatterns = "/class/hierarchy")
public class ClassHrchServlet extends HttpServlet {
    @Autowired
    private ClassService classService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long classId = Long.parseLong(req.getParameter("classId"));
        List<Classification> ancestorClassList = classService.showAncestorClass(classId);
        List<ClassificationVO> ancestorClassVoList = classService.buildVoList(ancestorClassList);
        HttpSession session = req.getSession();
        session.setAttribute("ancestorClassVoList",ancestorClassVoList);

        List<Classification> childClassList = classService.showChildClass(classId);
        List<ClassificationVO> childClassVoList = classService.buildVoList(childClassList);
        session.setAttribute("childClassVoList",childClassVoList);

    }
}
