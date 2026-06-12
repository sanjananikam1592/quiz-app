package com.quiz;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.quiz.model.ScheduledQuiz;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("user");

        if (role == null || !role.equalsIgnoreCase("student")) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<ScheduledQuiz> quizList = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println("Database connection failed");
                return;
            }

            String sql = "SELECT * FROM quizzes ORDER BY scheduled_date, scheduled_time";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            Timestamp now = new Timestamp(System.currentTimeMillis());

            while (rs.next()) {

                ScheduledQuiz quiz = new ScheduledQuiz();

                quiz.setQuizId(rs.getInt("quiz_id"));
                quiz.setQuizTitle(rs.getString("quiz_title"));
                quiz.setSubject(rs.getString("subject_name"));
                quiz.setTopic(rs.getString("topic_name"));

                // Convert to String
                quiz.setQuizDate(rs.getDate("scheduled_date"));
                quiz.setQuizTime(rs.getTime("scheduled_time"));

                quiz.setDuration(rs.getInt("duration_minutes"));
                quiz.setTotalMarks(rs.getInt("total_marks"));

                // Time check
                Timestamp quizDateTime = Timestamp.valueOf(
                        rs.getDate("scheduled_date") + " " + rs.getTime("scheduled_time")
                );

                quiz.setCanStart(now.after(quizDateTime));

                quizList.add(quiz);
            }

            request.setAttribute("quizList", quizList);
            request.setAttribute("username", username);

            RequestDispatcher rd = request.getRequestDispatcher("studentDashboard.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}