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

@WebServlet("/updateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (name == null || name.isEmpty() || email == null || email.isEmpty()) {
                request.setAttribute("errorMessage", "Name and Email are required.");
                request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
                return;
            }

            user.setName(name);
            user.setEmail(email);
            if (password != null && !password.isEmpty()) {
                user.setPassword(password);
            }

            boolean isUpdated = userDao.updateUser(user);
            if (isUpdated) {
                session.setAttribute("user", user);
                request.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            }
        } else {
            request.setAttribute("errorMessage", "You need to log in to update your profile.");
        }

        request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
    }
}