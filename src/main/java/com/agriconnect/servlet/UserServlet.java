package com.agriconnect.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.agriconnect.dao.UserDao;
import com.agriconnect.dto.User;

import java.io.IOException;

//@WebServlet("/register")
public class UserServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validate input
        if (name == null || email == null || password == null || role == null) {
            response.sendRedirect("register.jsp?error=Please fill all fields");
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role); // Keep role as a String

        // Add user to the database
        userDao.addUser (user);
        response.sendRedirect("login.jsp?success=Registration successful");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET requests if needed (e.g., for displaying registration form)
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}