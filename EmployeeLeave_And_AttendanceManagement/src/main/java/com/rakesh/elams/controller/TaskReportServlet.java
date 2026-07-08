package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.TaskDao;
import com.rakesh.elams.dao.TaskDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/TaskReportServlet")
public class TaskReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    TaskDao dao = new TaskDaoImpl();

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "totalTasks",
                dao.getTotalTasks());

        request.setAttribute(
                "completedTasks",
                dao.getCompletedTasks());

        request.setAttribute(
                "pendingTasks",
                dao.getPendingTasks());

        request.setAttribute(
                "inProgressTasks",
                dao.getInProgressTasks());

        request.setAttribute(
                "overdueTasks",
                dao.getOverdueTasks());

        request.getRequestDispatcher(
                "taskReport.jsp")
                .forward(request, response);
    }
}