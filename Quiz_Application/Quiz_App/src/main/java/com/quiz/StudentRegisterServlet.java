package com.quiz;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/StudentRegisterServlet")
public class StudentRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("name");   // you used name
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            // Check if user exists
            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM users WHERE username=?"
            );
            check.setString(1, username);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                response.sendRedirect("studentRegister.jsp?error=exists");
                return;
            }

            // Insert as STUDENT
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(username, password, role) VALUES (?, ?, ?)"
            );

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, "student");

            int row = ps.executeUpdate();

            if (row > 0) {
                response.sendRedirect("login.jsp?registered=1");
            } else {
                response.sendRedirect("studentRegister.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("studentRegister.jsp?error=1");
        }
    }
}