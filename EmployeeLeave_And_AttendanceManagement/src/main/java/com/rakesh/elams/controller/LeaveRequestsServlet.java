package com.rakesh.elams.controller;

import java.io.IOException;
import java.util.List;

import com.rakesh.elams.dao.LeaveDao;
import com.rakesh.elams.dao.LeaveDaoImpl;
import com.rakesh.elams.model.Leave;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/leaveRequests")
public class LeaveRequestsServlet extends HttpServlet {

	private LeaveDao leaveDAO;

	@Override
	public void init() {
		leaveDAO = new LeaveDaoImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Leave> pendingLeaves = leaveDAO.getPendingLeaves();

		request.setAttribute("pendingLeaves", pendingLeaves);

		request.getRequestDispatcher("leaveRequests.jsp").forward(request, response);
	}
}