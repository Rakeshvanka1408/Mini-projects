package com.rakesh.elams.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

import com.rakesh.elams.dao.EmployeeDao;
import com.rakesh.elams.dao.EmployeeDaoImpl;
import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;
import com.rakesh.elams.model.Employee;
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
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 20 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024)
public class CreateTaskServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TaskDao dao = new TaskDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Task task = new Task();

        task.setTaskId(request.getParameter("taskId"));
        task.setTaskName(request.getParameter("taskName"));
        task.setDescription(request.getParameter("description"));

        task.setEmployeeId(
                Integer.parseInt(
                        request.getParameter("employeeId")));

        int managerId =
                (Integer) session.getAttribute("employeeId");

        task.setManagerId(managerId);

        task.setPriority(
                Priority.valueOf(
                        request.getParameter("priority")
                                .toUpperCase()));

        task.setStatus(
                Status.valueOf(
                        request.getParameter("status")
                                .toUpperCase()));

        task.setAssignedDate(
                Date.valueOf(
                        request.getParameter("assignedDate")));

        task.setDueDate(
                Date.valueOf(
                        request.getParameter("dueDate")));

        // File Upload
        Part filePart = request.getPart("taskFile");

        String fileName = null;

        if (filePart != null &&
                filePart.getSize() > 0) {

            fileName = filePart.getSubmittedFileName();

            String uploadPath = "D:/ELAMS_UPLOADS";

            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(
                    uploadPath +
                    File.separator +
                    fileName);
        }

        task.setDocumentPath(fileName);

        boolean result = dao.createTask(task);

        if (result) {
            response.sendRedirect("ViewTasksServlet");
        } else {
            request.setAttribute(
                    "errorMessage",
                    "Task creation failed.");

            request.getRequestDispatcher(
                    "createTask.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer managerId =
                (Integer) session.getAttribute("employeeId");

        EmployeeDao employeeDao =
                new EmployeeDaoImpl();

        List<Employee> employees =
                employeeDao.getEmployeesByManager(managerId);

        request.setAttribute(
                "employees",
                employees);

        request.getRequestDispatcher(
                "createTask.jsp")
                .forward(request, response);
    }
}