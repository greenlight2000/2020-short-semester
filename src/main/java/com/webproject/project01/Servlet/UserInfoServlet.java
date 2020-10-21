package com.webproject.project01.Servlet;

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
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
@WebServlet(urlPatterns = "/user/info")
public class UserInfoServlet extends HttpServlet {
    @Autowired
    private UserService userService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        long userId = Long.parseLong(req.getParameter("userId"));
        UserVO userVO = userService.getUserInfo(userId);
        String email = userVO.getEmail();
        String phone = userVO.getPhone();
        String userName = userVO.getName();
        HttpSession session = req.getSession();
        session.setAttribute("email", email);
        session.setAttribute("phone", phone);
        session.setAttribute("userName", userName);
    }
}
