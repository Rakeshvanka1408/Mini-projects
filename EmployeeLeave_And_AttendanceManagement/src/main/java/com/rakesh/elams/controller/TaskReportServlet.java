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

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        Integer managerId =
                (Integer) session.getAttribute("employeeId");

        request.setAttribute(
                "totalTasks",
                dao.getTotalTasks(managerId));

        request.setAttribute(
                "completedTasks",
                dao.getCompletedTasks(managerId));

        request.setAttribute(
                "pendingTasks",
                dao.getPendingTasks(managerId));

        request.setAttribute(
                "inProgressTasks",
                dao.getInProgressTasks(managerId));

        request.setAttribute(
                "overdueTasks",
                dao.getOverdueTasks(managerId));

        request.getRequestDispatcher(
                "taskReport.jsp")
                .forward(request, response);
    }
}