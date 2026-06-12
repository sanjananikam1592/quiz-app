package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int topicId = Integer.parseInt(request.getParameter("topicId"));
            String question = request.getParameter("question");

            String option1 = request.getParameter("optionA");
            String option2 = request.getParameter("optionB");
            String option3 = request.getParameter("optionC");
            String option4 = request.getParameter("optionD");

            String correct = request.getParameter("correctAnswer");

            // ✅ Convert A/B/C/D → 1/2/3/4
            int correctOption = 0;

            if (correct.equalsIgnoreCase("A")) correctOption = 1;
            else if (correct.equalsIgnoreCase("B")) correctOption = 2;
            else if (correct.equalsIgnoreCase("C")) correctOption = 3;
            else if (correct.equalsIgnoreCase("D")) correctOption = 4;

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO questions (topic_id, question, option1, option2, option3, option4, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, topicId);
            ps.setString(2, question);
            ps.setString(3, option1);
            ps.setString(4, option2);
            ps.setString(5, option3);
            ps.setString(6, option4);
            ps.setInt(7, correctOption);

            int row = ps.executeUpdate();

            if (row > 0) {
                response.sendRedirect("addQuestion.jsp?success=1");
            } else {
                response.sendRedirect("addQuestion.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addQuestion.jsp?error=1");
        }
    }
}