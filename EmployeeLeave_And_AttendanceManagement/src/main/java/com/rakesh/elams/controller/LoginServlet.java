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

            // Store logged-in user
            session.setAttribute("loggedUser", user);

            // Store role
            session.setAttribute("role", user.getRole());

            if ("admin".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect("adminDashboardServlet");

            } else {

                response.sendRedirect("employeeDashboardServlet");
            }

        } else {

            request.setAttribute("errorMessage",
                    "Invalid Email or Password");

            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
        }
    }
}