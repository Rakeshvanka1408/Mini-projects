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

@WebServlet("/ManagerViewEmployeesServlet")
public class ManagerViewEmployeesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDao dao = new EmployeeDaoImpl();

        List<Employee> employees = dao.getAllEmployees();

        request.setAttribute("employees", employees);

        request.getRequestDispatcher("managerEmployees.jsp")
               .forward(request, response);
    }
}