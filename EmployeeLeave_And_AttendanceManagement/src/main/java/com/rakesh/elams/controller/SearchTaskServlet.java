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

@WebServlet("/SearchTaskServlet")
public class SearchTaskServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private TaskDao dao = new TaskDaoImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String taskId = request.getParameter("taskId");

		String emp = request.getParameter("employeeId");

		Integer employeeId = null;

		if (emp != null && !emp.isBlank()) {
			employeeId = Integer.parseInt(emp);
		}

		String status = request.getParameter("status");

		String priority = request.getParameter("priority");

		List<Task> tasks = dao.searchTasks(taskId, employeeId, status, priority);

		request.setAttribute("tasks", tasks);

		request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
	}
}