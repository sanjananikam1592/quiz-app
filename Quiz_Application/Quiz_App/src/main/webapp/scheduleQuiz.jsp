<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Quiz</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body{
            margin:0;
            font-family:Arial, sans-serif;
            background:#f4f6fb;
        }
        .container{
            width:80%;
            margin:40px auto;
        }
        .card{
            background:#fff;
            padding:30px;
            border-radius:12px;
            box-shadow:0 4px 15px rgba(0,0,0,0.08);
        }
        h2{
            margin-top:0;
            color:#1b2a4e;
            text-align:center;
        }
        .form-group{
            margin-bottom:18px;
        }
        label{
            display:block;
            margin-bottom:8px;
            font-weight:bold;
            color:#333;
        }
        input{
            width:100%;
            padding:10px;
            border:1px solid #ccc;
            border-radius:6px;
            font-size:15px;
        }
        .btn{
            background:#2d6cdf;
            color:#fff;
            border:none;
            padding:12px 18px;
            border-radius:6px;
            cursor:pointer;
            width:100%;
            font-size:16px;
        }
        .btn:hover{
            background:#1f57ba;
        }
        .msg{
            text-align:center;
            margin-bottom:15px;
            font-weight:bold;
        }
        .success{ color:green; }
        .error{ color:red; }
        .back-link{
            display:inline-block;
            margin-top:15px;
            text-decoration:none;
            color:#2d6cdf;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h2>Schedule Quiz</h2>

        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if("1".equals(success)){
        %>
            <div class="msg success">Quiz scheduled successfully.</div>
        <%
            }
            if("1".equals(error)){
        %>
            <div class="msg error">Failed to schedule quiz.</div>
        <%
            }
        %>

        <form action="ScheduleQuizServlet" method="post">
            <div class="form-group">
                <label for="quizId">Quiz ID</label>
                <input type="number" id="quizId" name="quizId" placeholder="Enter quiz id" required>
            </div>

            <div class="form-group">
                <label for="scheduleDate">Schedule Date</label>
                <input type="date" id="scheduleDate" name="scheduleDate" required>
            </div>

            <div class="form-group">
                <label for="startTime">Start Time</label>
                <input type="time" id="startTime" name="startTime" required>
            </div>

            <button type="submit" class="btn">Schedule Quiz</button>
        </form>


    </div>
</div>
</body>
</html>