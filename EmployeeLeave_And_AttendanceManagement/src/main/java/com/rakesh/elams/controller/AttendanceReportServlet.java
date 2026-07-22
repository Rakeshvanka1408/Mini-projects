package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import com.rakesh.elams.dao.AttendanceDao;
import com.rakesh.elams.dao.AttendanceDaoImpl;
import com.rakesh.elams.model.Attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/attendanceReport")
public class AttendanceReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AttendanceDao attendanceDAO;

    @Override
    public void init() {
        attendanceDAO = new AttendanceDaoImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check session
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Check role
        String role = (String) session.getAttribute("role");

        if (role == null ||
            !role.equalsIgnoreCase("MANAGER")) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in manager's employee ID
        Integer managerId =
                (Integer) session.getAttribute("employeeId");

        if (managerId == null || managerId <= 0) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Manager employee ID not found in session."
            );

            return;
        }

        // Today's date
        Date today =
                new Date(System.currentTimeMillis());

        /*
         * Get ONLY attendance belonging to employees
         * assigned to this manager.
         */
        List<Attendance> attendanceList =
                attendanceDAO.getAttendanceByManager(managerId);

        /*
         * Get counts ONLY for employees assigned
         * to this manager.
         */
        int present =
                attendanceDAO.getPresentCountByManager(
                        today,
                        managerId
                );

        int absent =
                attendanceDAO.getAbsentCountByManager(
                        today,
                        managerId
                );

        int halfDay =
                attendanceDAO.getHalfDayCountByManager(
                        today,
                        managerId
                );

        // Send data to JSP
        request.setAttribute(
                "present",
                present
        );

        request.setAttribute(
                "absent",
                absent
        );

        request.setAttribute(
                "halfDay",
                halfDay
        );

        request.setAttribute(
                "attendanceList",
                attendanceList
        );

        // Forward to attendance history page
        request.getRequestDispatcher(
                "attendanceHistory.jsp"
        ).forward(request, response);
    }
}