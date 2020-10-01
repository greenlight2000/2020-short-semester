package com.webproject.project01.Servlet;

import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

@Component
@WebServlet(urlPatterns = "/session/data")
public class SessionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        PrintWriter out = resp.getWriter();
        if(session.getAttributeNames().hasMoreElements())
            for (Enumeration<String> e = session.getAttributeNames(); e.hasMoreElements(); )
            {
                String attrName = e.nextElement();
                out.println(attrName+":"+session.getAttribute(attrName));
                out.println("\n");
            }
        out.close();
    }
}
