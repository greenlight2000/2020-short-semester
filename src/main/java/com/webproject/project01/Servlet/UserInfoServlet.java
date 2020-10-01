package com.webproject.project01.Servlet;

import com.webproject.project01.PO.User;
import com.webproject.project01.Service.OrderService;
import com.webproject.project01.Service.UserService;
import com.webproject.project01.VO.UserVO;
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

@Component
@WebServlet(urlPatterns = "/userinfo")
public class UserInfoServlet extends HttpServlet {
    @Autowired
    private UserService userService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }
    //修改一项数据：/userinfo?id=1&email=123@123.com&newEmail=234@234.com
    //修改任意项数据(根据password修改,这里不能修改password,且url需要写changeOne=false) /userinfo?id=1&email=123@123.com&newEmail=234@234.com&password=123&changeOne=false
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = "success";
        long id = Long.parseLong(req.getParameter("id"));
        String newEmail = req.getParameter("newEmail");
        String newPhone = req.getParameter("newPhone");
        String newPassword = req.getParameter("newPassword");
        String password = req.getParameter("password");
        if(req.getParameter("changeOne").equals("false")){
            if(userService.checkPwValid(id,newPassword))
                status = userService.update(id,newEmail,newPhone,password);
            else
                status = "invalid password";
        }else{
            if (newEmail!=null)
                status = userService.updateEmail(id,req.getParameter("email"),newEmail);
            else if(newPhone!=null)
                status = userService.updatePhone(id,req.getParameter("phone"),newPhone);
            else if(newPassword!=null)
                status = userService.updatePassword(id,password,newPassword);
        }

        PrintWriter out = resp.getWriter();
        out.print(status);
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
