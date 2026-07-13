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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null) {
            email = email.trim();
        }

        if (password != null) {
            password = password.trim();
        }

        User user = userDao.login(email, password);

        if (user != null) {

            HttpSession session = request.getSession(true);

            // Set all session attributes
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("employeeId", user.getEmployeeId());
            session.setAttribute("role", user.getRole());
            session.setAttribute("managerName", user.getName());
            session.setAttribute("username", user.getName()); // Also set username
            
            // Set session timeout to 30 minutes
            session.setMaxInactiveInterval(30 * 60);
            
            System.out.println("Session set - managerName: " + user.getName());
            System.out.println("Session ID: " + session.getId());

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("adminDashboard.jsp");
            } else if ("MANAGER".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("managerDashboard.jsp");
            } else if ("EMPLOYEE".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("employeeDashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=Invalid Role");
            }

        } else {
            response.sendRedirect("login.jsp?error=Invalid Username or Password");
        }
    }
}