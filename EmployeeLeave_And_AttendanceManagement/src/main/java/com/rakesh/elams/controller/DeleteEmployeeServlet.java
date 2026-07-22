package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.EmployeeDao;
import com.rakesh.elams.dao.EmployeeDaoImpl;
import com.rakesh.elams.dao.UserDao;
import com.rakesh.elams.dao.UserDaoImpl;
import com.rakesh.elams.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private EmployeeDao employeeDao;
	private UserDao userDao;

	@Override
	public void init() throws ServletException {

		employeeDao = new EmployeeDaoImpl();

		userDao = new UserDaoImpl();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int employeeId = Integer.parseInt(req.getParameter("id"));

		/*
		 * ======================================================== GET EMPLOYEE FIRST
		 * ========================================================
		 *
		 * We need the email because user table uses email.
		 *
		 * ========================================================
		 */

		Employee employee = employeeDao.getEmployeeById(employeeId);

		if (employee != null) {

			String email = employee.getEmail();

			/*
			 * ==================================================== DELETE EMPLOYEE
			 * ====================================================
			 */

			boolean employeeDeleted = employeeDao.deleteEmployee(employeeId);

			/*
			 * ==================================================== DELETE USER LOGIN
			 * ====================================================
			 */

			if (employeeDeleted && email != null && !email.trim().isEmpty()) {

				userDao.deleteUserByEmail(email);
			}
		}

		res.sendRedirect("viewEmployeesServlet");
	}

}
