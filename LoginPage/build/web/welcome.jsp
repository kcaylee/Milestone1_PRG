<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Connections" %> <!-- Import the Connections class -->
<html>
<head>
    <title>Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        .container {
            display: inline-block;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #007BFF;
            color: white;
            cursor: pointer;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome, 
        <%
            String username = (String) session.getAttribute("username");
            if (username != null) {
                out.print(username);
            } else {
                response.sendRedirect("login.jsp"); // Redirect to login page if no session
            }
        %>!
        </h2>
        <p>You have successfully logged in.</p>

        <form method="post">
            <input type="submit" class="button" name="logout" value="Logout">
            <input type="submit" class="button" name="deleteAccount" value="Delete Account">
        </form>

        <%
            // Handle logout functionality directly within the JSP
            if (request.getParameter("logout") != null) {
                session.invalidate();  // Invalidate the session
                response.sendRedirect("index.jsp");  // Redirect to index page
            }

            // Handle account deletion
            if (request.getParameter("deleteAccount") != null) {
                Connections dbConn = new Connections();
                if (dbConn.deleteUser(username)) {
                    session.invalidate();  // Invalidate the session after deletion
                    response.sendRedirect("index.jsp");  // Redirect to index page
                } else {
                    out.println("<div class='error'>Error: Could not delete account. Please try again.</div>");
                }
            }
        %>
    </div>
</body>
</html>