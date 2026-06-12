<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Quiz App</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI';
            background: linear-gradient(135deg, #1e3c72, #2a5298);
        }

        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            width: 380px;
            background: #fff;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0px 10px 30px rgba(0,0,0,0.25);
        }

        .title {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 5px;
        }

        .sub {
            text-align: center;
            font-size: 13px;
            color: gray;
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
            outline: none;
        }

        input:focus {
            border-color: #2a5298;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #2a5298;
            border: none;
            color: white;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            margin-top: 10px;
        }

        button:hover {
            background: #1e3c72;
        }

        .alert {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 8px;
            text-align: center;
            font-size: 14px;
        }

        .success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #34d399;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #f87171;
        }

        .link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .link a {
            color: #2a5298;
            text-decoration: none;
            font-weight: bold;
        }

        .link a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="wrapper">
    <div class="card">

        <div class="title">Login</div>
        <div class="sub">Access your Quiz account</div>

        <!-- ✅ Registration Success Message -->
        <%
            String reg = request.getParameter("registered");
            if ("1".equals(reg)) {
        %>
            <div class="alert success">
                Registration successful! Please login.
            </div>
        <%
            }
        %>

        <!-- ❌ Login Error Message -->
        <%
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
            <div class="alert error">
                Invalid username or password
            </div>
        <%
            }
        %>

        <!-- LOGIN FORM -->
    <form action="<%= request.getContextPath() %>/LoginServlet" method="post">

    <input type="text" name="username" placeholder="Enter Username" required>

    <input type="password" name="password" placeholder="Enter Password" required>

    <button type="submit">Login</button>

</form>
        <div class="link">
            New user? <a href="studentRegister.jsp">Register here</a>
        </div>

    </div>
</div>

</body>
</html>