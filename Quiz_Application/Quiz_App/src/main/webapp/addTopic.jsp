<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.quiz.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Topic</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI';
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            width: 420px;
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

        select, input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
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

        .back {
            display: inline-block;
            margin-bottom: 10px;
            text-decoration: none;
            color: white;
        }
    </style>
</head>

<body>
<div class="wrapper">
    <div class="card">

        <a href="adminDashboard.jsp" class="back">⬅ Back</a>

        <div class="title">Add Topic</div>
        <div class="sub">Add topic under subject</div>

        <form action="<%= request.getContextPath() %>/AddTopicServlet" method="post">

            <label>Select Subject</label>
            <select name="subjectId" required>
                <option value="">-- Select Subject --</option>

                <%
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement("SELECT subject_id, subject_name FROM subjects");
                    ResultSet rs = ps.executeQuery();

                    while(rs.next()) {
                %>
                    <option value="<%= rs.getInt("subject_id") %>">
                        <%= rs.getString("subject_name") %>
                    </option>
                <%
                    }
                %>
            </select>

            <label>Topic Name</label>
            <input type="text" name="topicName" placeholder="Enter topic name" required>

            <button type="submit">+ Save Topic</button>

        </form>

    </div>
</div>
</body>
</html>