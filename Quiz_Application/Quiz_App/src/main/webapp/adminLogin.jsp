<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">
</head>

<body>

<div class="container">
    <div class="card">
        <h2>Admin Login</h2>

        <form action="AdminLoginServlet" method="post">

            <input type="text" name="username" placeholder="Enter Admin Username" required>

            <input type="password" name="password" placeholder="Enter Password" required>

            <button type="submit" class="btn">Login</button>

        </form>

        <p>Only authorized admins allowed</p>
    </div>
</div>

</body>
</html>