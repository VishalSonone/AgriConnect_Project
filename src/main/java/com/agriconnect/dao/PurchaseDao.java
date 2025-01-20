package com.agriconnect.dao;

import com.agriconnect.dto.Purchase;
import com.agriconnect.dto.Product;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PurchaseDao {
    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("agriconnect");
    private static final Logger logger = LoggerFactory.getLogger(PurchaseDao.class);

    public void addPurchase(Purchase purchase) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(purchase);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error("Error adding purchase", e);
        } finally {
            entityManager.close();
        }
    }

    public boolean isProductPurchased(int productId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Long> query = entityManager.createQuery("SELECT COUNT(p) FROM Purchase p WHERE p.productId = :productId", Long.class);
            query.setParameter("productId", productId);
            return query.getSingleResult() > 0;
        } finally {
            entityManager.close();
        }
    }

    public List<Product> getPurchasedProductsByUserId(int userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            String jpql = "SELECT p FROM Product p JOIN Purchase pu ON p.id = pu.productId WHERE pu.userId = :userId";
            TypedQuery<Product> query = entityManager.createQuery(jpql, Product.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    public List<Product> getSoldProductsByUserId(int userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            String jpql = "SELECT p FROM Product p WHERE p.id IN (SELECT pu.productId FROM Purchase pu WHERE p.userId = :userId)";
            TypedQuery<Product> query = entityManager.createQuery(jpql, Product.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }
}