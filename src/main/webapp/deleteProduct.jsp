<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.agriconnect.dto.Product" %>
<%@ page import="com.agriconnect.dao.ProductDao" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.agriconnect.dto.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Product</title>
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

        .product-details {
            text-align: left;
            margin-bottom: 20px;
        }

        .product-details img {
            width: 150px; /* Set fixed width */
            height: 150px; /* Set fixed height */
            border-radius: 8px;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .product-details h3 {
            margin: 10px 0;
        }

        .product-details p {
            margin: 5px 0;
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
        <h2>Delete Product</h2>
        <%
            String productId = request.getParameter("id");
            ProductDao productDao = new ProductDao();
            Product product = productDao.getProductById(Integer.parseInt(productId));
        %>
        <div class="product-details">
            <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
            <h3><%= product.getName() %></h3>
            <p>Price: ₹<%= product.getPrice() %></p>
            <p>Quantity: <%= product.getQuantity() %></p>
            <p>Description: <%= product.getDescription() %></p>
        </div>
        <form action="deleteProductAction" method="post">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <button type="submit" class="btn">Delete Product</button>
        </form>
    </div>
    <footer>
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
</body>
</html>