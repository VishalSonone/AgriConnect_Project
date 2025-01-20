<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.agriconnect.dto.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.agriconnect.dto.Product" %>
<%@ page import="com.agriconnect.dao.ProductDao" %>
<%@ page import="com.agriconnect.dao.PurchaseDao" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - AgriConnect</title>
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
            width: 80%;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            margin-top: 20px;
            overflow-y: auto;
        }

        h2 {
            color: #5cb85c;
            margin-bottom: 20px;
        }

        .user-details {
            margin-bottom: 20px;
            text-align: left;
        }

        .user-details p {
            margin: 5px 0;
        }

        .product-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .product-card img {
            max-width: 100px;
            border-radius: 8px;
            margin-right: 20px;
        }

        .product-card h3 {
            margin: 10px 0;
        }

        .product-card p {
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

        .product-actions {
            display: flex;
            gap: 10px;
        }

        .add-product-btn {
            margin-bottom: 20px;
        }

        .success-message {
            color: green;
        }

        .error-message {
            color: red;
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
        <%
            if (user != null) {
        %>
            <div class="user-details">
                <h2>Profile Information</h2>
                <p>Name: <%= user.getName() %></p>
                <p>Email: <%= user.getEmail() %></p>
                <a href="updateProfile.jsp" class="btn">Update Profile</a>
            </div>
            <%
                ProductDao productDao = new ProductDao();
                PurchaseDao purchaseDao = new PurchaseDao();
                if ("FARMER".equals(user.getRole())) {
                    List<Product> products = productDao.getAllProductsByUserId(user.getId());
                    List<Product> soldProducts = purchaseDao.getSoldProductsByUserId(user.getId());
            %>
            <h2>Your Products</h2>
            <a href="addProduct.jsp" class="btn add-product-btn">Add Product</a>
            <div class="product-list">
                <%
                    for (Product product : products) {
                %>
                <div class="product-card">
                    <div class="product-info">
                        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                        <div>
                            <h3><%= product.getName() %></h3>
                            <p>Price: ₹<%= product.getPrice() %></p>
                            <p>Quantity: <%= product.getQuantity() %></p>
                            <p>Description: <%= product.getDescription() %></p>
                        </div>
                    </div>
                    <div class="product-actions">
                        <a href="updateProduct.jsp?id=<%= product.getId() %>" class="btn">Update</a>
                        <a href="deleteProduct.jsp?id=<%= product.getId() %>" class="btn">Delete</a>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <h2>Sold Products</h2>
            <div class="product-list">
                <%
                    for (Product product : soldProducts) {
                %>
                <div class="product-card">
                    <div class="product-info">
                        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                        <div>
                            <h3><%= product.getName() %></h3>
                            <p>Price: ₹<%= product.getPrice() %></p>
                            <p>Quantity: <%= product.getQuantity() %></p>
                            <p>Description: <%= product.getDescription() %></p>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                } else if ("BUYER".equals(user.getRole())) {
                    List<Product> purchasedProducts = purchaseDao.getPurchasedProductsByUserId(user.getId());
            %>
            <h2>Your Purchases</h2>
            <div class="product-list">
                <%
                    for (Product product : purchasedProducts) {
                %>
                <div class="product-card">
                    <div class="product-info">
                        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                        <div>
                            <h3><%= product.getName() %></h3>
                            <p>Price: ₹<%= product.getPrice() %></p>
                            <p>Quantity: <%= product.getQuantity() %></p>
                            <p>Description: <%= product.getDescription() %></p>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <a href="products.jsp" class="btn">Back to Products</a>
            <%
                }
            } else {
            %>
            <p>You need to <a href="login.jsp">log in</a> to view your profile.</p>
            <%
            }
        %>
    </div>
    <footer>
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
</body>
</html>