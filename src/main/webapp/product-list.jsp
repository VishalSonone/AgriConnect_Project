<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.agriconnect.dto.Product" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.agriconnect.dto.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 10px;
            text-align: right;
        }
        .header a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
        }
        .container {
            padding: 20px;
            max-width: 1200px;
            margin: auto;
        }
        h2 {
            text-align: center;
        }
        .product-card {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 15px;
            margin: 15px;
            display: inline-block;
            width: calc(33% - 30px);
            vertical-align: top;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .product-card img {
            width: 100%;
            height: auto;
            border-radius: 4px;
        }
        .product-card h5 {
            margin: 10px 0;
        }
        .btn {
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: relative;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>

    <div class="header">
        <%
            HttpSession session2 = request.getSession();
            User user = (User ) session2.getAttribute("user");
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
        <h2>Product List</h2>
        <div class="products">
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (Product product : products) {
            %>
                <div class="product-card">
                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                    <h5><%= product.getName() %></h5>
                    <p>Price: $<%= product.getPrice() %></p>
                    <p>Description: <%= product.getDescription() %></p>
                    <p>Quantity: <%= product.getQuantity() %></p>
                    <%
                        if (user != null && user.getRole().equals("FARMER")) {
                    %>
                        <a href="updateProduct.jsp?id=<%= product.getId() %>" class="btn">Update</a>
                        <a href="deleteProduct.jsp?id=<%= product.getId() %>" class="btn">Delete</a>
                    <%
                        } else {
                    %>
                        <a href="buyNow.jsp?id=<%= product.getId() %>" class="btn">Buy Now</a>
                    <%
                        }
                    %>
                </div>
            <%
                    }
                } else {
            %>
                <p>No products available.</p>
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