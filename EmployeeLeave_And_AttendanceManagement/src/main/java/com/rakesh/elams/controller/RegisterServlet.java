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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    UserDao userDao = new UserDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        String password = request.getParameter("password");

        User user = new User();

        user.setEmail(email);

        user.setPwd(password);

        user.setRole("employee");

        boolean status = userDao.addUser(user);

        if (status) {

            request.setAttribute("successMessage",
                    "Registration Successful. Please Login.");

            request.getRequestDispatcher("login.jsp")
                    .forward(request, response);

        } else {

            request.setAttribute("errorMessage",
                    "Registration Failed.");

            request.getRequestDispatcher("login.jsp")
                    .forward(request, response);

        }

    }

}