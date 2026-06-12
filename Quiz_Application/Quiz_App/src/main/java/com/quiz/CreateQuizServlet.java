package com.quiz;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CreateQuizServlet")
public class CreateQuizServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null ||
            !session.getAttribute("role").toString().equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String quizTitle = request.getParameter("quizTitle");
        String subjectName = request.getParameter("subjectName");
        String topicName = request.getParameter("topicName");
        String scheduledDate = request.getParameter("scheduledDate");
        String scheduledTime = request.getParameter("scheduledTime");
        String durationStr = request.getParameter("durationMinutes");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            int duration = Integer.parseInt(durationStr);

            con = DBConnection.getConnection();

            if (con == null) {
                System.out.println("DB Connection Failed");
                response.sendRedirect("createQuiz.jsp?error=db");
                return;
            }

            // Example: total marks = 0 initially (you can update later)
            int totalMarks = 0;

            String sql = "INSERT INTO quizzes " +
                    "(quiz_title, subject_name, topic_name, scheduled_date, scheduled_time, duration_minutes, total_marks) " +
                    "VALUES (?,?,?,?,?,?,?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, quizTitle);
            ps.setString(2, subjectName);
            ps.setString(3, topicName);
            ps.setDate(4, Date.valueOf(scheduledDate));
            ps.setTime(5, Time.valueOf(scheduledTime + ":00"));
            ps.setInt(6, duration);
            ps.setInt(7, totalMarks);

            int result = ps.executeUpdate();

            if (result > 0) {
                System.out.println("Quiz Inserted Successfully");
                response.sendRedirect("createQuiz.jsp?success=1");
            } else {
                response.sendRedirect("createQuiz.jsp?error=insert");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("createQuiz.jsp?error=exception");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}