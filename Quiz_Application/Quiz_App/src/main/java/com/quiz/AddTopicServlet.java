package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddTopicServlet")
public class AddTopicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ✅ Session check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        // ✅ Admin check
        if (role == null || !role.equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp"); // fixed
            return;
        }

        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        String topicName = request.getParameter("topicName");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            String sql = "INSERT INTO topics(subject_id, topic_name) VALUES(?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, subjectId);
            ps.setString(2, topicName);

            int row = ps.executeUpdate();

            // ✅ Correct handling
            if (row > 0) {
                response.sendRedirect("addTopic.jsp?success=1");
            } else {
                response.sendRedirect("addTopic.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addTopic.jsp?error=1"); // fixed
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}