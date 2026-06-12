package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SubmitQuizServlet")
public class SubmitQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");

            return;
        }

        String username = session.getAttribute("user").toString();
        String quizIdStr = request.getParameter("quizId");

        if (quizIdStr == null || quizIdStr.trim().isEmpty()) {
            response.getWriter().println("Quiz ID is missing");
            return;
        }

        int quizId = Integer.parseInt(quizIdStr);

        int totalQuestions = 0;
        int correctAnswers = 0;
        int wrongAnswers = 0;
        int score = 0;
        double percentage = 0.0;

        String subjectName = "";
        String topicName = "";

        Connection con = null;
        PreparedStatement psQuestions = null;
        PreparedStatement psQuizInfo = null;
        PreparedStatement psInsertResult = null;
        ResultSet rsQuestions = null;
        ResultSet rsQuizInfo = null;

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                response.getWriter().println("Database connection failed");
                return;
            }

            String questionSql =
                    "SELECT q.question_id, q.correct_option " +
                    "FROM quiz_questions qq " +
                    "JOIN questions q ON qq.question_id = q.question_id " +
                    "WHERE qq.quiz_id=?";

            psQuestions = con.prepareStatement(questionSql);
            psQuestions.setInt(1, quizId);
            rsQuestions = psQuestions.executeQuery();

            while (rsQuestions.next()) {
                totalQuestions++;

                int questionId = rsQuestions.getInt("question_id");
                String correctOption = rsQuestions.getString("correct_option");
                String selectedAnswer = request.getParameter("answer_" + questionId);

                if (selectedAnswer != null && selectedAnswer.equals(correctOption)) {
                    correctAnswers++;
                }
            }

            wrongAnswers = totalQuestions - correctAnswers;
            score = correctAnswers;

            if (totalQuestions > 0) {
                percentage = (score * 100.0) / totalQuestions;
            }

            String quizInfoSql =
                    "SELECT s.subject_name, t.topic_name " +
                    "FROM quizzes q " +
                    "JOIN subjects s ON q.subject_id = s.subject_id " +
                    "JOIN topics t ON q.topic_id = t.topic_id " +
                    "WHERE q.quiz_id = ?";

            psQuizInfo = con.prepareStatement(quizInfoSql);
            psQuizInfo.setInt(1, quizId);
            rsQuizInfo = psQuizInfo.executeQuery();

            if (rsQuizInfo.next()) {
                subjectName = rsQuizInfo.getString("subject_name");
                topicName = rsQuizInfo.getString("topic_name");
            }

            String insertSql =
                    "INSERT INTO quiz_results (username, quiz_id, score, total_marks, percentage, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            psInsertResult = con.prepareStatement(insertSql);
            psInsertResult.setString(1, username);
            psInsertResult.setInt(2, quizId);
            psInsertResult.setInt(3, score);
            psInsertResult.setInt(4, totalQuestions);
            psInsertResult.setDouble(5, percentage);
            psInsertResult.setString(6, "Completed");
            psInsertResult.executeUpdate();

            request.setAttribute("totalQuestions", totalQuestions);
            request.setAttribute("correctAnswers", correctAnswers);
            request.setAttribute("wrongAnswers", wrongAnswers);
            request.setAttribute("score", score);

            request.setAttribute("totalMarks", totalQuestions);
            request.setAttribute("percentage", percentage);
            request.setAttribute("subjectName", subjectName);
            request.setAttribute("topicName", topicName);

            RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
            rd.forward(request, response);
             
            String missedSql =
            	    "INSERT INTO quiz_results (username, quiz_id, score, total_marks, percentage, status) " +
            	    "SELECT ?, ?, 0, q.total_marks, 0, 'Missed' " +
            	    "FROM quizzes q " +
            	    "WHERE q.quiz_id = ? " +
            	    "AND NOT EXISTS (" +
            	    "   SELECT 1 FROM quiz_results qr WHERE qr.username = ? AND qr.quiz_id = ?" +
            	    ")";
            
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid quiz ID");
      
        } catch (Exception e) {  
            e.printStackTrace();
            response.getWriter().println("Error while submitting quiz: " + e.getMessage());
        } finally {
            try { if (rsQuestions != null) rsQuestions.close(); } catch (Exception e) {}
            try { if (rsQuizInfo != null) rsQuizInfo.close(); } catch (Exception e) {}
            try { if (psQuestions != null) psQuestions.close(); } catch (Exception e) {}
            try { if (psQuizInfo != null) psQuizInfo.close(); } catch (Exception e) {}
            try { if (psInsertResult != null) psInsertResult.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}