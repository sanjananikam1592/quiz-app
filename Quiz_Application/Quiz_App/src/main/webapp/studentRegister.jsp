<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Registration</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI';
            background: linear-gradient(135deg, #43cea2, #185a9d);
        }

        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            width: 400px;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 10px 25px rgba(0,0,0,0.2);
        }

        .title {
            font-size: 22px;
            font-weight: bold;
        }

        .sub {
            color: gray;
            font-size: 13px;
            margin-bottom: 15px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #28a745;
            border: none;
            color: white;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background: #218838;
        }

        .alert {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 6px;
            text-align: center;
        }

        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>

<body>
<div class="wrapper">
    <div class="card">

        <div class="title">Student Registration</div>
        <div class="sub">Create your account</div>

        <!-- Messages -->
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");

            if ("1".equals(success)) {
        %>
            <div class="alert success">Registration Successful!</div>
        <%
            } else if ("1".equals(error)) {
        %>
            <div class="alert error">Registration Failed!</div>
        <%
            } else if ("exists".equals(error)) {
        %>
            <div class="alert error">Email already exists!</div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/StudentRegisterServlet" method="post">

            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>

            <button type="submit">Register</button>

        </form>

    </div>
</div>
</body>
</html>