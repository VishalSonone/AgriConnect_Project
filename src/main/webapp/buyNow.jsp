<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.agriconnect.dao.ProductDao" %>
<%@ page import="com.agriconnect.dto.Product" %>
<%@ page import="com.agriconnect.dto.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Now - AgriConnect</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d4edda;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .container {
            width: 50%;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }

        .product-image {
            width: 100%;
            max-width: 300px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        h3 {
            color: #333;
            margin-bottom: 10px;
        }

        p {
            color: #666;
            margin-bottom: 10px;
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
            margin-top: 20px;
        }

        .btn:hover {
            background-color: #4cae4c;
        }

        .confirm-animation {
            display: none;
            font-size: 24px;
            font-weight: bold;
            color: #5cb85c;
        }
    </style>
    <script>
        function showConfirmation() {
            var button = document.querySelector('.btn');
            var animation = document.querySelector('.confirm-animation');

            button.style.display = 'none';
            animation.style.display = 'block';
        }
    </script>
</head>
<body>
    <div class="container">
        <%
            HttpSession session2 = request.getSession();
            User user = (User) session2.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            ProductDao productDao = new ProductDao();
            String productIdParam = request.getParameter("id");
            if (productIdParam == null || productIdParam.isEmpty()) {
                out.println("<h2>Error: Product ID is missing.</h2>");
            } else {
                try {
                    int productId = Integer.parseInt(productIdParam);
                    Product product = productDao.getProductById(productId);
                    if (product == null) {
                        out.println("<h2>Error: Product not found.</h2>");
                    } else {
        %>
        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>" class="product-image">
        <h3><%= product.getName() %></h3>
        <p>Price: ₹<%= product.getPrice() %></p>
        <p>Quantity: <%= product.getQuantity() %></p>
        <p>Description: <%= product.getDescription() %></p>
        <form action="purchaseAction" method="post" onsubmit="showConfirmation()">
            <input type="hidden" name="productId" value="<%= product.getId() %>">
            <input type="submit" value="Confirm Purchase" class="btn">
        </form>
        <div class="confirm-animation">Thank you for your purchase!</div>
        <%
                    }
                } catch (NumberFormatException e) {
                    out.println("<h2>Error: Invalid Product ID.</h2>");
                }
            }
        %>
    </div>
</body>
</html>