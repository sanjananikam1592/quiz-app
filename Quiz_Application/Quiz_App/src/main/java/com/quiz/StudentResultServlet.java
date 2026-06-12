package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/StudentResultServlet")
public class StudentResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("userId");
        ArrayList<HashMap<String, String>> resultList = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println("Database connection failed");
                return;
            }
            
            String sql = "SELECT q.quiz_title, sr.score, sr.total_marks, sr.submitted_at "
                       + "FROM student_results sr "
                       + "JOIN quizzes q ON sr.quiz_id = q.quiz_id "
                       + "WHERE sr.student_id = ? "
                       + "ORDER BY sr.submitted_at DESC";

            ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);

            rs = ps.executeQuery();

            while (rs.next()) {
                HashMap<String, String> map = new HashMap<>();
                map.put("quizTitle", rs.getString("quiz_title"));
                map.put("score", rs.getString("score"));
                map.put("totalMarks", rs.getString("total_marks"));
                map.put("submittedAt", rs.getString("submitted_at"));
                resultList.add(map);
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("studentResult.jsp");
            request.setAttribute("resultList", resultList);
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