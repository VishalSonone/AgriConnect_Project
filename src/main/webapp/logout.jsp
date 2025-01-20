<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d4edda;
            text-align: center;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .message {
            margin: 20px;
            font-size: 18px;
            color: #333;
        }
        .btn {
            padding: 10px 20px;
            background-color: #5cb85c;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #4cae4c;
        }
    </style>
</head>
<body>

    <h2>You have been logged out successfully.</h2>
    <p class="message">Thank you for using our service!</p>
    <a href="login.jsp" class="btn">Login Again</a>

</body>
</html>