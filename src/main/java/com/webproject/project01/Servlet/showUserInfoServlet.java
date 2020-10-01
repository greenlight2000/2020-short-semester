package com.webproject.project01.Servlet;

import com.google.gson.Gson;
import com.webproject.project01.Service.UserService;
import com.webproject.project01.VO.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Component
@WebServlet(urlPatterns = "/showUserInfo")
public class showUserInfoServlet extends HttpServlet {
    @Autowired
    private UserService userService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        PrintWriter out = resp.getWriter();
        out.println(new Gson().toJson(userService.getUserInfo(id), UserVO.class));
        out.close();
    }
}
