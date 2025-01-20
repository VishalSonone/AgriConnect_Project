<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.agriconnect.dto.Product" %>
<%@ page import="com.agriconnect.dao.ProductDao" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
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

        .header h1 {
            margin: 0;
            font-size: 24px;
        }

        .nav {
            display: flex;
            gap: 15px;
        }

        .nav a {
            text-decoration: none;
            color: white;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .nav a:hover {
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
            width: 100%;
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
        <h1>Update Product</h1>
        <div class="nav">
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="profile.jsp">Profile</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
    <div class="container">
        <%
            String productId = request.getParameter("id");
            ProductDao productDao = new ProductDao();
            Product product = productDao.getProductById(Integer.parseInt(productId));
        %>
        <h2>Update Product Information</h2>
        <form action="updateProductAction" method="post">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <div class="form-group">
                <label for="name">Product Name</label>
                <input type="text" id="name" name="name" value="<%= product.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required><%= product.getDescription() %></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price (Rs)</label>
                <input type="number" id="price" name="price" step="0.01" value="<%= product.getPrice() %>" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity (Ton)</label>
                <input type="number" id="quantity" name="quantity" value="<%= product.getQuantity() %>" required>
            </div>
            <div class="form-group">
                <label for="imageUrl">Image URL</label>
                <input type="text" id="imageUrl" name="imageUrl" value="<%= product.getImageUrl() %>" required>
            </div>
            <button type="submit" class="btn">Update Product</button>
        </form>
    </div>
    <footer>
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
</body>
</html>