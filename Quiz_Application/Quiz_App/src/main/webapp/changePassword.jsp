<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body{
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            background: linear-gradient(135deg, #6ee7d8, #b7c3ee);
            padding:20px;
        }

        .container{
            width:100%;
            max-width:450px;
            background: rgba(255,255,255,0.18);
            backdrop-filter: blur(12px);
            border-radius:20px;
            box-shadow:0 18px 40px rgba(0,0,0,0.12);
            padding:35px 30px;
        }

        .title{
            text-align:center;
            margin-bottom:25px;
        }

        .title h2{
            color:#1f2937;
            font-size:32px;
            margin-bottom:8px;
        }

        .title p{
            color:#374151;
            font-size:15px;
        }

        .alert{
            padding:12px 14px;
            border-radius:10px;
            margin-bottom:18px;
            font-size:14px;
            font-weight:600;
        }

        .alert-success{
            background:#dcfce7;
            color:#166534;
            border:1px solid #86efac;
        }

        .alert-error{
            background:#fee2e2;
            color:#991b1b;
            border:1px solid #fca5a5;
        }

        .form-group{
            margin-bottom:18px;
        }

        label{
            display:block;
            margin-bottom:8px;
            color:#111827;
            font-weight:600;
        }

        input{
            width:100%;
            padding:12px 14px;
            border-radius:10px;
            border:1px solid #d1d5db;
            outline:none;
            font-size:15px;
            transition:0.3s;
        }

        input:focus{
            border-color:#2563eb;
            box-shadow:0 0 0 3px rgba(37,99,235,0.12);
        }

        .btn-group{
            display:flex;
            gap:12px;
            margin-top:22px;
        }

        .btn{
            flex:1;
            padding:12px;
            border:none;
            border-radius:10px;
            font-size:15px;
            font-weight:700;
            cursor:pointer;
            transition:0.3s;
            text-decoration:none;
            text-align:center;
        }

        .btn-primary{
            background:#2563eb;
            color:#fff;
        }

        .btn-primary:hover{
            background:#1d4ed8;
        }

        .btn-secondary{
            background:#e5e7eb;
            color:#111827;
        }

        .btn-secondary:hover{
            background:#d1d5db;
        }

        .note{
            margin-top:16px;
            font-size:13px;
            color:#4b5563;
            text-align:center;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="title">
            <h2>Change Password</h2>
            <p>Update your account password securely</p>
        </div>

        <% if("1".equals(success)){ %>
            <div class="alert alert-success">Password changed successfully.</div>
        <% } %>

        <% if("1".equals(error)){ %>
            <div class="alert alert-error">Current password is incorrect or passwords do not match.</div>
        <% } %>

        <form action="ChangePasswordServlet" method="post">
            <div class="form-group">
                <label for="currentPassword">Current Password</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
            </div>

            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-primary">Update Password</button>
                <a href="StudentDashboardServlet" class="btn btn-secondary">Back</a>
            </div>
        </form>

        <div class="note">
            Make sure your new password is easy to remember and secure.
        </div>
    </div>

</body>
</html>