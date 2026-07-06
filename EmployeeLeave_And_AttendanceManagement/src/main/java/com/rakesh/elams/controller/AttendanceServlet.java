package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

import com.rakesh.elams.dao.AttendanceDao;
import com.rakesh.elams.dao.AttendanceDaoImpl;
import com.rakesh.elams.model.Attendance;
import com.rakesh.elams.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/markAttendance")
public class AttendanceServlet extends HttpServlet {

	private AttendanceDao attendanceDao;

	@Override
	public void init() {
		attendanceDao = new AttendanceDaoImpl();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		User user = (User) session.getAttribute("loggedUser");

		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Admin cannot mark attendance
		if ("admin".equalsIgnoreCase(user.getRole())) {
			request.setAttribute("errorMessage", "Admin cannot mark attendance.");
			request.getRequestDispatcher("attendance.jsp").forward(request, response);
			return;
		}

		// Attendance only for today's date
		LocalDate today = LocalDate.now();

		LocalDate selectedDate = LocalDate.parse(request.getParameter("attendanceDate"));

		if (!selectedDate.equals(today)) {

			request.setAttribute("errorMessage", "Attendance can be marked only for today's date.");

			request.getRequestDispatcher("attendance.jsp").forward(request, response);
			return;
		}

		LocalTime checkIn = LocalTime.parse(request.getParameter("checkIn"));

		LocalTime checkOut = LocalTime.parse(request.getParameter("checkOut"));

		// Check-in validation (10 AM - 11 AM)
		if (checkIn.isBefore(LocalTime.of(10, 0)) || checkIn.isAfter(LocalTime.of(11, 0))) {

			request.setAttribute("errorMessage", "Check-in is allowed only between 10:00 AM and 11:00 AM.");

			request.getRequestDispatcher("attendance.jsp").forward(request, response);
			return;
		}

		// Check-out validation (6 PM - 7 PM)
		if (checkOut.isBefore(LocalTime.of(18, 0)) || checkOut.isAfter(LocalTime.of(19, 0))) {

			request.setAttribute("errorMessage", "Check-out is allowed only between 6:00 PM and 7:00 PM.");

			request.getRequestDispatcher("attendance.jsp").forward(request, response);
			return;
		}

		// Check-out should be after Check-in
		if (!checkOut.isAfter(checkIn)) {

			request.setAttribute("errorMessage", "Check-out time must be after Check-in time.");

			request.getRequestDispatcher("attendance.jsp").forward(request, response);
			return;
		}

		Attendance attendance = new Attendance();

		attendance.setEmployee_id(Integer.parseInt(request.getParameter("employeeId")));

		attendance.setAttendance_date(Date.valueOf(today));

		attendance.setCheck_in_time(Time.valueOf(checkIn));

		attendance.setCheck_out_time(Time.valueOf(checkOut));

		attendance.setStatus(request.getParameter("status"));

		boolean success = attendanceDao.markAttendance(attendance);

		if (success) {

			request.setAttribute("successMessage", "Attendance marked successfully.");

		} else {

			request.setAttribute("errorMessage", "Unable to mark attendance.");
		}

		request.getRequestDispatcher("attendance.jsp").forward(request, response);
	}
}