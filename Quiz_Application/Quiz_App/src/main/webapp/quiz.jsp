<%@ page import="java.util.ArrayList" %>
<%@ page import="com.quiz.model.Question" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) sessionObj.getAttribute("user");

    Integer quizId = (Integer) request.getAttribute("quizId");
    Integer duration = (Integer) request.getAttribute("durationMinutes");

    ArrayList<Question> questionList =
        (ArrayList<Question>) request.getAttribute("questionList");

    if (questionList == null) {
        questionList = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz Page</title>

<style>
    body {
        font-family: Arial;
        background: #f4f6f9;
        margin: 0;
    }

    .container {
        width: 80%;
        margin: auto;
        background: white;
        padding: 20px;
        margin-top: 20px;
        border-radius: 10px;
    }

    h2 {
        text-align: center;
    }

    .timer {
        text-align: right;
        font-weight: bold;
        color: red;
    }

    .question-box {
        padding: 15px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
    }

    .submit-btn {
        width: 100%;
        padding: 10px;
        background: green;
        color: white;
        border: none;
        font-size: 16px;
        cursor: pointer;
    }

    .submit-btn:hover {
        background: darkgreen;
    }
</style>

<script>
    // Simple countdown timer
    let timeLeft = <%= duration %> * 60;

    function startTimer() {
        let timer = document.getElementById("timer");

        let x = setInterval(function () {

            let minutes = Math.floor(timeLeft / 60);
            let seconds = timeLeft % 60;

            timer.innerHTML = minutes + "m " + seconds + "s ";

            timeLeft--;

            if (timeLeft < 0) {
                clearInterval(x);
                alert("Time is up! Submitting quiz...");
                document.getElementById("quizForm").submit();
            }

        }, 1000);
    }
</script>

</head>

<body onload="startTimer()">

<div class="container">

    <h2>Welcome, <%= username %></h2>

    <div class="timer">
        Time Left: <span id="timer"></span>
    </div>

    <form id="quizForm" action="SubmitQuizServlet" method="post">

        <input type="hidden" name="quizId" value="<%= quizId %>"/>

        <%
            int qno = 1;

            for (Question q : questionList) {
        %>

        <div class="question-box">

            <p>
                <b>Q<%= qno++ %>:</b>
                <%= q.getQuestionText() %>
            </p>

            <label>
                <input type="radio" name="q<%= q.getQuestionId() %>" value="1">
                <%= q.getOption1() %>
            </label><br>

            <label>
                <input type="radio" name="q<%= q.getQuestionId() %>" value="2">
                <%= q.getOption2() %>
            </label><br>

            <label>
                <input type="radio" name="q<%= q.getQuestionId() %>" value="3">
                <%= q.getOption3() %>
            </label><br>

            <label>
                <input type="radio" name="q<%= q.getQuestionId() %>" value="4">
                <%= q.getOption4() %>
            </label>

        </div>

        <% } %>

        <button type="submit" class="submit-btn">
            Submit Quiz
        </button>

    </form>

</div>

</body>
</html>