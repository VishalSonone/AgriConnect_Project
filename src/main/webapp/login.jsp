<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - AgriConnect</title>
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
            display: flex;
            width: 70%;
            height: 70%;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 5, 5, 2);
            overflow: hidden;
            animation: fadeIn 1.5s ease-in-out;
            background-color: white;
        }

        .left-box {
            flex: 1;
            background: url('images/left-box-img.png') no-repeat center center / cover;
            display: flex;
            justify-content: center;
            align-items: center;
            animation: slideInLeft 1.5s ease-in-out;
        }

        .right-box {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            animation: slideInRight 1.5s ease-in-out;
        }

        .right-box h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
            width: 90%;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .form-group label {
            width: 100%;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
            font-size: 14px;
        }

        .form-group button {
            width: auto;
            padding: 8px 20px;
            background-color: #5cb85c;
            border: none;
            color: white;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
            transition: background-color 0.3s ease;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
        }

        .form-group button:hover {
            background-color: #4cae4c;
        }

        p {
            margin-top: 10px;
            color: #333;
        }

        p a {
            color: #337ab7;
            text-decoration: none;
        }

        p a:hover {
            text-decoration: underline;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #5cb85c;
            color: white;
            font-size: 14px;
            position: absolute;
            bottom: 0;
            width: 100%;
            box-shadow: 0 -3px 5px rgba(0, 0, 0, 0.2);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes slideInLeft {
            from {
                transform: translateX(-100%);
                opacity: 0;
            }

            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }

            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Left Box with Background Image -->
        <div class="left-box">
            <h1 style="color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">Welcome to AgriConnect</h1>
        </div>
        <!-- Right Box with Login Form -->
        <div class="right-box">
            <h2>Login</h2>
            <form action="login" method="post">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <button type="submit">Login</button>
                </div>
            </form>
            <p>Don't have an account? <a href="register.jsp">Register here</a>.</p>
        </div>
    </div>
    <footer>
        © AgriConnect 2025
    </footer>
</body>
</html>