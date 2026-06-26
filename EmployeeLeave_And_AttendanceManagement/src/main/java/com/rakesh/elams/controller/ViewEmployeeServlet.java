package com.rakesh.elams.controller;

import java.io.IOException;
import java.util.List;

import com.rakesh.elams.dao.EmployeeDao;
import com.rakesh.elams.dao.EmployeeDaoImpl;
import com.rakesh.elams.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewEmployeesServlet")
public class ViewEmployeeServlet
        extends HttpServlet {

    private EmployeeDao employeeDao;

    public void init() {
        employeeDao = new EmployeeDaoImpl();
    }

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Employee> employees =
                employeeDao.getAllEmployees();

        request.setAttribute(
                "employees",
                employees);

        request.getRequestDispatcher(
                "employees.jsp")
                .forward(request, response);
    }
}