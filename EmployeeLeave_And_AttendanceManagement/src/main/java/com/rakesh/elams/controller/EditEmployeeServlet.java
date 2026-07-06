package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.EmployeeDao;
import com.rakesh.elams.dao.EmployeeDaoImpl;
import com.rakesh.elams.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/editEmployee")
public class EditEmployeeServlet extends HttpServlet {

    private EmployeeDao employeeDao;

    @Override
    public void init() {
        employeeDao = new EmployeeDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        Employee employee = employeeDao.getEmployeeById(id);

        req.setAttribute("employee", employee);

        req.getRequestDispatcher("editEmployee.jsp")
           .forward(req, res);
    }
}