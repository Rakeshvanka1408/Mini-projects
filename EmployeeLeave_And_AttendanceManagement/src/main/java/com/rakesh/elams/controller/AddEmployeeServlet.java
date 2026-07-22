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

@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDaoImpl();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ============================================
        // GET FORM DATA
        // ============================================

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneString = request.getParameter("phone");
        String department = request.getParameter("department");
        String designation = request.getParameter("designation");
        String managerIdString = request.getParameter("managerId");

        // ============================================
        // VALIDATION
        // ============================================

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || phoneString == null || phoneString.trim().isEmpty()
                || managerIdString == null
                || managerIdString.trim().isEmpty()) {

            request.setAttribute(
                    "errorMessage",
                    "Please fill all required fields, including Manager."
            );

            request.getRequestDispatcher(
                    "addEmployee.jsp"
            ).forward(request, response);

            return;
        }

        // ============================================
        // PARSE PHONE
        // ============================================

        long phone;

        try {

            phone = Long.parseLong(
                    phoneString.trim()
            );

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "errorMessage",
                    "Invalid phone number."
            );

            request.getRequestDispatcher(
                    "addEmployee.jsp"
            ).forward(request, response);

            return;
        }

        // ============================================
        // PARSE MANAGER ID
        // ============================================

        int managerId;

        try {

            managerId = Integer.parseInt(
                    managerIdString.trim()
            );

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "errorMessage",
                    "Invalid manager selected."
            );

            request.getRequestDispatcher(
                    "addEmployee.jsp"
            ).forward(request, response);

            return;
        }

        // ============================================
        // CREATE DEFAULT PASSWORD
        // ============================================

        String defaultPassword = "Welcome@123";

        // ============================================
        // CREATE USER OBJECT
        // ============================================

        User user = new User();

        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPwd(defaultPassword);
        user.setRole("EMPLOYEE");

        // ============================================
        // CREATE EMPLOYEE + USER
        // ============================================

        boolean success = userDao.createEmployeeAndUser(
                user,
                name.trim(),
                phone,
                department,
                designation,
                managerId
        );

        // ============================================
        // RESULT
        // ============================================

        if (success) {

            request.setAttribute(
                    "successMessage",
                    "Employee added successfully. "
                    + "Login account created. "
                    + "Default password: Welcome@123"
            );

        } else {

            request.setAttribute(
                    "errorMessage",
                    "Failed to add employee. "
                    + "The email may already exist."
            );
        }

        request.getRequestDispatcher(
                "addEmployee.jsp"
        ).forward(
                request,
                response
        );
    }
}