package com.agriconnect.dao;

import com.agriconnect.dto.User;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UserDao {

    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("agriconnect");
    private static final Logger logger = LoggerFactory.getLogger(UserDao.class);

    // Method to add a user to the database
    public boolean addUser(User user) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(user);
            transaction.commit();
            logger.info("User added successfully: {}", user.getEmail());
            return true;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error("Error adding user", e);
            return false;
        } finally {
            entityManager.close();
        }
    }

    // Method to get a user by email
    public User getUserByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<User> query = entityManager.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);
            User user = query.getSingleResult();
            logger.info("User fetched by email: {}", email);
            return user;
        } catch (NoResultException e) {
            logger.warn("No user found with email: {}", email);
            return null;
        } catch (Exception e) {
            logger.error("Error getting user by email: {}", email, e);
            return null;
        } finally {
            entityManager.close();
        }
    }

    // Method to get a user by ID
    public User getUserById(int id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            User user = entityManager.find(User.class, id);
            if (user != null) {
                logger.info("User fetched by ID: {}", id);
            } else {
                logger.warn("User with ID {} not found", id);
            }
            return user;
        } catch (Exception e) {
            logger.error("Error getting user by ID: {}", id, e);
            return null;
        } finally {
            entityManager.close();
        }
    }

    // Method to update a user
    public boolean updateUser(User user) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(user);
            transaction.commit();
            logger.info("User updated successfully: {}", user.getEmail());
            return true;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error("Error updating user", e);
            return false;
        } finally {
            entityManager.close();
        }
    }

    // Method to delete a user by ID
    public boolean deleteUser(int userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            User user = entityManager.find(User.class, userId);
            if (user != null) {
                entityManager.remove(user);
                logger.info("User deleted successfully: {}", userId);
                transaction.commit();
                return true;
            } else {
                logger.warn("User with ID {} not found for deletion", userId);
                return false;
            }
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error("Error deleting user", e);
            return false;
        } finally {
            entityManager.close();
        }
    }
}