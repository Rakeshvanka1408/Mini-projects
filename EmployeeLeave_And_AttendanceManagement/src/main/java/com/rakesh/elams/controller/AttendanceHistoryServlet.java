package com.rakesh.elams.controller;

import java.io.IOException;
import java.util.List;

import com.rakesh.elams.dao.AttendanceDao;
import com.rakesh.elams.dao.AttendanceDaoImpl;
import com.rakesh.elams.model.Attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attendanceHistory")
public class AttendanceHistoryServlet extends HttpServlet {

	private AttendanceDao attendanceDao;

	@Override
	public void init() {
		attendanceDao = new AttendanceDaoImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int employeeId = Integer.parseInt(request.getParameter("employeeId"));

		List<Attendance> attendanceList = attendanceDao.getAttendanceByEmployee(employeeId);

		request.setAttribute("attendanceList", attendanceList);

		request.getRequestDispatcher("attendanceHistory.jsp").forward(request, response);
	}
}