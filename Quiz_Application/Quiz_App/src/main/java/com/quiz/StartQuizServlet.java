package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.quiz.model.Question;

@WebServlet("/StartQuizServlet")
public class StartQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ✅ Session check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = session.getAttribute("user").toString();
        String quizIdParam = request.getParameter("quizId");

        if (quizIdParam == null || quizIdParam.trim().isEmpty()) {
            response.getWriter().println("Quiz ID is missing");
            return;
        }

        int quizId = Integer.parseInt(quizIdParam);

        ArrayList<Question> questionList = new ArrayList<>();
        int durationMinutes = 30;

        Connection con = null;
        PreparedStatement quizPs = null;
        PreparedStatement ps = null;
        ResultSet quizRs = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println("Database connection failed");
                return;
            }

            // ================================
            // ✅ FIXED QUERY (NO quiz_schedule)
            // ================================
            String quizSql =
                    "SELECT duration_minutes FROM quizzes WHERE quiz_id = ?";

            quizPs = con.prepareStatement(quizSql);
            quizPs.setInt(1, quizId);
            quizRs = quizPs.executeQuery();

            if (!quizRs.next()) {
                response.getWriter().println("Quiz not found in database");
                return;
            }

            durationMinutes = quizRs.getInt("duration_minutes");

            // ================================
            // OPTIONAL TIME CONTROL (simple)
            // ================================
            LocalDateTime now = LocalDateTime.now();

            // You can enable later scheduling logic if needed

            // ================================
            // FETCH QUESTIONS
            // ================================
            String questionSql =
                    "SELECT q.question_id, q.question, q.option1, q.option2, q.option3, q.option4, q.correct_option " +
                    "FROM questions q " +
                    "INNER JOIN quiz_questions qq ON q.question_id = qq.question_id " +
                    "WHERE qq.quiz_id = ? " +
                    "ORDER BY qq.question_id ASC";

            ps = con.prepareStatement(questionSql);
            ps.setInt(1, quizId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setQuestionId(rs.getInt("question_id"));
                q.setQuestionText(rs.getString("question"));
                q.setOption1(rs.getString("option1"));
                q.setOption2(rs.getString("option2"));
                q.setOption3(rs.getString("option3"));
                q.setOption4(rs.getString("option4"));
                q.setCorrectOption(String.valueOf(rs.getInt("correct_option")));

                questionList.add(q);
            }

            // ❌ No questions found check
            if (questionList.isEmpty()) {
                response.getWriter().println("No questions found for this quiz");
                return;
            }

            // ================================
            // SEND TO JSP
            // ================================
            request.setAttribute("quizId", quizId);
            request.setAttribute("durationMinutes", durationMinutes);
            request.setAttribute("questionList", questionList);

            RequestDispatcher rd = request.getRequestDispatcher("quiz.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error starting quiz: " + e.getMessage());
        } finally {
            try { if (quizRs != null) quizRs.close(); } catch (Exception e) {}
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (quizPs != null) quizPs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}