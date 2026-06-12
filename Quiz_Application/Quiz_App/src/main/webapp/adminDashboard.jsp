<%@ page contentType="text/html;charset=UTF-8" %>

<%
    
    String admin = (String) session.getAttribute("admin");

    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: "Segoe UI";
            background: #f4f6f9;
        }

        .wrapper {
            padding: 20px;
        }

        .main-card {
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .brand-title {
            font-size: 22px;
            font-weight: bold;
        }

        .sub-text {
            font-size: 14px;
            color: #666;
        }

        .nav-links a {
            margin: 5px;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            background: #eee;
            color: #333;
        }

        .nav-links a:hover {
            background: #ddd;
        }

        .logout {
            background: #e74c3c !important;
            color: white !important;
        }

        .page-title {
            margin: 20px 0;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 15px;
        }

        .feature-card {
            background: #fafafa;
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #eee;
        }

        .feature-card h3 {
            margin-bottom: 10px;
        }

        .feature-card p {
            font-size: 14px;
            color: #555;
        }

        .btn-custom {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 12px;
            background: #4CAF50;
            color: white;
            border-radius: 6px;
            text-decoration: none;
        }

        .btn-custom:hover {
            background: #3d8b40;
        }
    </style>
</head>

<body>

<div class="wrapper">
    <div class="main-card">

        <!-- TOP BAR -->
        <div class="topbar">
            <div>
                <div class="brand-title">Quiz Application</div>
                <div class="sub-text">Welcome, Admin: <b><%= admin %></b></div>
            </div>

            <!-- NAVIGATION -->
            <div class="nav-links">
                <a href="addSubject.jsp">Add Subject</a>
                <a href="addTopic.jsp">Add Topic</a>
                <a href="addQuestion.jsp">Add Question</a>
                <a href="createQuiz.jsp">Create Quiz</a>
                <a href="scheduleQuiz.jsp">Schedule Quiz</a>
                <a href="OverallResultsServlet">Results</a>
                <a href="LogoutServlet" class="logout">Logout</a>
            </div>
        </div>

        <!-- TITLE -->
        <div class="page-title">
            <h1>Admin Dashboard</h1>
            <p>Manage subjects, topics, questions, quizzes, and schedules.</p>
        </div>

        <!-- DASHBOARD CARDS -->
        <div class="grid">

            <div class="feature-card">
                <h3>Add Subjects</h3>
                <p>Create subjects like Java, DBMS, HTML.</p>
                <a href="addSubject.jsp" class="btn-custom">Open</a>
            </div>

            <div class="feature-card">
                <h3>Add Topics</h3>
                <p>Add topics under subjects.</p>
                <a href="addTopic.jsp" class="btn-custom">Open</a>
            </div>

            <div class="feature-card">
                <h3>Add Questions</h3>
                <p>Create MCQ questions for quizzes.</p>
                <a href="addQuestion.jsp" class="btn-custom">Open</a>
            </div>

            <div class="feature-card">
                <h3>Create Quiz</h3>
                <p>Select questions and create quiz.</p>
                <a href="createQuiz.jsp" class="btn-custom">Open</a>
            </div>

            <div class="feature-card">
                <h3>Schedule Quiz</h3>
                <p>Schedule quiz for students.</p>
                <a href="scheduleQuiz.jsp" class="btn-custom">Open</a>
            </div>

            <div class="feature-card">
                <h3>Manage Students</h3>
                <p>View and manage student accounts.</p>
                <a href="viewStudents.jsp" class="btn-custom">Open</a>
            </div>

        </div>

    </div>
</div>

</body>
</html>