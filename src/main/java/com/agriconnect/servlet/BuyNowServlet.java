package com.agriconnect.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.agriconnect.dao.PurchaseDao;
import com.agriconnect.dto.Purchase;
import com.agriconnect.dto.User;

@WebServlet("/purchaseAction")
public class BuyNowServlet extends HttpServlet {
    private PurchaseDao purchaseDao = new PurchaseDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && "BUYER".equals(user.getRole())) {
            String productIdParam = request.getParameter("productId");
            if (productIdParam != null && !productIdParam.isEmpty()) {
                try {
                    int productId = Integer.parseInt(productIdParam);

                    Purchase purchase = new Purchase();
                    purchase.setUserId(user.getId());
                    purchase.setProductId(productId);
                    purchase.setPurchaseDate(new java.util.Date());

                    purchaseDao.addPurchase(purchase);
                    response.sendRedirect("profile.jsp");
                } catch (NumberFormatException e) {
                    response.sendRedirect("buyNow.jsp?id=" + productIdParam + "&error=invalidId");
                }
            } else {
                response.sendRedirect("buyNow.jsp?error=missingId");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}