package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Date;

import com.rakesh.elams.dao.AttendanceDao;
import com.rakesh.elams.dao.AttendanceDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attendanceReport")
public class AttendanceReportServlet extends HttpServlet {

	private AttendanceDao attendanceDAO;

	@Override
	public void init() {
		attendanceDAO = new AttendanceDaoImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Date date = Date.valueOf(request.getParameter("date"));

		int present = attendanceDAO.getPresentCount(date);

		int absent = attendanceDAO.getAbsentCount(date);

		int halfDay = attendanceDAO.getHalfDayCount(date);

		request.setAttribute("present", present);

		request.setAttribute("absent", absent);

		request.setAttribute("halfDay", halfDay);

		request.getRequestDispatcher("attendanceHistory.jsp").forward(request, response);
	}
}