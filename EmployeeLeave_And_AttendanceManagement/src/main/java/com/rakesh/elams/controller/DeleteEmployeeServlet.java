package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.EmployeeDao;
import com.rakesh.elams.dao.EmployeeDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {

    private EmployeeDao employeeDao;

    @Override
    public void init() {
        employeeDao = new EmployeeDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {

        int employeeId =
                Integer.parseInt(req.getParameter("id"));

        employeeDao.deleteEmployee(employeeId);

        res.sendRedirect("viewEmployeesServlet");
    }
}