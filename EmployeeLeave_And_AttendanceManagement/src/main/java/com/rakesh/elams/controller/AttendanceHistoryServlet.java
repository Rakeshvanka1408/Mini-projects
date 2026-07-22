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
	protected void doGet(HttpServletRequest request,
	        HttpServletResponse response)
	        throws ServletException, IOException {

	    int employeeId =
	            Integer.parseInt(
	                    request.getParameter("employeeId"));

	    List<Attendance> attendanceList =
	            attendanceDao.getAttendanceByEmployee(employeeId);

	    int present = 0;
	    int absent = 0;
	    int halfDay = 0;

	    for (Attendance attendance : attendanceList) {

	        String status = attendance.getStatus();

	        if ("Present".equalsIgnoreCase(status)) {
	            present++;
	        }
	        else if ("Absent".equalsIgnoreCase(status)) {
	            absent++;
	        }
	        else if ("Half Day".equalsIgnoreCase(status)
	                || "Half_Day".equalsIgnoreCase(status)
	                || "HALF_DAY".equalsIgnoreCase(status)) {
	            halfDay++;
	        }
	    }

	    request.setAttribute("present", present);
	    request.setAttribute("absent", absent);
	    request.setAttribute("halfDay", halfDay);

	    request.setAttribute("attendanceList", attendanceList);

	    request.getRequestDispatcher(
	            "attendanceHistory.jsp")
	            .forward(request, response);
	}
}