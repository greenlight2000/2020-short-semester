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
@WebServlet(urlPatterns = "/user/modify")
public class UserModifyServlet extends HttpServlet {
    @Autowired
    private UserService userService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }
    //mod1 修改password:
    //mod2 修改基本信息
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = "success";
        long userId = Long.parseLong(req.getParameter("userId"));
        String mod = req.getParameter("mod");
        if(mod.equals("password")){
            String oldPwd = req.getParameter("oldPwd");
            String newPwd = req.getParameter("newPwd");
            status = userService.updatePassword(userId,oldPwd,newPwd);
        }else if(mod.equals("information")){
            String changeInfo = req.getParameter("changeInfo");
            switch (changeInfo){
                case "email":
                    String email = req.getParameter("email");
                    status = userService.updateEmail(userId, email);
                    break;
                case "phone":
                    String phone = req.getParameter("phone");
                    status = userService.updatePhone(userId, phone);
                    break;
                case "name":
                    String name = req.getParameter("name");
                    status = userService.updateName(userId, name);
                    break;
            }
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
