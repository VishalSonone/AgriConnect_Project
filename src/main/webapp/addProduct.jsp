<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.agriconnect.dto.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d4edda;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            overflow: hidden;
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

        .header span {
            margin-right: 20px;
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
            text-align: center;
            padding: 20px;
            flex-grow: 1;
            width: 60%;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            margin-top: 20px;
        }

        h2 {
            color: #5cb85c;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        .form-group input,
        .form-group textarea {
            width: 85%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1);
            font-size: 14px;
        }

        .btn {
            width: auto;
            padding: 10px 20px;
            background-color: #5cb85c;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin: 0 auto;
            display: block;
        }

        .btn:hover {
            background-color: #4cae4c;
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
        <%
            HttpSession session2 = request.getSession();
            User user = (User) session2.getAttribute("user");
            if (user != null) {
        %>
            <span>Welcome, <%= user.getName() %>!</span>
            <a href="profile.jsp">Profile</a>
            <a href="logout.jsp">Logout</a>
        <%
            } else {
        %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        <%
            }
        %>
    </div>
    <div class="container">
        <h2>Add New Product</h2>
        <form action="addProduct" method="post">
            <div class="form-group">
                <label for="name">Product Name</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price (Rs)</label>
                <input type="number" id="price" name="price" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity (Ton)</label>
                <input type="number" id="quantity" name="quantity" required>
            </div>
            <div class="form-group">
                <label for="imageUrl">Image URL</label>
                <input type="text" id="imageUrl" name="imageUrl" required>
            </div>
            <button type="submit" class="btn">Add Product</button>
        </form>
    </div>
    <footer>
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
</body>
</html>