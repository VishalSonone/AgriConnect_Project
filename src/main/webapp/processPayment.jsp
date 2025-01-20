<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.agriconnect.dao.ProductDao" %>
<%@ page import="com.agriconnect.dao.UserDao" %>
<%@ page import="com.agriconnect.dao.PurchaseDao" %>
<%@ page import="com.agriconnect.dto.Product" %>
<%@ page import="com.agriconnect.dto.User" %>
<%@ page import="com.agriconnect.dto.Purchase" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Processing - AgriConnect</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            overflow: hidden; /* Remove scrollbar from the entire page */
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 10px;
            text-align: right;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .header a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
        }
        .header a:hover {
            text-decoration: underline;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .message-box {
            width: 50%;
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-sizing: border-box;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn {
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            width: 100%;
            box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px 8px 0 0;
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
        <div class="message-box">
            <%
                int productId = Integer.parseInt(request.getParameter("productId"));
                int buyerId = Integer.parseInt(request.getParameter("buyerId"));
                ProductDao productDao = new ProductDao();
                UserDao userDao = new UserDao();
                PurchaseDao purchaseDao = new PurchaseDao();
                
                Product product = productDao.getProductById(productId);
                User buyer = userDao.getUserById(buyerId);
                
                if (product != null && buyer != null) {
                    // Create a new purchase record
                    Purchase purchase = new Purchase();
                    purchase.setProductId(product.getId());
                    purchase.setUserId(buyer.getId());
                    purchase.setPurchaseDate(new Date());
                    purchaseDao.addPurchase(purchase);

                    // Display success message
                    out.println("<h2>Payment Successful!</h2>");
                    out.println("<p>Thank you for your purchase. The product has been marked as purchased in your profile and as sold in the farmer's profile.</p>");
                } else {
                    // Display error message if product or buyer is null
                    out.println("<h2>Payment Failed!</h2>");
                    out.println("<p>There was an issue processing your payment. Please try again.</p>");
                }
            %>
            <a href="products.jsp" class="btn">Back to Products</a>
        </div>
    </div>
    <footer class="footer">
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
</body>
</html>