<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rakesh.elams.model.Attendance"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Attendance History - ELAMS</title>

	<style>
		/* RESET - Remove default browser spacing */
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}

		/* BODY - Main page styling */
		body {
			font-family: Arial, sans-serif;
			background-color: #f5f5f5;
			color: #333;
			line-height: 1.6;
		}

		/* ===== HEADER/NAVBAR ===== */
		.navbar {
			background-color: #2c3e50;
			color: white;
			padding: 15px 20px;
			text-align: center;
			box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}

		.navbar h1 {
			font-size: 24px;
			font-weight: bold;
		}

		/* ===== MAIN CONTAINER ===== */
		.container {
			max-width: 1200px;
			margin: 30px auto;
			padding: 0 20px;
		}

		/* Page Title */
		.page-title {
			font-size: 28px;
			color: #2c3e50;
			margin-bottom: 10px;
			text-align: center;
		}

		/* Page Subtitle */
		.page-subtitle {
			font-size: 14px;
			color: #7f8c8d;
			text-align: center;
			margin-bottom: 30px;
		}

		/* ===== SUMMARY CARDS SECTION ===== */
		.summary-cards {
			display: flex;
			flex-wrap: wrap;
			gap: 20px;
			justify-content: center;
			margin-bottom: 50px;
		}

		/* Summary Card */
		.summary-card {
			background-color: white;
			border: 2px solid #bdc3c7;
			border-radius: 8px;
			padding: 20px;
			width: 200px;
			text-align: center;
			box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
			transition: all 0.3s;
		}

		.summary-card:hover {
			transform: translateY(-3px);
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
		}

		/* Card left border colors */
		.summary-card.present {
			border-left: 5px solid #27ae60;
		}

		.summary-card.absent {
			border-left: 5px solid #e74c3c;
		}

		.summary-card.half-day {
			border-left: 5px solid #f39c12;
		}

		/* Summary Card Title */
		.summary-card h3 {
			font-size: 13px;
			color: #7f8c8d;
			text-transform: uppercase;
			letter-spacing: 1px;
			margin-bottom: 10px;
			font-weight: 600;
		}

		/* Summary Card Number */
		.summary-card .count {
			font-size: 36px;
			font-weight: bold;
			color: #2c3e50;
		}

		/* ===== TABLE SECTION ===== */
		.table-section {
			background-color: white;
			border: 2px solid #bdc3c7;
			border-radius: 8px;
			padding: 25px;
			box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
			overflow-x: auto;
		}

		.table-section h2 {
			font-size: 20px;
			color: #2c3e50;
			margin-bottom: 20px;
			border-bottom: 2px solid #3498db;
			padding-bottom: 10px;
		}

		/* Table Styling */
		table {
			width: 100%;
			border-collapse: collapse;
			margin-bottom: 20px;
		}

		/* Table Header */
		table thead {
			background-color: #34495e;
			color: white;
		}

		table th {
			padding: 12px 15px;
			text-align: left;
			font-weight: 600;
			font-size: 13px;
			text-transform: uppercase;
			letter-spacing: 0.5px;
			border: 1px solid #bdc3c7;
		}

		/* Table Body */
		table td {
			padding: 12px 15px;
			border: 1px solid #ecf0f1;
			font-size: 14px;
		}

		/* Table Row */
		table tbody tr {
			transition: background-color 0.3s;
		}

		table tbody tr:hover {
			background-color: #f9f9f9;
		}

		/* Alternate Row Colors */
		table tbody tr:nth-child(even) {
			background-color: #f5f5f5;
		}

		/* Status Badge Styling */
		.status-badge {
			display: inline-block;
			padding: 5px 12px;
			border-radius: 20px;
			font-size: 12px;
			font-weight: bold;
			text-transform: uppercase;
		}

		.status-present {
			background-color: #d4edda;
			color: #155724;
		}

		.status-absent {
			background-color: #f8d7da;
			color: #721c24;
		}

		.status-half-day {
			background-color: #fff3cd;
			color: #856404;
		}

		/* ===== NO DATA MESSAGE ===== */
		.no-data {
			text-align: center;
			padding: 40px 20px;
			color: #7f8c8d;
			font-size: 16px;
		}

		.no-data-icon {
			font-size: 48px;
			margin-bottom: 15px;
		}

		/* ===== DIVIDER ===== */
		.divider {
			margin: 40px 0;
			border: none;
			border-top: 2px solid #bdc3c7;
		}

		/* ===== ACTION BUTTONS ===== */
		.action-buttons {
			display: flex;
			gap: 10px;
			justify-content: center;
			flex-wrap: wrap;
			margin-bottom: 30px;
		}

		.btn {
			padding: 10px 20px;
			border: none;
			border-radius: 4px;
			font-size: 14px;
			font-weight: bold;
			cursor: pointer;
			transition: all 0.3s;
			text-decoration: none;
			display: inline-block;
		}

		.btn-primary {
			background-color: #3498db;
			color: white;
		}

		.btn-primary:hover {
			background-color: #2980b9;
		}

		.btn-secondary {
			background-color: #95a5a6;
			color: white;
		}

		.btn-secondary:hover {
			background-color: #7f8c8d;
		}

		/* ===== INFO BOX ===== */
		.info-box {
			background-color: #ecf0f1;
			border-left: 4px solid #3498db;
			padding: 15px;
			border-radius: 4px;
			margin-bottom: 25px;
			font-size: 13px;
			color: #2c3e50;
		}

		/* ===== FOOTER ===== */
		footer {
			background-color: #2c3e50;
			color: white;
			text-align: center;
			padding: 20px;
			margin-top: 50px;
			font-size: 12px;
		}

		/* ===== RESPONSIVE DESIGN FOR MOBILE ===== */
		@media (max-width: 768px) {
			.container {
				margin: 20px auto;
			}

			.page-title {
				font-size: 22px;
			}

			.summary-cards {
				flex-direction: column;
				align-items: center;
			}

			.summary-card {
				width: 100%;
				max-width: 300px;
			}

			.table-section {
				padding: 15px;
				overflow-x: auto;
			}

			table {
				font-size: 12px;
			}

			table th,
			table td {
				padding: 8px 10px;
			}

			.status-badge {
				font-size: 10px;
				padding: 4px 8px;
			}

			.action-buttons {
				flex-direction: column;
			}

			.btn {
				width: 100%;
			}
		}

	</style>

