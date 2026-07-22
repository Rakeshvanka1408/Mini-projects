package com.rakesh.elams.controller;

import java.io.IOException;
import java.util.List;

import com.rakesh.elams.dao.PerformanceDao;
import com.rakesh.elams.dao.PerformanceDaoImpl;
import com.rakesh.elams.model.EmployeePerformance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PerformanceServlet")
public class PerformanceServlet extends HttpServlet {

    private PerformanceDao performanceDao;

    @Override
    public void init() throws ServletException {
        performanceDao = new PerformanceDaoImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role =
                (String) session.getAttribute("role");

        if (role == null ||
            !role.equalsIgnoreCase("MANAGER")) {

            response.sendRedirect("login.jsp");
            return;
        }

        Integer managerId =
                (Integer) session.getAttribute("employeeId");

        if (managerId == null || managerId <= 0) {

            response.sendRedirect(
                "login.jsp?error=Manager ID not found");

            return;
        }

        System.out.println(
            "Performance Manager ID = " + managerId
        );

        List<EmployeePerformance> performanceList =
                performanceDao
                .getManagerEmployeePerformance(managerId);

        request.setAttribute(
            "performanceList",
            performanceList
        );

        request.getRequestDispatcher(
            "performance.jsp"
        ).forward(request, response);
    }
}