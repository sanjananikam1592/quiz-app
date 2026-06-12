<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quiz.model.OverallResult" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<OverallResult> resultList = (List<OverallResult>) request.getAttribute("resultList");

    Object totalObj = request.getAttribute("totalQuizzesAttempted");
    Object avgObj = request.getAttribute("averageScore");
    Object bestObj = request.getAttribute("bestScore");
    Object completedObj = request.getAttribute("completedCount");
    Object missedObj = request.getAttribute("missedCount");

    int totalQuizzesAttempted = (totalObj != null) ? Integer.parseInt(totalObj.toString()) : 0;
    double averageScore = (avgObj != null) ? Double.parseDouble(avgObj.toString()) : 0.0;
    int bestScore = (bestObj != null) ? Integer.parseInt(bestObj.toString()) : 0;
    int completedCount = (completedObj != null) ? Integer.parseInt(completedObj.toString()) : 0;
    int missedCount = (missedObj != null) ? Integer.parseInt(missedObj.toString()) : 0;

    if (resultList == null) {
        resultList = new ArrayList<OverallResult>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Overall Result</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f7fb;
            padding: 30px;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.08);
            padding: 30px;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 25px;
        }

        .summary-box {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .card {
            background: #f8fafc;
            border-left: 5px solid #3498db;
            padding: 18px;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .card h3 {
            font-size: 15px;
            color: #555;
            margin-bottom: 8px;
        }

        .card p {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            border-radius: 10px;
            overflow: hidden;
        }

        thead {
            background: #3498db;
            color: white;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #e5e7eb;
        }

        tbody tr:hover {
            background: #f1f5f9;
        }

        .no-data {
            text-align: center;
            color: #777;
            padding: 20px;
        }

        .btn-group {
            margin-top: 25px;
            text-align: center;
        }

        .btn {
            display: inline-block;
            text-decoration: none;
            background: #3498db;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            margin: 5px;
        }

        .btn:hover {
            background: #217dbb;
        }

        .status-completed {
            color: green;
            font-weight: bold;
        }

        .status-missed {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Overall Quiz Result</h1>

        <div class="summary-box">
            <div class="card">
                <h3>Total Quizzes Attempted</h3>
                <p><%= totalQuizzesAttempted %></p>
            </div>
            <div class="card">
                <h3>Average Score</h3>
                <p><%= String.format("%.2f", averageScore) %></p>
            </div>
            <div class="card">
                <h3>Best Score</h3>
                <p><%= bestScore %></p>
            </div>
            <div class="card">
                <h3>Completed</h3>
                <p><%= completedCount %></p>
            </div>
            <div class="card">
                <h3>Missed</h3>
                <p><%= missedCount %></p>
            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Quiz Title</th>
                    <th>Subject</th>
                    <th>Topic</th>
                    <th>Quiz Date</th>
                    <th>Total Marks</th>
                    <th>Marks Obtained</th>
                    <th>Percentage</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (resultList.size() == 0) {
                %>
                <tr>
                    <td colspan="8" class="no-data">No quiz results found.</td>
                </tr>
                <%
                    } else {
                        for (OverallResult result : resultList) {
                %>
                <tr>
                    <td><%= result.getQuizTitle() %></td>
                    <td><%= result.getSubjectName() %></td>
                    <td><%= result.getTopicName() %></td>
                    <td><%= result.getQuizDate() %></td>
                    <td><%= result.getTotalMarks() %></td>
                    <td><%= result.getMarksObtained() %></td>
                    <td><%= String.format("%.2f", result.getPercentage()) %>%</td>
                    <td class="<%= "Completed".equalsIgnoreCase(result.getStatus()) ? "status-completed" : "status-missed" %>">
                        <%= result.getStatus() %>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

        <div class="btn-group">
            <a href="StudentDashboardServlet" class="btn">Back to Dashboard</a>
            <a href="LogoutServlet" class="btn">Logout</a>
        </div>
    </div>
</body>
</html>