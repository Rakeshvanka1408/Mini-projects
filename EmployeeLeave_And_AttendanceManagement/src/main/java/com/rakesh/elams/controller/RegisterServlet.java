package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.UserDao;
import com.rakesh.elams.dao.UserDaoImpl;
import com.rakesh.elams.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDaoImpl();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Get form values
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        HttpSession session = request.getSession();

        // ============================================
        // VALIDATE INPUT
        // ============================================

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || role == null || role.trim().isEmpty()) {

            session.setAttribute(
                    "registerError",
                    "All fields are required."
            );

            response.sendRedirect("register.jsp");
            return;
        }

        // ============================================
        // CREATE USER OBJECT
        // ============================================

        User user = new User();

        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPwd(password);
        user.setRole(role.trim().toUpperCase());

        // ============================================
        // CREATE EMPLOYEE + USER
        // ============================================

        /*
         * This method inserts:
         *
         * 1. Employee details into employees table
         * 2. Login details into user table
         *
         * Both operations happen in one transaction.
         */

        boolean success =
                userDao.createUserAndEmployee(
                        user,
                        name.trim()
                );

        // ============================================
        // SUCCESS
        // ============================================

        if (success) {

            session.setAttribute(
                    "registerSuccess",
                    "Account created successfully. Please login."
            );

            response.sendRedirect("login.jsp");

        }

        // ============================================
        // FAILURE
        // ============================================

        else {

            session.setAttribute(
                    "registerError",
                    "Unable to create account. Email may already exist."
            );

            response.sendRedirect("register.jsp");
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("register.jsp");
    }
}