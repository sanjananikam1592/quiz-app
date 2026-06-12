package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ScheduleQuizServlet")
public class ScheduleQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	HttpSession session = request.getSession(false);
    	if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
    	    return;
    	}

    	String role = (String) session.getAttribute("role");
    	if (role == null || !role.equalsIgnoreCase("admin")) {
            response.sendRedirect("overall-result.jsp");
    	    return;
    	}
    	
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        String scheduleDate = request.getParameter("scheduleDate");
        String startTime = request.getParameter("startTime");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
        
            if (con == null) {
                response.getWriter().println("Database connection failed");
                return;
            }
            
            String sql = "INSERT INTO quiz_schedule(quiz_id, schedule_date, start_time) VALUES(?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, quizId);
            ps.setString(2, scheduleDate);
            ps.setString(3, startTime);

            int row = ps.executeUpdate();

            if (row > 0) {
                response.sendRedirect("overall-result.jsp?success=1");
            } else {
                response.sendRedirect("overall-result.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("overall-result.jsp?error=1");
            
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}