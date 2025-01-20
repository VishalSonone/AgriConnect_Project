package com.agriconnect.servlet;

import com.agriconnect.dao.UserDao;
import com.agriconnect.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        boolean isUserAdded = userDao.addUser(user);

        if (isUserAdded) {
            request.setAttribute("registrationStatus", "success");
        } else {
            request.setAttribute("registrationStatus", "failure");
        }

        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}