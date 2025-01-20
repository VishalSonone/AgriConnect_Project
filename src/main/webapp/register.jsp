<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - AgriConnect</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d4edda;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        .container {
            width: 400px;
            background-color: white;
            padding: 30px 20px 30px; /* Adjusted padding for spacing around inputs */
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        h2 {
            margin-bottom: 20px;
            color: #5cb85c;
        }

        .form-group {
            margin-bottom: 20px; /* Increased margin to prevent touching */
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        .form-group input, 
        .form-group select {
            width: 85%;
            padding: 12px; /* Increased padding to prevent inputs touching edges */
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1);
            font-size: 14px;
        }

        .btn {
            width: auto; /* Adjust width to be smaller than the inputs */
            padding: 10px 20px; /* Adjust button padding */
            background-color: #5cb85c;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin: 0 auto; /* Center the button */
            display: block;
        }

        .btn:hover {
            background-color: #4cae4c;
        }

        footer {
            margin-top: 20px;
            text-align: center;
            color: #555;
            font-size: 12px;
            width: 100%; /* Ensures the footer stretches across the page */
            position: absolute;
            bottom: 0;
        }
    </style>
    <script>
        // Function to show popup message based on the result
        function showPopup(message, isSuccess) {
            alert(message); // Using a simple alert to show success or failure message
            if (isSuccess) {
                // You can redirect to a different page on success, if necessary
                window.location.href = "login.jsp"; // Redirect to login page on success
            } else {
                // Optionally, you can clear form fields or reset the form
                document.querySelector('form').reset();
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form action="register" method="post">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="role">Role</label>
                <select id="role" name="role" required>
                    <option value="FARMER">Farmer</option>
                    <option value="BUYER">Buyer</option>
                </select>
            </div>
            <button type="submit" class="btn">Register</button>
        </form>
    </div>
    <footer>
        <p>&copy; 2025 AgriConnect. All rights reserved.</p>
    </footer>
    
    <%
        // Handling registration status passed from the backend (for demonstration)
        String registrationStatus = (String) request.getAttribute("registrationStatus"); // Assume this attribute is set in the backend
        if ("success".equals(registrationStatus)) {
    %>
        <script>
            showPopup('Registration Successful!', true);
        </script>
    <%
        } else if ("failure".equals(registrationStatus)) {
    %>
        <script>
            showPopup('Registration Failed. Please try again.', false);
        </script>
    <%
        }
    %>
</body>
</html>