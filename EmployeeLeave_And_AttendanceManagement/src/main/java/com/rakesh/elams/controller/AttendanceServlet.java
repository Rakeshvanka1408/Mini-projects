package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

import com.rakesh.elams.dao.AttendanceDao;
import com.rakesh.elams.dao.AttendanceDaoImpl;
import com.rakesh.elams.model.Attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/markAttendance")
public class AttendanceServlet extends HttpServlet {

    private AttendanceDao attendanceDao;

    @Override
    public void init() {
        attendanceDao = new AttendanceDaoImpl();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Attendance attendance = new Attendance();

        attendance.setEmployee_id(
                Integer.parseInt(
                        request.getParameter(
                                "employeeId")));

        attendance.setAttendance_date(
                Date.valueOf(
                        request.getParameter(
                                "attendanceDate")));

        attendance.setCheck_in_time(
                Time.valueOf(
                        request.getParameter(
                                "checkIn")));

        attendance.setCheck_out_time(
                Time.valueOf(
                        request.getParameter(
                                "checkOut")));

        attendance.setStatus(
                request.getParameter(
                        "status"));

        attendanceDao.markAttendance(
                attendance);

        response.sendRedirect(
                "attendance.jsp?success=true");
    }
}