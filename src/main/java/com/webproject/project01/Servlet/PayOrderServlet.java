package com.webproject.project01.Servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.webproject.project01.Service.OrderService;
import com.webproject.project01.VO.OrderVO;
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
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Component
@WebServlet(urlPatterns = "/payOrder")
public class PayOrderServlet extends HttpServlet {
    @Autowired
    private OrderService orderService;
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext application = this.getServletContext();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, config.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        orderService.payOrder(id);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        if(method==null)
            method="updateOne";
        //流读取post数据，提取成字符串str
        BufferedReader br = new BufferedReader(new InputStreamReader(req.getInputStream(), StandardCharsets.UTF_8));
        StringBuffer sb = new StringBuffer("");
        String temp;
        while ((temp = br.readLine()) != null) {
            sb.append(temp);
        }
        br.close();
        String param = sb.toString();
        System.out.println(param);

        Gson gson = new Gson();
        if(method.equals("updateOne")){//上传一条order
            OrderVO orderVo = gson.fromJson(param,OrderVO.class);
            orderService.uploadOrder(orderService.buildOrder(orderVo));
        }else if(method.equals("uploadAll")){//上传多条order
            Type type = new TypeToken<List<OrderVO>>(){}.getType();
            List<OrderVO> orderVoList = gson.fromJson(param,type);
            orderService.uploadOrderList(orderVoList);
        }

        PrintWriter out = resp.getWriter();
        out.print("success");

    }
}
