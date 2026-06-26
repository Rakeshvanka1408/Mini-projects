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

@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {

    private EmployeeDao employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDaoImpl();
    }

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Employee employee = new Employee();

        employee.setEmployee_name(
                request.getParameter("name"));

        employee.setEmail(
                request.getParameter("email"));

        employee.setPhone(Long.parseLong( request.getParameter("phone"))
               );

        employee.setDepartment(
                request.getParameter("department"));

        employee.setDesignation(
                request.getParameter("designation"));

        employeeDAO.addEmployee(employee);

        response.sendRedirect("viewEmployeesServlet");
    }
}