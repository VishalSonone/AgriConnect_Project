package com.agriconnect.dao;

import com.agriconnect.dto.Product;
import com.agriconnect.dto.Purchase;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.persistence.EntityTransaction;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProductDao {
    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("agriconnect");
    private static final Logger logger = LoggerFactory.getLogger(ProductDao.class);

    public List<Product> getAllProducts() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p", Product.class);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error getting all products", e);
            return null;
        } finally {
            entityManager.close();
        }
    }

    public Product getProductById(int id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(Product.class, id);
        } catch (Exception e) {
            logger.error("Error getting product by ID", e);
            return null;
        } finally {
            entityManager.close();
        }
    }

    public void addProduct(Product product) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(product);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error("Error adding product", e);
        } finally {
            entityManager.close();
        }
    }

    public void updateProduct(Product product) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Product existingProduct = entityManager.find(Product.class, product.getId());
            if (existingProduct != null) {
                existingProduct.setName(product.getName());
                existingProduct.setDescription(product.getDescription());
                existingProduct.setPrice(product.getPrice());
                existingProduct.setQuantity(product.getQuantity());
                existingProduct.setImageUrl(product.getImageUrl());
                entityManager.merge(existingProduct);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error("Error updating product", e);
        } finally {
            entityManager.close();
        }
    }

    public void deleteProduct(int id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            String deletePurchasesQuery = "DELETE FROM Purchase pu WHERE pu.productId = :productId";
            entityManager.createQuery(deletePurchasesQuery)
                         .setParameter("productId", id)
                         .executeUpdate();
            Product product = entityManager.find(Product.class, id);
            if (product != null) {
                entityManager.remove(product);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error("Error deleting product", e);
        } finally {
            entityManager.close();
        }
    }

    public List<Product> getAllProductsByUserId(int userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p WHERE p.userId = :userId", Product.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error getting products by user ID", e);
            return null;
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
        } catch (Exception e) {
            logger.error("Error getting purchased products by user ID", e);
            return null;
        } finally {
            entityManager.close();
        }
    }
}