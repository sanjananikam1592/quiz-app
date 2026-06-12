<!--<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 != null && session1.getAttribute("user") != null) {
        String role = (String) session1.getAttribute("role");

        if (role != null && role.equalsIgnoreCase("student")) {
            response.sendRedirect("StudentDashboardServlet");
            return;
        } else if (role != null && role.equalsIgnoreCase("admin")) {
            response.sendRedirect("adminDashboard.jsp");
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz App Home</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #74ebd5, #9face6);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 50px 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            text-align: center;
            color: #1b1f3b;
        }

        .title {
            font-size: 52px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .subtitle {
            font-size: 24px;
            margin-bottom: 35px;
            color: #243b55;
        }

        .description {
            font-size: 20px;
            margin-bottom: 40px;
            color: #23395d;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 14px 28px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            transition: 0.3s ease;
        }

        .btn-login {
            background: #2d6cdf;
            color: white;
        }

        .btn-login:hover {
            background: #1f57ba;
        }

        .btn-result {
            background: #2a9d8f;
            color: white;
        }

        .btn-result:hover {
            background: #1f7f73;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="title">Welcome to Quiz App</div>
        <div class="subtitle">Online Quiz Management System</div>
        <div class="description">
            Test your knowledge with our online quiz system.
        </div>

        <div class="btn-group">
            <a href="login.jsp" class="btn btn-login">Login</a>
            <a href="OverallResultsServlet" class="btn btn-result">Overall Result</a>
        </div>
    </div>
</body>
</html>-->