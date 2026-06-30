package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Date;

import com.rakesh.elams.dao.LeaveDao;
import com.rakesh.elams.dao.LeaveDaoImpl;
import com.rakesh.elams.model.Leave;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/applyLeave")
public class LeaveServlet extends HttpServlet {

    private LeaveDao leaveDAO;

    @Override
    public void init() {
        leaveDAO = new LeaveDaoImpl();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Leave leave = new Leave();

        leave.setEmployeeId(
                Integer.parseInt(
                        request.getParameter(
                                "employeeId")));

        leave.setLeaveType(
                request.getParameter(
                        "leaveType"));

        leave.setStartdate(
                Date.valueOf(
                        request.getParameter(
                                "startDate")));

        leave.setEndDate(
                Date.valueOf(
                        request.getParameter(
                                "endDate")));

        leave.setReason(
                request.getParameter(
                        "reason"));

        leave.setStatus("pending");

        leaveDAO.applyLeave(leave);

        response.sendRedirect(
                "leaveHistory?employeeId="
                + leave.getEmployeeId());
    }
}