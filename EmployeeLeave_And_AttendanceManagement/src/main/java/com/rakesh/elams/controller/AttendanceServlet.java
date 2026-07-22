package com.rakesh.elams.controller;

import java.io.IOException;
import java.time.LocalTime;

import com.rakesh.elams.dao.AttendanceDao;
import com.rakesh.elams.dao.AttendanceDaoImpl;
import com.rakesh.elams.model.Attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/markAttendance")
public class AttendanceServlet extends HttpServlet {

    private AttendanceDao dao;

    @Override
    public void init() {
        dao = new AttendanceDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        Integer employeeId =
                (Integer) session.getAttribute("employeeId");

        String action =
                request.getParameter("action");

        if ("checkin".equals(action)) {

            if (!dao.hasCheckedInToday(employeeId)) {

                Attendance attendance =
                        new Attendance();

                attendance.setEmployee_id(employeeId);
                if (LocalTime.now()
                        .isAfter(LocalTime.of(10,0))) {

                    attendance.setStatus("LATE");

                } else {

                    attendance.setStatus("PRESENT");
                }

                dao.checkIn(attendance);
            }

        } else if ("checkout".equals(action)) {

            dao.checkOut(employeeId);
        }

        response.sendRedirect("attendance.jsp");
    }
}