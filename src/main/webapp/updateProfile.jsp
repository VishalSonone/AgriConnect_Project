<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.agriconnect.dto.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - AgriConnect</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d4edda;
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden; /* Remove scrollbar from the entire page */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
        }

        .header {
            width: 100%;
            background-color: #5cb85c;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 0 0 15px 15px;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
        }

        .header a {
            text-decoration: none;
            color: white;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin-left: 10px;
        }

        .header a:hover {
            background-color: #4cae4c;
        }

        .container {
            width: 90%;
            margin: 20px auto;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
        }

        .form-box {
            width: 50%;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            box-sizing: border-box;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
        }

        .btn {
            width: auto;
            padding: 10px 20px;
            background-color: #5cb85c;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin: 0 auto;
            display: block;
        }

        .btn:hover {
            background-color: #4cae4c;
        }

        .success-message {
            color: green;
            margin-top: 15px;
        }

        .error-message {
            color: red;
            margin-top: 15px;
        }

        footer {
            width: 100%;
            text-align: center;
            padding: 10px;
            background-color: #5cb85c;
            color: white;
            font-size: 14px;
            position: relative;
            bottom: 0;
            border-radius: 15px 15px 0 0;
            box-shadow: 0 -3px 5px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Products</a>
        <a href="profile.jsp">Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>
    <div class="container">
        <div class="form-box">
            <%
                HttpSession session2 = request.getSession();
                User user = (User) session2.getAttribute("user");
                String successMessage = (String) request.getAttribute("successMessage");
                String errorMessage = (String) request.getAttribute("errorMessage");
            %>
            <h2>Update Profile Information</h2>
            <form action="updateProfileServlet" method="post">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" value="<%= user != null ? user.getName() : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="<%= user != null ? user.getEmail() : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Leave blank to keep current password">
                </div>
                <button type="submit" class="btn">Update Profile</button>
            </form>
            <%
                if (successMessage != null) {
            %>
                <p class="success-message"><%= successMessage %></p>
            <%
                }
                if (errorMessage != null) {
            %>
                <p class="error-message"><%= errorMessage %></p>
            <%
                }
            %>
        </div>
    </div>
    <footer>
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
</body>
</html>