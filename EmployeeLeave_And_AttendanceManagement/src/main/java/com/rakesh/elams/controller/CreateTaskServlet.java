package com.rakesh.elams.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;
import com.rakesh.elams.model.Task;
import com.rakesh.elams.model.Task.Priority;
import com.rakesh.elams.model.Task.Status;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/CreateTaskServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 20 * 1024 * 1024, maxRequestSize = 50 * 1024 * 1024)

public class CreateTaskServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	TaskDao dao = new TaskDaoImpl();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Task task = new Task();

		task.setTaskId(request.getParameter("taskId"));
		task.setTaskName(request.getParameter("taskName"));
		task.setDescription(request.getParameter("description"));

		task.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
		HttpSession session = request.getSession(false);

		task.setManagerId(session.getAttribute("userId").toString());
		task.setPriority(Priority.valueOf(request.getParameter("priority").toUpperCase()));

		task.setStatus(Status.valueOf(request.getParameter("status")));

		task.setAssignedDate(Date.valueOf(request.getParameter("assignedDate")));
		task.setDueDate(Date.valueOf(request.getParameter("dueDate")));

		Part filePart = request.getPart("taskFile");

		String fileName = "";

		if (filePart != null) {
			fileName = filePart.getSubmittedFileName();
		}

		String uploadPath = "D:/ELAMS_UPLOADS";
		File uploadDir = new File(uploadPath);

		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		if (fileName != null && !fileName.isEmpty()) {
			filePart.write(uploadPath + File.separator + fileName);
		}

		task.setDocumentPath(fileName);
		boolean result = dao.createTask(task);
	}
}