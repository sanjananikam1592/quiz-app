<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Result</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <div class="score-box">
        <h2>Quiz Result</h2>

        <%
            Integer score = (Integer) request.getAttribute("score");
            Integer totalMarks = (Integer) request.getAttribute("totalMarks");
            Double percentage = (Double) request.getAttribute("percentage");
            String subjectName = (String) request.getAttribute("subjectName");
            String topicName = (String) request.getAttribute("topicName");
        %>

        <p><b>Subject:</b> <%= subjectName != null ? subjectName : "-" %></p>
        <p><b>Topic:</b> <%= topicName != null ? topicName : "-" %></p>
        <p><b>Marks Obtained:</b> <%= score != null ? score : 0 %> / <%= totalMarks != null ? totalMarks : 0 %></p>
        <p><b>Percentage:</b> <%= percentage != null ? String.format("%.2f", percentage) : "0.00" %>%</p>

        <br>

        <a href="StudentDashboardServlet">
            <button type="button">Back to Dashboard</button>
        </a>

        <a href="OverallResultsServlet">
            <button type="button">View Overall Results</button>
        </a>
    </div>
</div>

</body>
</html>