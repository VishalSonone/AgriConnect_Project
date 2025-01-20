package com.agriconnect.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.agriconnect.dao.UserDao;
import com.agriconnect.dto.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(LoginServlet.class);
    private UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Log the email for debugging purposes
        logger.debug("Login attempt with email: {}", email);

        if (email == null || email.isEmpty()) {
            logger.warn("Email is null or empty");
            request.setAttribute("errorMessage", "Email cannot be empty.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (password == null || password.isEmpty()) {
            logger.warn("Password is null or empty");
            request.setAttribute("errorMessage", "Password cannot be empty.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User user = userDao.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("FARMER".equals(user.getRole())) {
                response.sendRedirect("profile.jsp");
            } else if ("BUYER".equals(user.getRole())) {
                response.sendRedirect("products.jsp");
            } else {
                // Default redirection if the role is not recognized
                response.sendRedirect("index.jsp");
            }
        } else {
            logger.warn("Invalid login attempt for email: {}", email);
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}