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

@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet extends HttpServlet {

	private EmployeeDao employeeDao;

	@Override
	public void init() {
		employeeDao = new EmployeeDaoImpl();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		Employee employee = new Employee();

		employee.setEmployee_id(Integer.parseInt(req.getParameter("id")));
		employee.setEmployee_name(req.getParameter("name"));
		employee.setEmail(req.getParameter("email"));
		employee.setPhone(Long.parseLong(req.getParameter("phone")));
		employee.setDepartment(req.getParameter("department"));
		employee.setDesignation(req.getParameter("designation"));

		employeeDao.updateEmployee(employee);

		res.sendRedirect("viewEmployeesServlet");
	}
}