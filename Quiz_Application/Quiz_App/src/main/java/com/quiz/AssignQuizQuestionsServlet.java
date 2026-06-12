package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AssignQuizQuestionsServlet")
public class AssignQuizQuestionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int quizId = Integer.parseInt(request.getParameter("quizId"));

        Connection con = null;
        PreparedStatement psQuiz = null;
        PreparedStatement psInsert = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            String quizSql = "SELECT subject_id, topic_id FROM quizzes WHERE quiz_id=?";
            psQuiz = con.prepareStatement(quizSql);
            psQuiz.setInt(1, quizId);
            rs = psQuiz.executeQuery();

            int subjectId = 0;
            int topicId = 0;

            if (rs.next()) {
                subjectId = rs.getInt("subject_id");
                topicId = rs.getInt("topic_id");
            } else {
                response.sendRedirect("Overall-result.jsp?error=1");

                return;
            }

            PreparedStatement psDelete = con.prepareStatement("DELETE FROM quiz_questions WHERE quiz_id=?");
            psDelete.setInt(1, quizId);
            psDelete.executeUpdate();
            psDelete.close();

            PreparedStatement psQuestions = con.prepareStatement(
                "SELECT question_id FROM questions WHERE subject_id=? AND topic_id=?"
            );
            psQuestions.setInt(1, subjectId);
            psQuestions.setInt(2, topicId);

            ResultSet rsQuestions = psQuestions.executeQuery();

            String insertSql = "INSERT INTO quiz_questions(quiz_id, question_id) VALUES(?,?)";
            psInsert = con.prepareStatement(insertSql);

            while (rsQuestions.next()) {
                psInsert.setInt(1, quizId);
                psInsert.setInt(2, rsQuestions.getInt("question_id"));
                psInsert.addBatch();
            }

            psInsert.executeBatch();

            rsQuestions.close();
            psQuestions.close();

            boolean hasQuestions = false;
			if (hasQuestions) {
                psInsert.executeBatch();
                response.sendRedirect("Overall-result.jsp?assigned=1");
            } else {
                response.sendRedirect("Overall-result.jsp?error=1");
            }


        } catch (Exception e) {
            e.printStackTrace();
           response.sendRedirect("Overall-result.jsp?error=1");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psQuiz != null) psQuiz.close(); } catch (Exception e) {}
            try { if (psInsert != null) psInsert.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}