package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.EmployeeDao;
import com.rakesh.elams.dao.EmployeeDaoImpl;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet {

	private EmployeeDao employeeDao;

	public void inIt() {
		employeeDao = new EmployeeDaoImpl();
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {

		int employeeId = Integer.parseInt(req.getParameter("id"));
		boolean deleteEmployee = employeeDao.deleteEmployee(employeeId);
		res.sendRedirect("employee.jsp");
	}
}
