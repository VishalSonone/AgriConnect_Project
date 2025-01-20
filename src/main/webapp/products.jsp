<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="com.agriconnect.dto.Product" %>
<%@ page import="com.agriconnect.dao.ProductDao" %>
<%@ page import="com.agriconnect.dao.PurchaseDao" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.agriconnect.dto.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - AgriConnect</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d4edda;
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden; /* Make the page unscrollable */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .header {
            width: 100%;
            background-color: #5cb85c;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            border-radius: 0 0 15px 15px;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
           
        }

        .header a {
            text-decoration: none;
            color: white;
            font-weight: bold;
            padding: 5px 7px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            
            
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
        }

        .search-bar, .sort-bar {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }

        .search-bar input {
            width: 80%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .search-bar button, .sort-bar select {
            padding: 10px;
            background-color: #5cb85c;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .search-bar button:hover, .sort-bar select:hover {
            background-color: #4cae4c;
        }

        .product-box {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            height: 60vh; /* Set a fixed height for the product box */
            overflow-y: auto; /* Make the product box scrollable */
            padding: 20px; /* Add padding to the product box */
            justify-content: center;
        }

        .product-card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 28%; /* Adjusted width to fit three cards per row */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.2s ease-in-out;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-bottom:10px;
        }

        .product-card:hover {
            transform: scale(1.05);
        }

        .product-card img {
            width: 100%;
            height: 150px; /* Adjusted height to fit smaller cards */
            object-fit: cover;
        }

        .product-content {
            padding: 15px;
            display: flex;
            flex-direction: column;
            align-items: center; /* Center content horizontally */
            text-align: center; /* Center text */
        }

        .product-card h3 {
            margin: 0;
            font-size: 1.2em;
            color: #333;
        }

        .product-card p {
            margin: 10px 0;
            color: #666;
        }

        .product-card .price {
            font-size: 1.1em;
            color: #5cb85c;
            font-weight: bold;
        }

        .btn {
            width: 80px; /* Reduced width of the button */
            padding: 8px 8px 8px 8px; /* Adjusted padding */
            background-color: #5cb85c;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.2s ease-in-out;
            margin-top: 10px; /* Add margin to the top */
            align-self: center; /* Center button horizontally */
        }

        .btn:hover {
            background-color: #4cae4c;
        }

        .see-more {
            color: #007bff;
            cursor: pointer;
            text-decoration: underline;
            margin-top: 10px;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #5cb85c;
            color: white;
            border-radius: 15px 15px 0 0;
            box-shadow: 0 -3px 5px rgba(0, 0, 0, 0.2);
        }
    </style>
    <script>
        function toggleDescription(id) {
            var element = document.getElementById(id);
            var seeMoreLink = document.getElementById('see-more-' + id);
            if (element.classList.contains('expanded')) {
                element.classList.remove('expanded');
                seeMoreLink.innerText = 'See More';
            } else {
                element.classList.add('expanded');
                seeMoreLink.innerText = 'See Less';
            }
        }

        function sortProducts() {
            var sortBy = document.getElementById('sort-by').value;
            window.location.href = 'products.jsp?sort=' + sortBy;
        }

        function searchProducts() {
            var searchQuery = document.getElementById('search-query').value;
            window.location.href = 'products.jsp?search=' + searchQuery;
        }
    </script>
</head>
<body>
    <div class="header">
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Products</a>
        <a href="profile.jsp">Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>
    <div class="container">
        <%
            HttpSession session2 = request.getSession();
            User user = (User) session2.getAttribute("user");
            ProductDao productDao = new ProductDao();
            PurchaseDao purchaseDao = new PurchaseDao();
            List<Product> products = productDao.getAllProducts();

            String sortBy = request.getParameter("sort");
            if (sortBy != null) {
                if (sortBy.equals("priceAsc")) {
                    products.sort((p1, p2) -> Double.compare(p1.getPrice(), p2.getPrice()));
                } else if (sortBy.equals("priceDesc")) {
                    products.sort((p1, p2) -> Double.compare(p2.getPrice(), p1.getPrice()));
                } else if (sortBy.equals("nameAsc")) {
                    products.sort((p1, p2) -> p1.getName().compareTo(p2.getName()));
                } else if (sortBy.equals("nameDesc")) {
                    products.sort((p1, p2) -> p2.getName().compareTo(p1.getName()));
                }
            }

            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.isEmpty()) {
                products = products.stream()
                    .filter(p -> p.getName().toLowerCase().contains(searchQuery.toLowerCase()))
                    .collect(Collectors.toList());
            }

            if (user != null && "BUYER".equals(user.getRole())) {
        %>
        <div class="search-bar">
            <input type="text" id="search-query" placeholder="Search products...">
            <button onclick="searchProducts()">Search</button>
        </div>
        <div class="sort-bar">
            <label for="sort-by">Sort by:</label>
            <select id="sort-by" onchange="sortProducts()">
                <option value="">Select</option>
                <option value="priceAsc">Price: Low to High</option>
                <option value="priceDesc">Price: High to Low</option>
                <option value="nameAsc">Name: A to Z</option>
                <option value="nameDesc">Name: Z to A</option>
            </select>
        </div>
        <%
            }
        %>
        <h2>Available Products</h2>
        <div class="product-box">
            <%
                int productId = 1;
                for (Product product : products) {
                    if (!purchaseDao.isProductPurchased(product.getId())) {
            %>
            <div class="product-card">
                <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                <div class="product-content">
                    <h3><%= product.getName() %></h3>
                    <p class="price">Price: ₹<%= product.getPrice() %></p>
                    <p>Quantity: <%= product.getQuantity() %></p>
                    <p id="desc-<%= productId %>" class="description"><%= product.getDescription() %></p>
                    <span id="see-more-<%= productId %>" class="see-more" onclick="toggleDescription('<%= productId %>')">See More</span>
                </div>
                <%
                    if (user != null && "BUYER".equals(user.getRole())) {
                %>
                <a href="buyNow.jsp?id=<%= product.getId() %>" class="btn">Buy Now</a>
                <%
                    } else if (user != null && "FARMER".equals(user.getRole())) {
                %>
                <div class="product-content">
                    <p>Available in Market</p>
                </div>
                <%
                    }
                %>
            </div>
            <%
                    }
                    productId++;
                }
            %>
        </div>
    </div>
    <footer>
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
</body>
</html>