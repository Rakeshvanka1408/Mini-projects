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

@WebServlet("/EmployeeTasksServlet")
public class EmployeeTasksServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	TaskDao dao = new TaskDaoImpl();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("employeeId") == null) {

			response.sendRedirect("login.jsp");
			return;
		}

		int employeeId = (Integer) session.getAttribute("employeeId");

		List<Task> tasks = dao.getTasksByEmployee(employeeId);

		request.setAttribute("tasks", tasks);

		request.getRequestDispatcher("employeeTasks.jsp").forward(request, response);
	}
}