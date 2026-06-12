<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Quiz</title>

<style>
body{
    font-family: Arial;
    background:#f4f6fb;
}
.container{
    width:60%;
    margin:40px auto;
}
.card{
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
}
input{
    width:100%;
    padding:10px;
    margin-top:5px;
    margin-bottom:15px;
}
button{
    width:100%;
    padding:12px;
    background:#2d6cdf;
    color:white;
    border:none;
    cursor:pointer;
}
button:hover{
    background:#1f57ba;
}
.msg{
    text-align:center;
}
.success{ color:green; }
.error{ color:red; }
</style>

</head>

<body>

<div class="container">
<div class="card">

<h2>Create Quiz</h2>

<%
String success = request.getParameter("success");
String error = request.getParameter("error");

if("1".equals(success)){
%>
    <p class="msg success">Quiz Created Successfully</p>
<% } else if(error != null){ %>
    <p class="msg error">Error: <%= error %></p>
<% } %>

<form action="CreateQuizServlet" method="post">

    <label>Quiz Title</label>
    <input type="text" name="quizTitle" required>

    <label>Subject Name</label>
    <input type="text" name="subjectName" required>

    <label>Topic Name</label>
    <input type="text" name="topicName" required>

    <label>Scheduled Date</label>
    <input type="date" name="scheduledDate" required>

    <label>Scheduled Time</label>
    <input type="time" name="scheduledTime" required>

    <label>Duration (Minutes)</label>
    <input type="number" name="durationMinutes" required>

    <button type="submit">Create Quiz</button>

</form>

</div>
</div>

</body>
</html>