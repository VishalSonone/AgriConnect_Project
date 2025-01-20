package com.agriconnect.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.agriconnect.dao.ProductDao;
import com.agriconnect.dto.Product;
import com.agriconnect.dto.User;

@WebServlet("/addProduct")
public class AddProductServlet extends HttpServlet {
    private ProductDao productDao = new ProductDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && "FARMER".equals(user.getRole())) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String imageUrl = request.getParameter("imageUrl");

            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setImageUrl(imageUrl);
            product.setUserId(user.getId());

            productDao.addProduct(product);
            response.sendRedirect("products.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}