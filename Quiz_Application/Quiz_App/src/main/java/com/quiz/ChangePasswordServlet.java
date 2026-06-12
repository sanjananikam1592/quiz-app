package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
        	response.sendRedirect("login.jsp");
            return;
        }

        String username = session.getAttribute("user").toString();
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
        	response.sendRedirect("OverallResultsServlet?error=password_mismatch");
            return;
        }

        Connection con = null;
        PreparedStatement psCheck = null;
        PreparedStatement psUpdate = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            String checkSql = "SELECT * FROM users WHERE username=? AND password=?";
            psCheck = con.prepareStatement(checkSql);
            psCheck.setString(1, username);
            psCheck.setString(2, currentPassword);

            rs = psCheck.executeQuery();

            if (rs.next()) {
                String updateSql = "UPDATE users SET password=? WHERE username=?";
                psUpdate = con.prepareStatement(updateSql);
                psUpdate.setString(1, newPassword);
                psUpdate.setString(2, username);

                int updated = psUpdate.executeUpdate();
               
                if (updated > 0) {
                    response.sendRedirect("OverallResultsServlet?success=1");
                } else {
                    response.sendRedirect("OverallResultsServlet?error=1");
                }
        } else {
             response.sendRedirect("OverallResultsServlet?error=wrong_current_password");
        }
    

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psCheck != null) psCheck.close(); } catch (Exception e) {}
            try { if (psUpdate != null) psUpdate.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}