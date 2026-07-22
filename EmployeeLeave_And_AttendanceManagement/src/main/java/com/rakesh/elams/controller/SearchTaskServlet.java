package com.rakesh.elams.controller;

import java.io.IOException;
import java.util.List;

import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;
import com.rakesh.elams.model.Task;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SearchTaskServlet")
public class SearchTaskServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private TaskDao dao = new TaskDaoImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Bug fix: this servlet had no session/role check at all, and never
		// scoped the search to the logged-in manager, so anyone could search
		// across every manager's tasks.
		HttpSession session = request.getSession(false);
		String role = (session != null) ? (String) session.getAttribute("role") : null;

		if (role == null || !"MANAGER".equalsIgnoreCase(role)) {
			response.sendRedirect("login.jsp");
			return;
		}

		Integer managerId = (Integer) session.getAttribute("employeeId");

		if (managerId == null) {
			// No manager identity on the session — fail safe with an empty list
			// rather than falling through to an unscoped search.
			request.setAttribute("tasks", List.of());
			request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
			return;
		}

		String taskId = request.getParameter("taskId");

		String emp = request.getParameter("employeeId");

		Integer employeeId = null;

		if (emp != null && !emp.isBlank()) {
			employeeId = Integer.parseInt(emp);
		}

		String status = request.getParameter("status");

		String priority = request.getParameter("priority");

		List<Task> tasks = dao.searchTasks(managerId, taskId, employeeId, status, priority);

		request.setAttribute("tasks", tasks);

		request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
	}
}