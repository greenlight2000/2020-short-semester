package com.webproject.project01.Servlet;

import com.webproject.project01.Dao.UserDao;
import com.webproject.project01.PO.Order;
import com.webproject.project01.PO.User;
import com.webproject.project01.Service.UserService;
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
import java.util.ArrayList;

@Component
@WebServlet(urlPatterns = "/register")//这个servlet映射到了/register，get或post请求访问/register会出发这个servlet
public class RegisterServlet extends HttpServlet {
    //上面这部分用来连数据库的，前端调试可以注释掉
    @Autowired
    private UserService userService;
//    @Autowired
//    private UserDao userDao;
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");

        if (name==null)
            System.out.println("name is null");
        if (email==null)
            System.out.println("email is null");
        if (phone==null)
            System.out.println("phone is null");
        if (password==null)
            System.out.println("password is null");

        PrintWriter out = resp.getWriter();
        if(!userService.validEmail(email)){
            out.println("invalid email format");
        } else if(!userService.validPhone(phone)){
            out.println("invalid phone format");
        } else if(userService.existedName(name)){
            out.println("this name has already been registered");
        } else if(userService.existedEmail(email)){
            out.println("this email has already been registered");
        } else if(userService.existedPhone(phone)){
            out.println("this phone has already been registered");
        } else{
            User user = new User(name,phone,email,password,new ArrayList<Order>());
            userService.upload(user);
            out.println("successful register");
        }
        out.close();

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
