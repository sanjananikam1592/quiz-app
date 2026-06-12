<%@ page import="java.util.ArrayList" %>
<%@ page import="com.quiz.model.Question" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Question> questionList = (ArrayList<Question>) request.getAttribute("questionList");
    Integer quizId = (Integer) request.getAttribute("quizId");
    Integer durationMinutes = (Integer) request.getAttribute("durationMinutes");

    if (questionList == null) {
        questionList = new ArrayList<Question>();
    }

    if (quizId == null) {
        quizId = 0;
    }

    if (durationMinutes == null) {
        durationMinutes = 60;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body{
            margin:0;
            font-family:Arial, sans-serif;
            background:#eef2f7;
        }
        .main-container{
            width:95%;
            margin:20px auto;
            display:flex;
            gap:20px;
            align-items:flex-start;
        }
        .quiz-container{
            flex:3;
        }
        .nav-container{
            flex:1;
            position:sticky;
            top:20px;
        }
        .card{
            background:#fff;
            border-radius:12px;
            padding:25px;
            box-shadow:0 4px 15px rgba(0,0,0,0.08);
        }
        .timer{
            text-align:right;
            font-size:20px;
            font-weight:bold;
            color:#d62828;
            margin-bottom:20px;
        }
        .question-box{
            display:none;
        }
        .question-box.active{
            display:block;
        }
        .question-title{
            font-size:22px;
            font-weight:bold;
            margin-bottom:20px;
            color:#1b2a4e;
        }
        .option{
            margin:12px 0;
            padding:12px;
            background:#f8f9fc;
            border-radius:8px;
            border:1px solid #e0e4ef;
        }
        .option label{
            cursor:pointer;
            display:block;
            width:100%;
        }
        .actions{
            margin-top:25px;
            display:flex;
            justify-content:space-between;
            gap:10px;
            flex-wrap:wrap;
        }
        .btn{
            padding:10px 18px;
            border:none;
            background:#2d6cdf;
            color:#fff;
            border-radius:6px;
            cursor:pointer;
            font-size:15px;
        }
        .btn:hover{
            background:#1f57ba;
        }
        .submit-btn{
            background:#2a9d8f;
        }
        .submit-btn:hover{
            background:#1f7f73;
        }
        .review-btn{
            background:#7b2cbf;
        }
        .review-btn:hover{
            background:#5a189a;
        }
        .nav-title{
            margin-top:0;
            margin-bottom:15px;
            color:#1b2a4e;
            font-size:20px;
            text-align:center;
        }
        .group-title{
            margin-top:15px;
            margin-bottom:10px;
            font-weight:bold;
            color:#1b2a4e;
            font-size:15px;
        }
        .nav-grid{
            display:grid;
            grid-template-columns:repeat(4, 1fr);
            gap:10px;
            margin-bottom:10px;
        }
        .nav-btn{
            border:none;
            padding:12px 0;
            border-radius:8px;
            color:#fff;
            font-weight:bold;
            cursor:pointer;
            font-size:15px;
        }
        .not-attempted{
            background:#d62828;
        }
        .current{
            background:#f77f00;
        }
        .attempted{
            background:#2a9d8f;
        }
        .review{
            background:#7b2cbf;
        }
        .legend{
            margin-top:18px;
            font-size:14px;
            color:#444;
            line-height:1.8;
        }
        .legend-item{
            display:flex;
            align-items:center;
            gap:10px;
        }
        .legend-color{
            width:16px;
            height:16px;
            border-radius:4px;
        }
        .no-question{
            text-align:center;
            font-size:18px;
            color:#444;
            padding:30px;
        }
    </style>

    <script>
        let currentQuestion = 0;
        let totalQuestions = <%= questionList.size() %>;
        let totalSeconds = <%= durationMinutes * 60 %>;
        let reviewStatus = [];

        function initQuiz() {
            if (totalQuestions === 0) return;
            reviewStatus = new Array(totalQuestions).fill(false);
            showQuestion(0);
            bindAnswerEvents();
            updateNavColors();
            startTimer();
        }

        function showQuestion(index) {
            let questions = document.getElementsByClassName("question-box");

            for (let i = 0; i < questions.length; i++) {
                questions[i].classList.remove("active");
            }

            if (questions.length > 0) {
                questions[index].classList.add("active");
            }

            currentQuestion = index;
            updateNavColors();
        }

        function nextQuestion() {
            if (currentQuestion < totalQuestions - 1) {
                showQuestion(currentQuestion + 1);
            }
        }

        function prevQuestion() {
            if (currentQuestion > 0) {
                showQuestion(currentQuestion - 1);
            }
        }

        function goToQuestion(index) {
            showQuestion(index);
        }

        function markForReview() {
            reviewStatus[currentQuestion] = !reviewStatus[currentQuestion];
            updateNavColors();
        }

        function isAttempted(index) {
            let box = document.getElementsByClassName("question-box")[index];
            if (!box) return false;

            let radios = box.querySelectorAll("input[type='radio']");
            for (let i = 0; i < radios.length; i++) {
                if (radios[i].checked) {
                    return true;
                }
            }
            return false;
        }

        function updateNavColors() {
            let navButtons = document.getElementsByClassName("nav-btn");

            for (let i = 0; i < navButtons.length; i++) {
                navButtons[i].className = "nav-btn";

                if (i === currentQuestion) {
                    navButtons[i].classList.add("current");
                } else if (reviewStatus[i]) {
                    navButtons[i].classList.add("review");
                } else if (isAttempted(i)) {
                    navButtons[i].classList.add("attempted");
                } else {
                    navButtons[i].classList.add("not-attempted");
                }
            }
        }

        function bindAnswerEvents() {
            let radios = document.querySelectorAll('input[type="radio"]');
            for (let i = 0; i < radios.length; i++) {
                radios[i].addEventListener("change", function() {
                    updateNavColors();
                });
            }
        }

        function startTimer() {
            let timerElement = document.getElementById("timer");

            let timer = setInterval(function() {
                let minutes = Math.floor(totalSeconds / 60);
                let seconds = totalSeconds % 60;

                if (seconds < 10) {
                    seconds = "0" + seconds;
                }

                timerElement.innerHTML = minutes + ":" + seconds;

                if (totalSeconds <= 0) {
                    clearInterval(timer);
                    alert("Time is up! Quiz will be auto submitted.");
                    document.getElementById("quizForm").submit();
                    return;
                }

                totalSeconds--;
            }, 1000);
        }

        function confirmSubmitQuiz() {
            let unanswered = 0;

            for (let i = 0; i < totalQuestions; i++) {
                if (!isAttempted(i)) {
                    unanswered++;
                }
            }

            if (unanswered > 0) {
                return confirm("You have " + unanswered + " unanswered questions.\nAre you sure you want to submit?");
            } else {
                return confirm("Are you sure you want to submit the quiz?");
            }
        }

        window.onload = initQuiz;
    </script>
</head>
<body>
<div class="main-container">

    <div class="quiz-container">
        <div class="card">
            <div class="timer">Time Left: <span id="timer"></span></div>

            <% if (questionList.size() == 0) { %>
                <div class="no-question">No questions available for this quiz.</div>
            <% } else { %>
            <form id="quizForm" action="SubmitQuizServlet" method="post" onsubmit="return confirmSubmitQuiz()">
                <input type="hidden" name="quizId" value="<%= quizId %>">

                <% for (int i = 0; i < questionList.size(); i++) {
                    Question q = questionList.get(i);
                %>
                <div class="question-box">
                    <div class="question-title">
                        <%= (i + 1) %>. <%= q.getQuestionText() %>
                    </div>

                    <div class="option">
                        <label>
                            <input type="radio" name="answer_<%= q.getQuestionId() %>" value="1">
                            <%= q.getOption1() %>
                        </label>
                    </div>

                    <div class="option">
                        <label>
                            <input type="radio" name="answer_<%= q.getQuestionId() %>" value="2">
                            <%= q.getOption2() %>
                   s     </label>
                    </div>

                    <div class="option">
                        <label>
                            <input type="radio" name="answer_<%= q.getQuestionId() %>" value="3">
                            <%= q.getOption3() %>
                        </label>
                    </div>

                    <div class="option">
                        <label>
                            <input type="radio" name="answer_<%= q.getQuestionId() %>" value="4">
                            <%= q.getOption4() %>
                        </label>
                    </div>
                </div>
                <% } %>

                <div class="actions">
                    <button type="button" class="btn" onclick="prevQuestion()">Previous</button>
                    <button type="button" class="btn" onclick="nextQuestion()">Next</button>
                    <button type="button" class="btn review-btn" onclick="markForReview()">Mark for Review</button>
                    <button type="submit" class="btn submit-btn">Final Submit</button>
                </div>
            </form>
            <% } %>
        </div>
    </div>

    <div class="nav-container">
        <div class="card">
            <h3 class="nav-title">Question Navigation</h3>

            <% for (int start = 0; start < questionList.size(); start += 4) {
                int end = Math.min(start + 4, questionList.size());
            %>
                <div class="group-title">Questions <%= start + 1 %> - <%= end %></div>
                <div class="nav-grid">
                    <% for (int i = start; i < end; i++) { %>
                        <button type="button" class="nav-btn not-attempted" onclick="goToQuestion(<%= i %>)">
                            <%= i + 1 %>
                        </button>
                    <% } %>
                </div>
            <% } %>

            <div class="legend">
                <div class="legend-item">
                    <span class="legend-color" style="background:#d62828;"></span>
                    <span>Not Attempted</span>
                </div>
                <div class="legend-item">
                    <span class="legend-color" style="background:#f77f00;"></span>
                    <span>Currently Viewing</span>
                </div>
                <div class="legend-item">
                    <span class="legend-color" style="background:#7b2cbf;"></span>
                    <span>Marked for Review</span>
                </div>
                <div class="legend-item">
                    <span class="legend-color" style="background:#2a9d8f;"></span>
                    <span>Attempted</span>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>