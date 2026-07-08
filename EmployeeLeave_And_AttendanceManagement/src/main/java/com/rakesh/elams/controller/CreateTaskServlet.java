package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Date;

import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;
import com.rakesh.elams.model.Task;
import com.rakesh.elams.model.Task.Priority;
import com.rakesh.elams.model.Task.Status;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CreateTaskServlet")
public class CreateTaskServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    TaskDao dao = new TaskDaoImpl();

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Task task = new Task();

        task.setTaskId(request.getParameter("taskId"));
        task.setTaskName(request.getParameter("taskName"));
        task.setDescription(request.getParameter("description"));

        task.setEmployeeId(
                Integer.parseInt(
                        request.getParameter("employeeId")));
        HttpSession session = request.getSession(false);

        String managerId =
                (String) session.getAttribute("managerId");

        task.setManagerId(managerId);
        task.setPriority(
                Priority.valueOf(
                        request.getParameter("priority")
                                .toUpperCase()));

        task.setStatus(Status.PENDING);

        task.setAssignedDate(
                new Date(System.currentTimeMillis()));

        task.setDueDate(
                Date.valueOf(
                        request.getParameter("dueDate")));

        boolean result = dao.createTask(task);

        if(result) {
            response.sendRedirect(
                    "viewTasks.jsp?msg=Task Created Successfully");
        } else {
            response.sendRedirect(
                    "createTask.jsp?msg=Task Creation Failed");
        }
    }
}