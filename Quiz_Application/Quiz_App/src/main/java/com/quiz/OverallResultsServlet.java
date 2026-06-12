package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.quiz.model.OverallResult;

@WebServlet("/OverallResultsServlet")
public class OverallResultsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = session.getAttribute("user").toString();
        String quizIdParam = request.getParameter("quizId");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println("Database connection failed");
                return;
            }

            // ==========================================
            // ✅ CASE 1: SINGLE QUIZ RESULT
            // ==========================================
            if (quizIdParam != null) {

                int quizId = Integer.parseInt(quizIdParam);

                String sql =
                    "SELECT q.subject_name, q.topic_name, r.total_marks, r.score " +
                    "FROM quiz_results r " +
                    "JOIN quizzes q ON r.quiz_id = q.quiz_id " +
                    "WHERE r.quiz_id = ? AND r.username = ?";

                ps = con.prepareStatement(sql);
                ps.setInt(1, quizId);
                ps.setString(2, username);

                rs = ps.executeQuery();

                if (rs.next()) {

                    int score = rs.getInt("score");
                    int totalMarks = rs.getInt("total_marks");
                    double percentage = (score * 100.0) / totalMarks;

                    String subjectName = rs.getString("subject_name");
                    String topicName = rs.getString("topic_name");

                    // ✅ SEND TO result.jsp
                    request.setAttribute("score", score);
                    request.setAttribute("totalMarks", totalMarks);
                    request.setAttribute("percentage", percentage);
                    request.setAttribute("subjectName", subjectName);
                    request.setAttribute("topicName", topicName);
                }

                RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
                rd.forward(request, response);
                return;
            }

            // ==========================================
            // ✅ CASE 2: OVERALL RESULTS
            // ==========================================

            ArrayList<OverallResult> resultList = new ArrayList<>();
            int totalQuizzesAttempted = 0;
            double averageScore = 0.0;
            int bestScore = 0;
            int totalScoreSum = 0;

            String sql =
                "SELECT q.subject_name, q.topic_name, q.quiz_title, " +
                "DATE(r.submitted_at) AS quiz_date, " +
                "r.total_marks, r.score, r.percentage, r.status " +
                "FROM quiz_results r " +
                "JOIN quizzes q ON r.quiz_id = q.quiz_id " +
                "WHERE r.username = ? " +
                "ORDER BY r.submitted_at DESC";

            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();

            while (rs.next()) {
                OverallResult result = new OverallResult();

                result.setSubjectName(rs.getString("subject_name"));
                result.setTopicName(rs.getString("topic_name"));
                result.setQuizTitle(rs.getString("quiz_title"));
                result.setQuizDate(rs.getString("quiz_date"));
                result.setTotalMarks(rs.getInt("total_marks"));
                result.setMarksObtained(rs.getInt("score"));
                result.setPercentage(rs.getDouble("percentage"));
                result.setStatus(rs.getString("status"));

                resultList.add(result);

                totalQuizzesAttempted++;
                totalScoreSum += rs.getInt("score");

                if (rs.getInt("score") > bestScore) {
                    bestScore = rs.getInt("score");
                }
            }

            if (totalQuizzesAttempted > 0) {
                averageScore = (double) totalScoreSum / totalQuizzesAttempted;
            }

            // ✅ SEND TO overall-result.jsp
            request.setAttribute("resultList", resultList);
            request.setAttribute("totalQuizzesAttempted", totalQuizzesAttempted);
            request.setAttribute("averageScore", averageScore);
            request.setAttribute("bestScore", bestScore);

            RequestDispatcher rd = request.getRequestDispatcher("overall-result.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}