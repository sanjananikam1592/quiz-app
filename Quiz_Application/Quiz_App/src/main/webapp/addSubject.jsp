<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Subject</title>
</head>

<body style="margin:0; font-family:Segoe UI; background:linear-gradient(135deg,#1e3c72,#2a5298);">

<div style="display:flex; justify-content:center; align-items:center; height:100vh;">

    <div style="width:400px; background:#fff; padding:25px; border-radius:12px; box-shadow:0 10px 25px rgba(0,0,0,0.2);">

        <!-- Top Bar -->
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
            
            <div>
                <h2 style="margin:0;">Add Subject</h2>
                <p style="margin:2px 0; font-size:13px; color:gray;">Create a new subject</p>
            </div>

            <a href="adminDashboard.jsp" 
               style="text-decoration:none; padding:6px 10px; background:#eee; border-radius:6px; font-size:13px; color:black;">
               ⬅ Back
            </a>
        </div>

        <!-- SUCCESS MESSAGE -->
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");

            if ("1".equals(success)) {
        %>
            <div style="padding:10px; background:#d1fae5; color:#065f46; border-radius:8px; margin-bottom:10px; text-align:center;">
                Subject Added Successfully!
            </div>
        <%
            } else if ("1".equals(error)) {
        %>
            <div style="padding:10px; background:#fee2e2; color:#991b1b; border-radius:8px; margin-bottom:10px; text-align:center;">
                Error adding subject!
            </div>
        <%
            } else if ("empty".equals(error)) {
        %>
            <div style="padding:10px; background:#fee2e2; color:#991b1b; border-radius:8px; margin-bottom:10px; text-align:center;">
                Subject name cannot be empty!
            </div>
        <%
            }
        %>

        <!-- FORM -->
        <form action="<%= request.getContextPath() %>/AddSubjectServlet" method="post">

            <label style="display:block; margin-bottom:5px;">Subject Name</label>

            <input type="text" name="subjectName" placeholder="Enter subject name" required
                   style="width:100%; padding:10px; border-radius:8px; border:1px solid #ccc; margin-bottom:15px; outline:none;">

            <button type="submit"
                    style="width:100%; padding:10px; background:#2a5298; color:white; border:none; border-radius:8px; cursor:pointer;">
                + Save Subject
            </button>

        </form>

    </div>

</div>

</body>
</html>