package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.LeaveDao;
import com.rakesh.elams.dao.LeaveDaoImpl;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rejectLeave")
public class RejectLeaveServlet extends HttpServlet {

	private LeaveDao leaveDAO;

	@Override
	public void init() {
		leaveDAO = new LeaveDaoImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int leaveId = Integer.parseInt(request.getParameter("leaveId"));

		leaveDAO.updateLeaveStatus(leaveId, "Rejected");

		response.sendRedirect("leaveRequests");
	}
}