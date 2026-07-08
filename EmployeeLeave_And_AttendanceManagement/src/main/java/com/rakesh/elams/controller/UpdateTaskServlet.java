package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Date;

import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;
import com.rakesh.elams.model.Task;
import com.rakesh.elams.model.Task.Priority;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateTaskServlet")
public class UpdateTaskServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    TaskDao dao = new TaskDaoImpl();

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Task task = dao.getTaskById(
                request.getParameter("taskId"));

        task.setTaskName(
                request.getParameter("taskName"));

        task.setDescription(
                request.getParameter("description"));

        task.setPriority(
                Priority.valueOf(
                        request.getParameter("priority")
                                .toUpperCase()));

        task.setDueDate(
                Date.valueOf(
                        request.getParameter("dueDate")));

        boolean result = dao.updateTask(task);

        if(result) {
            response.sendRedirect(
                    "ViewTasksServlet");
        } else {
            response.getWriter().println(
                    "Update Failed");
        }
    }
}