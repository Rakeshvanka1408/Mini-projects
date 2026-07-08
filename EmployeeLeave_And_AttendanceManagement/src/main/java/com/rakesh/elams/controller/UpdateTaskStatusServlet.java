package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateTaskStatusServlet")
public class UpdateTaskStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    TaskDao dao = new TaskDaoImpl();

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String taskId =
                request.getParameter("taskId");

        String status =
                request.getParameter("status");

        boolean result =
                dao.updateTaskStatus(taskId, status);

        if(result) {
            response.sendRedirect(
                    "ViewTasksServlet");
        } else {
            response.getWriter().println(
                    "Status Update Failed");
        }
    }
}