//package com.quiz;
//
//import java.io.IOException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//@WebServlet("/AdminLoginServlet")
//public class AdminLoginServlet extends HttpServlet {
//
//    protected void doPost(HttpServletRequest req, HttpServletResponse res)
//            throws ServletException, IOException {
//
//        res.setContentType("text/html");
//
//        // Get form data
//        String username = req.getParameter("username");
//        String password = req.getParameter("password");
//
//        System.out.println("Admin Login Attempt: " + username);
//
//        // Null check (IMPORTANT)
//        if (username == null || password == null) {
//            res.sendRedirect(req.getContextPath() + "/adminLogin.jsp?error=1");
//            return;
//        }
//
//        username = username.trim();
//        password = password.trim();
//
//        // LOGIN CHECK (STATIC - you can replace with DB later)
//        if (username.equals("admin") && password.equals("admin123")) {
//
//            // Create session
//            HttpSession session = req.getSession();
//            session.setAttribute("admin", username);
//            session.setAttribute("role", "admin");
//
//            // Redirect to dashboard
//            res.sendRedirect(req.getContextPath() + "/adminDashboard.jsp");
//            return;
//
//        } else {
//            // Back to login with error
//            res.sendRedirect(req.getContextPath() + "/adminLogin.jsp?error=1");
//        }
//    }
//
//    // Optional: prevent 405 error
//    protected void doGet(HttpServletRequest req, HttpServletResponse res)
//            throws IOException {
//
//        res.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
//    }
//}