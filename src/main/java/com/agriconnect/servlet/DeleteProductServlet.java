package com.agriconnect.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.agriconnect.dao.ProductDao;

@WebServlet("/deleteProductAction")
public class DeleteProductServlet extends HttpServlet {
    private ProductDao productDao = new ProductDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDao.deleteProduct(id);
        response.sendRedirect("profile.jsp");
    }
}