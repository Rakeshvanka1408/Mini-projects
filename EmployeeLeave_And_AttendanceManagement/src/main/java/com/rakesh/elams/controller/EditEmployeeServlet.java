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

@WebServlet("/editEmployee")
public class EditEmployeeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private EmployeeDao employeeDao;

	@Override
	public void init() throws ServletException {

		employeeDao = new EmployeeDaoImpl();
	}

	/*
	 * ============================================================ SHOW EDIT
	 * EMPLOYEE PAGE ============================================================
	 */

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idString = request.getParameter("id");

		if (idString == null || idString.trim().isEmpty()) {

			response.sendRedirect("viewEmployeesServlet");

			return;
		}

		int employeeId;

		try {

			employeeId = Integer.parseInt(idString.trim());

		} catch (NumberFormatException e) {

			response.sendRedirect("viewEmployeesServlet");

			return;
		}

		/*
		 * ======================================================== GET EMPLOYEE
		 * ========================================================
		 */

		Employee employee = employeeDao.getEmployeeById(employeeId);

		if (employee == null) {

			response.sendRedirect("viewEmployeesServlet");

			return;
		}

		/*
		 * ======================================================== GET ALL MANAGERS
		 * ========================================================
		 */

		List<Employee> managers = employeeDao.getAllManagers();

		/*
		 * ======================================================== SEND DATA TO JSP
		 * ========================================================
		 */

		request.setAttribute("employee", employee);

		request.setAttribute("managers", managers);

		request.getRequestDispatcher("editEmployee.jsp").forward(request, response);
	}

	/*
	 * ============================================================ UPDATE EMPLOYEE
	 * ============================================================
	 */

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		/*
		 * ======================================================== GET FORM DATA
		 * ========================================================
		 */

		String idString = request.getParameter("employeeId");

		String name = request.getParameter("name");

		String email = request.getParameter("email");

		String phoneString = request.getParameter("phone");

		String department = request.getParameter("department");

		String designation = request.getParameter("designation");

		String managerIdString = request.getParameter("managerId");

		/*
		 * ======================================================== VALIDATE REQUIRED
		 * FIELDS ========================================================
		 */

		if (idString == null || name == null || email == null || phoneString == null || managerIdString == null
				|| idString.trim().isEmpty() || name.trim().isEmpty() || email.trim().isEmpty()
				|| phoneString.trim().isEmpty() || managerIdString.trim().isEmpty()) {

			request.setAttribute("errorMessage", "Please fill all required fields.");

			reloadManagersAndForward(request, response);

			return;
		}

		/*
		 * ======================================================== PARSE VALUES
		 * ========================================================
		 */

		int employeeId;
		long phone;
		int managerId;

		try {

			employeeId = Integer.parseInt(idString.trim());

			phone = Long.parseLong(phoneString.trim());

			managerId = Integer.parseInt(managerIdString.trim());

		} catch (NumberFormatException e) {

			request.setAttribute("errorMessage", "Invalid employee ID, phone number, or manager.");

			reloadManagersAndForward(request, response);

			return;
		}

		/*
		 * ======================================================== CREATE EMPLOYEE
		 * OBJECT ========================================================
		 */

		Employee employee = new Employee();

		employee.setEmployee_id(employeeId);

		employee.setEmployee_name(name.trim());

		employee.setEmail(email.trim());

		employee.setPhone(phone);

		employee.setDepartment(department);

		employee.setDesignation(designation);

		employee.setManagerId(managerId);

		/*
		 * ======================================================== UPDATE DATABASE
		 * ========================================================
		 */

		boolean success = employeeDao.updateEmployee(employee);

		/*
		 * ======================================================== RESULT
		 * ========================================================
		 */

		if (success) {

			request.setAttribute("successMessage", "Employee updated successfully.");

		} else {

			request.setAttribute("errorMessage", "Failed to update employee.");
		}

		/*
		 * Reload employee and managers
		 */

		Employee updatedEmployee = employeeDao.getEmployeeById(employeeId);

		List<Employee> managers = employeeDao.getAllManagers();

		request.setAttribute("employee", updatedEmployee);

		request.setAttribute("managers", managers);

		request.getRequestDispatcher("editEmployee.jsp").forward(request, response);
	}

	/*
	 * ============================================================ HELPER METHOD
	 * ============================================================
	 */

	private void reloadManagersAndForward(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idString = request.getParameter("employeeId");

		if (idString != null) {

			try {

				int employeeId = Integer.parseInt(idString);

				Employee employee = employeeDao.getEmployeeById(employeeId);

				request.setAttribute("employee", employee);

			} catch (Exception e) {

				e.printStackTrace();
			}
		}

		List<Employee> managers = employeeDao.getAllManagers();

		request.setAttribute("managers", managers);

		request.getRequestDispatcher("editEmployee.jsp").forward(request, response);
	}
}