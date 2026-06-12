<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Question</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI';
            background: linear-gradient(135deg, #4facfe, #00f2fe);
        }

        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 0;
        }

        .card {
            width: 500px;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 10px 25px rgba(0,0,0,0.2);
        }

        .title {
            font-size: 22px;
            font-weight: bold;
        }

        .sub {
            font-size: 13px;
            color: gray;
            margin-bottom: 15px;
        }

        label {
            font-weight: 500;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        textarea {
            resize: none;
            height: 80px;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #007bff;
            border: none;
            color: white;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background: #0056b3;
        }

        .back {
            text-decoration: none;
            color: black;
            display: inline-block;
            margin-bottom: 10px;
        }

        .success-msg {
            background: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 10px;
            text-align: center;
        }

        .error-msg {
            background: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 10px;
            text-align: center;
        }

    </style>
</head>

<body>
<div class="wrapper">
    <div class="card">

        <a href="adminDashboard.jsp" class="back">⬅ Back</a>

        <div class="title">Add Question</div>
        <div class="sub">Create a new question</div>

        <!-- ✅ SUCCESS / ERROR MESSAGE -->
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");

            if ("1".equals(success)) {
        %>
            <div class="success-msg">
                Question Added Successfully!
            </div>
        <%
            } else if ("1".equals(error)) {
        %>
            <div class="error-msg">
                Error adding question!
            </div>
        <%
            }
        %>

        <!-- FORM -->
        <form action="<%= request.getContextPath() %>/AddQuestionServlet" method="post">

            <label>Topic ID</label>
            <input type="number" name="topicId" required>

            <label>Question</label>
            <textarea name="question" required></textarea>

            <label>Option A</label>
            <input type="text" name="optionA" required>

            <label>Option B</label>
            <input type="text" name="optionB" required>

            <label>Option C</label>
            <input type="text" name="optionC" required>

            <label>Option D</label>
            <input type="text" name="optionD" required>

            <label>Correct Answer</label>
            <input type="text" name="correctAnswer" placeholder="A / B / C / D" required>

            <button type="submit">+ Save Question</button>

        </form>

    </div>
</div>
</body>
</html>2