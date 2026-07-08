package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteTaskServlet")
public class DeleteTaskServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    TaskDao dao = new TaskDaoImpl();

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String taskId =
                request.getParameter("taskId");

        dao.deleteTask(taskId);

        response.sendRedirect(
                "ViewTasksServlet");
    }
}