package com.rakesh.elams.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.Attendance;
import com.rakesh.elams.model.Leave;
import com.rakesh.elams.util.DbUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Attendance> attendanceReport = new ArrayList<>();

		List<Leave> leaveReport = new ArrayList<>();

		try (Connection con = DbUtil.getConnection()) {

			String attendanceSql = "SELECT e.employee_name,a.attendance_date,a.status " + "FROM attendance a "
					+ "JOIN employees e " + "ON a.employee_id=e.employee_id";

			PreparedStatement ps1 = con.prepareStatement(attendanceSql);

			ResultSet rs1 = ps1.executeQuery();

			while (rs1.next()) {

				Attendance attendance = new Attendance();

				attendance.setEmployeeName(rs1.getString("employee_name"));

				attendance.setAttendance_date(rs1.getDate("attendance_date"));

				attendance.setStatus(rs1.getString("status"));

				attendanceReport.add(attendance);
			}

			String leaveSql = "SELECT e.employee_name,l.leave_type,l.status " + "FROM leaves l " + "JOIN employees e "
					+ "ON l.employee_id=e.employee_id";

			PreparedStatement ps2 = con.prepareStatement(leaveSql);

			ResultSet rs2 = ps2.executeQuery();

			while (rs2.next()) {

				Leave leave = new Leave();

				leave.setEmployeeName(rs2.getString("employee_name"));

				leave.setLeaveType(rs2.getString("leave_type"));

				leave.setStatus(rs2.getString("status"));

				leaveReport.add(leave);
			}

			request.setAttribute("attendanceReport", attendanceReport);

			request.setAttribute("leaveReport", leaveReport);

		} catch (Exception e) {

			e.printStackTrace();
		}

		request.getRequestDispatcher("reports.jsp").forward(request, response);
	}
}