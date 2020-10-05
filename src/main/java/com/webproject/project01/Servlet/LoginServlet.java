package com.webproject.project01.Servlet;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.webproject.project01.Dao.UserDao;
import com.webproject.project01.PO.User;
import com.webproject.project01.Service.UserService;
import com.webproject.project01.VO.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Component
@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet{
    @Autowired
    private UserService userService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());

    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        //从jsp获取name，password数据
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        //从数据库查询
        List<User> userList = userService.searchUsers("name", name, false);

        if(userList.isEmpty()) {//如果没查到这个用户名
            PrintWriter out = res.getWriter();
            out.println("no such user");
            System.out.println("no such user");
            out.close();
        }else if(userList.get(0).getPassword().equals(password)){//如果用户名和密码都对了
            String preUrl = req.getParameter("preUrl").equals("null") ? "/front-end/index.jsp" :req.getParameter("preUrl");
            System.out.println("front end href to previous page "+preUrl);
            //返回信息
            PrintWriter out = res.getWriter();
            out.println("welcome, "+name+";"+preUrl);
            out.close();
            System.out.println("welcome, "+name);

            //将user.id存入cookie
            String id = String.valueOf(userList.get(0).getId());

            HttpSession session = req.getSession();
            session.setAttribute("userId",id);
            session.setAttribute("userName",name);

//            Cookie idCookie = new Cookie("userId",id);
//            Cookie nameCookie = new Cookie("userName",name);
//            Cookie pwdCookie = new Cookie("password", password);
//
//            idCookie.setMaxAge(86400);
//            nameCookie.setMaxAge(86400);
//            pwdCookie.setMaxAge(86400);
//
//            res.addCookie(idCookie);
//            res.addCookie(nameCookie);
//            res.addCookie(pwdCookie);
        }else{//如果用户名对了但是密码错了
            PrintWriter out = res.getWriter();
            out.println("invalid password");
            out.close();
            System.out.println("invalid password");
        }




    }
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        this.doGet(req, res);
//        res.sendRedirect("/welcome.jsp");
//        System.out.println("post");
//
//        User user = userDao.getOne(1L);
//        HttpSession session = req.getSession();
//        session.setAttribute("name",user.getName());
//
//        System.out.println(user.getName().equals("wyk"));
//        System.out.println(user.getName());

    }
}
