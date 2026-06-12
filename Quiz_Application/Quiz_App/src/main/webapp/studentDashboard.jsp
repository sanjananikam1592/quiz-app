<%@ page import="java.util.ArrayList" %>
<%@ page import="com.quiz.model.ScheduledQuiz" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String role = (String) sessionObj.getAttribute("role");

    if (role == null || !role.equalsIgnoreCase("student")) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) sessionObj.getAttribute("user");

    ArrayList<ScheduledQuiz> quizList =
        (ArrayList<ScheduledQuiz>) request.getAttribute("quizList");

    if (quizList == null) {
        quizList = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Dashboard</title>

<style>
    body {
        margin: 0;
        font-family: "Segoe UI";
        background: #f4f6f9;
    }

    .navbar {
        background: #2a5298;
        padding: 12px;
        text-align: center;
    }

    .navbar a {
        color: white;
        margin: 10px;
        text-decoration: none;
        font-weight: bold;
    }

    .navbar a:hover {
        text-decoration: underline;
    }

    .wrapper {
        padding: 20px;
    }

    .card {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    h1 {
        margin-bottom: 5px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }

    th, td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
        text-align: center;
    }

    th {
        background: #2a5298;
        color: white;
    }

    .btn {
        padding: 6px 12px;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        display: inline-block;
        margin: 3px;
    }

    .start-btn {
        background: green;
    }

    .start-btn:hover {
        background: darkgreen;
    }

    .result-btn {
        background: #2a9d8f;
    }

    .result-btn:hover {
        background: #21867a;
    }

    .disabled {
        background: gray;
        padding: 6px 12px;
        border-radius: 5px;
        color: white;
    }

    .empty {
        text-align: center;
        padding: 20px;
        color: #555;
        font-size: 18px;
    }
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <a href="<%= request.getContextPath() %>/StudentDashboardServlet">Home</a>
    <a href="<%= request.getContextPath() %>/OverallResultsServlet">Overall Results</a>
    <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
</div>

<div class="wrapper">
    <div class="card">

        <h1>Welcome, <%= username %></h1>
        <p>Available quizzes:</p>

        <% if (!quizList.isEmpty()) { %>

        <table>
            <tr>
                <th>Title</th>
                <th>Subject</th>
                <th>Topic</th>
                <th>Date</th>
                <th>Time</th>
                <th>Duration</th>
                <th>Marks</th>
                <th>Action</th>
            </tr>

            <% for (ScheduledQuiz quiz : quizList) { %>
            <tr>
                <td><%= quiz.getQuizTitle() %></td>
                <td><%= quiz.getSubject() %></td>
                <td><%= quiz.getTopic() %></td>
                <td><%= quiz.getQuizDate() %></td>
                <td><%= quiz.getQuizTime() %></td>
                <td><%= quiz.getDuration() %> min</td>
                <td><%= quiz.getTotalMarks() %></td>

                <td>
                    <% if (quiz.isCanStart()) { %>
                        <a href="<%= request.getContextPath() %>/StartQuizServlet?quizId=<%= quiz.getQuizId() %>" 
                           class="btn start-btn">
                            Start
                        </a>
                    <% } else { %>
                        <span class="disabled">Locked</span>
                    <% } %>

                    <br>

                    <a href="<%= request.getContextPath() %>/OverallResultsServlet" 
                       class="btn result-btn">
                        View Results
                    </a>
                </td>
            </tr>
            <% } %>

        </table>

        <% } else { %>

            <div class="empty">
                Welcome to Quiz.
            </div>

        <% } %>

    </div>
</div>

</body>
</html>