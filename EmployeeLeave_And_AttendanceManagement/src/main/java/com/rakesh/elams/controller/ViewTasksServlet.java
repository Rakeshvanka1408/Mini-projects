package com.rakesh.elams.controller;

import java.io.IOException;
import java.util.List;

import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;
import com.rakesh.elams.model.Task;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ViewTasksServlet")
public class ViewTasksServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	TaskDao dao = new TaskDaoImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("ViewTasksServlet reached");

		HttpSession session = request.getSession(false);

		Integer managerId = (Integer) session.getAttribute("employeeId");

		System.out.println("Logged in manager employeeId = " + managerId);

		List<Task> tasks = dao.getTasksByManager(managerId);

		request.setAttribute("tasks", tasks);

		request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
	}
}