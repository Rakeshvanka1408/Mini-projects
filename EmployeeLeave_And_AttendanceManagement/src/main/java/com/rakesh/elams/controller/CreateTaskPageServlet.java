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
import jakarta.servlet.http.HttpSession;

@WebServlet("/CreateTaskPageServlet")
public class CreateTaskPageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        Integer managerEmployeeId =
                (Integer) session.getAttribute("employeeId");

        System.out.println("Manager Employee ID = " + managerEmployeeId);

        EmployeeDao dao = new EmployeeDaoImpl();

        List<Employee> employees =
                dao.getEmployeesByManager(managerEmployeeId);

        System.out.println("Employees Count = " + employees.size());

        request.setAttribute("employees", employees);

        request.getRequestDispatcher("createTask.jsp")
               .forward(request, response);
    }
}