</head>

<body>

	<!-- ===== HEADER/NAVIGATION ===== -->
	<div class="navbar">
		<h1>ELAMS - Attendance History</h1>
	</div>

	<!-- ===== MAIN CONTENT AREA ===== -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Your Attendance History</h2>

		<!-- Page Subtitle -->
		<p class="page-subtitle">View your complete attendance records and statistics</p>

		<!-- Info Box -->
		<div class="info-box">
			<strong>ℹ️ Note:</strong> This page shows all your attendance records. You can view detailed information about check-in times, check-out times, and your attendance status for each day.
		</div>

		<!-- ===== ATTENDANCE SUMMARY CARDS ===== -->
		<div class="summary-cards">

			<!-- Present Count Card -->
			<div class="summary-card present">
				<h3>Days Present</h3>
				<div class="count">
					<%
						Object presentCount = request.getAttribute("present");
						out.print(presentCount != null ? presentCount : "0");
					%>
				</div>
			</div>

			<!-- Absent Count Card -->
			<div class="summary-card absent">
				<h3>Days Absent</h3>
				<div class="count">
					<%
						Object absentCount = request.getAttribute("absent");
						out.print(absentCount != null ? absentCount : "0");
					%>
				</div>
			</div>

			<!-- Half Day Count Card -->
			<div class="summary-card half-day">
				<h3>Half Days</h3>
				<div class="count">
					<%
						Object halfDayCount = request.getAttribute("halfDay");
						out.print(halfDayCount != null ? halfDayCount : "0");
					%>
				</div>
			</div>

		</div>

		<!-- ===== ACTION BUTTONS ===== -->
		<div class="action-buttons">
			<a href="attendance.jsp" class="btn btn-primary">Mark Today's Attendance</a>
			<a href="employees" class="btn btn-secondary">Back to Dashboard</a>
		</div>

		<!-- Divider -->
		<hr class="divider">

		<!-- ===== ATTENDANCE RECORDS TABLE ===== -->
		<div class="table-section">
			<h2>📋 Detailed Attendance Records</h2>

			<%
				List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");

				if (attendanceList != null && !attendanceList.isEmpty()) {
			%>

			<!-- Attendance Table -->
			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Employee ID</th>
						<th>Date</th>
						<th>Check In</th>
						<th>Check Out</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (Attendance attendance : attendanceList) {
							String statusClass = "";
							String status = attendance.getStatus();
							
							if ("Present".equals(status)) {
								statusClass = "status-present";
							} else if ("Absent".equals(status)) {
								statusClass = "status-absent";
							} else if ("Half Day".equals(status)) {
								statusClass = "status-half-day";
							}
					%>
					<tr>
						<td><strong><%= attendance.getAttendance_id() %></strong></td>
						<td><%= attendance.getEmployee_id() %></td>
						<td><strong><%= attendance.getAttendance_date() %></strong></td>
						<td><%= attendance.getCheck_in_time() %></td>
						<td><%= attendance.getCheck_out_time() %></td>
						<td>
							<span class="status-badge <%= statusClass %>">
								<%= status %>
							</span>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

			<%
			} else {
			%>

			<!-- No Data Message -->
			<div class="no-data">
				<div class="no-data-icon">📭</div>
				<p>No attendance records found. Start marking your attendance!</p>
			</div>

			<%
			}
			%>

		</div>

	</div>

	<!-- ===== FOOTER ===== -->
	<footer>
		<p>&copy; 2024 ELAMS - Employee Leave & Attendance Management System. All rights reserved.</p>
	</footer>

	<!-- ===== PRINT FUNCTIONALITY ===== -->
	<script>
		// Allow users to print attendance history
		function printAttendance() {
			window.print();
		}

		// Show/Hide table on button click
		function toggleTableDetails() {
			var table = document.querySelector('table');
			if (table.style.display === 'none') {
				table.style.display = 'table';
			} else {
				table.style.display = 'none';
			}
		}
	</script>

</body>

</html>