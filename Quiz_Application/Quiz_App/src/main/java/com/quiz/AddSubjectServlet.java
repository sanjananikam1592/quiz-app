package com.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddSubjectServlet")
public class AddSubjectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String subjectName = request.getParameter("subjectName");

        if (subjectName == null || subjectName.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/addSubject.jsp?error=empty");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            if (con == null) {
                response.sendRedirect(request.getContextPath() + "/addSubject.jsp?error=1");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO subjects(subject_name) VALUES(?)"
            );

            ps.setString(1, subjectName);

            int row = ps.executeUpdate();

            if (row > 0) {
                response.sendRedirect(request.getContextPath() + "/addSubject.jsp?success=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/addSubject.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/addSubject.jsp?error=1");
        }
    }
}