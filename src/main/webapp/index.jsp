<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriConnect - Home</title>
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
            margin-left:20px;
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
            margin-right:5px;
        }

        .nav a:hover {
            background-color: #4cae4c;
        }

        .container {
            text-align: center;
            padding: 20px;
            flex-grow: 1;
        }

        .image-section {
            margin: 20px 0;
        }

        .image-section img {
            max-width: 100%;
            border-radius: 10px;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
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
        <h1>Welcome to AgriConnect</h1>
        <div class="nav">
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
            <a href="products.jsp">Products</a>
        </div>
    </div>

    <div class="container">
        <h2>Connecting Farmers and Buyers</h2>
        <p>Browse and purchase products directly from local farmers.</p>

        <div class="image-section">
            <img src="images/back-img.png" alt="Agriculture Image"  height=410px width=500px>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
</body>
</html>
