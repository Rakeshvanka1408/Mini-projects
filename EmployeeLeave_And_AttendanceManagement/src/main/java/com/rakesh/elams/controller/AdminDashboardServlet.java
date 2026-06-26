package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Date;

import com.rakesh.elams.dao.AttendanceDao;
import com.rakesh.elams.dao.AttendanceDaoImpl;
import com.rakesh.elams.dao.EmployeeDao;
import com.rakesh.elams.dao.EmployeeDaoImpl;
import com.rakesh.elams.dao.LeaveDao;
import com.rakesh.elams.dao.LeaveDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

	private EmployeeDao employeeDAO;
	private AttendanceDao attendanceDAO;
	private LeaveDao leaveDAO;

	@Override
	public void init() {

		employeeDAO = new EmployeeDaoImpl();
		attendanceDAO = new AttendanceDaoImpl();
		leaveDAO = new LeaveDaoImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null) {

			response.sendRedirect("login.jsp");

			return;
		}

		Date today = new Date(System.currentTimeMillis());

		int employeeCount = employeeDAO.getAllEmployees().size();

		int presentCount = attendanceDAO.getPresentCount(today);

		int absentCount = attendanceDAO.getAbsentCount(today);

		int pendingLeaves = leaveDAO.getPendingLeaves().size();

		request.setAttribute("employeeCount", employeeCount);

		request.setAttribute("presentCount", presentCount);

		request.setAttribute("absentCount", absentCount);

		request.setAttribute("pendingLeaves", pendingLeaves);

		request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
	}
}