<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rakesh.elams.model.Attendance"%>
<%@ page import="com.rakesh.elams.model.Leave"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reports - ELAMS</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5;
	color: #333;
	line-height: 1.6;
}

/* Header/Navbar */
.navbar {
	background-color: #2c3e50;
	color: white;
	padding: 15px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.navbar h1 {
	font-size: 24px;
	font-weight: bold;
}

.navbar .back-btn {
	background-color: #3498db;
	color: white;
	padding: 8px 15px;
	border-radius: 4px;
	text-decoration: none;
	transition: background-color 0.3s;
}

.navbar .back-btn:hover {
	background-color: #2980b9;
}

/* Main Container */
.container {
	max-width: 1200px;
	margin: 30px auto;
	padding: 0 20px;
}

.page-title {
	font-size: 28px;
	color: #2c3e50;
	margin-bottom: 30px;
	border-bottom: 3px solid #3498db;
	padding-bottom: 10px;
}

.section-title {
	font-size: 22px;
	color: #2c3e50;
	margin: 30px 0 20px 0;
	border-left: 5px solid #3498db;
	padding-left: 15px;
}

/* Table Styles */
.table-container {
	background-color: white;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
}

table thead {
	background-color: #34495e;
	color: white;
}

table th {
	padding: 15px;
	text-align: left;
	font-weight: 600;
	border-bottom: 2px solid #2c3e50;
}

table td {
	padding: 12px 15px;
	border-bottom: 1px solid #ecf0f1;
}

table tbody tr:hover {
	background-color: #f9f9f9;
	transition: background-color 0.3s;
}

table tbody tr:nth-child(even) {
	background-color: #f8f9fa;
}

/* Status Badge */
.status-badge {
	display: inline-block;
	padding: 6px 12px;
	border-radius: 20px;
	font-weight: 600;
	font-size: 12px;
	text-transform: uppercase;
}

.status-badge.present {
	background-color: #d4edda;
	color: #155724;
}

.status-badge.absent {
	background-color: #f8d7da;
	color: #721c24;
}

.status-badge.pending {
	background-color: #fff3cd;
	color: #856404;
}

.status-badge.approved {
	background-color: #d4edda;
	color: #155724;
}

.status-badge.rejected {
	background-color: #f8d7da;
	color: #721c24;
}

/* Empty State */
.empty-state {
	text-align: center;
	padding: 40px 20px;
	color: #7f8c8d;
}

.empty-state p {
	font-size: 16px;
	margin-top: 10px;
}

/* Action Buttons */
.action-buttons {
	display: flex;
	gap: 10px;
	justify-content: center;
	margin: 30px 0;
	flex-wrap: wrap;
}

.btn {
	background-color: #3498db;
	color: white;
	padding: 10px 20px;
	border-radius: 4px;
	text-decoration: none;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
	font-weight: 600;
}

.btn:hover {
	background-color: #2980b9;
}

.btn.secondary {
	background-color: #95a5a6;
}

.btn.secondary:hover {
	background-color: #7f8c8d;
}

/* Footer */
footer {
	background-color: #2c3e50;
	color: white;
	text-align: center;
	padding: 20px;
	margin-top: 50px;
	font-size: 12px;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.navbar {
		flex-direction: column;
		gap: 15px;
	}
	.page-title {
		font-size: 22px;
	}
	.section-title {
		font-size: 18px;
	}
	table th, table td {
		padding: 10px;
		font-size: 14px;
	}
	.action-buttons {
		flex-direction: column;
	}
	.btn {
		width: 100%;
	}
}

/* Print Styles */
@media print {
	.navbar, .action-buttons, footer {
		display: none;
	}
	body {
		background-color: white;
	}
	.table-container {
		box-shadow: none;
		border: 1px solid #ddd;
	}
}
</style>

</head>

<body>

	<!-- Navigation Bar -->
	<div class="navbar">
		<h1>ELAMS - Reports</h1>
		
	</div>

	<!-- Main Container -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">System Reports</h2>

		<!-- Attendance Report Section -->
		<h3 class="section-title">📊 Attendance Report</h3>

		<div class="table-container">
			<%
			List<Attendance> attendanceReport = (List<Attendance>) request.getAttribute("attendanceReport");

			if (attendanceReport != null && !attendanceReport.isEmpty()) {
			%>
			<table>
				<thead>
					<tr>
						<th>Employee Name</th>
						<th>Date</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Attendance attendance : attendanceReport) {
					%>
					<tr>
						<td><%=attendance.getEmployeeName()%></td>
						<td><%=attendance.getAttendance_date()%></td>
						<td><span
							class="status-badge <%=attendance.getStatus().toLowerCase()%>"><%=attendance.getStatus()%></span></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			} else {
			%>
			<div class="empty-state">
				<p>No attendance records found.</p>
			</div>
			<%
			}
			%>
		</div>

		<!-- Leave Report Section -->
		<h3 class="section-title">📋 Leave Report</h3>

		<div class="table-container">
			<%
			List<Leave> leaveReport = (List<Leave>) request.getAttribute("leaveReport");

			if (leaveReport != null && !leaveReport.isEmpty()) {
			%>
			<table>
				<thead>
					<tr>
						<th>Employee Name</th>
						<th>Leave Type</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Leave leave : leaveReport) {
					%>
					<tr>
						<td><%=leave.getEmployeeName()%></td>
						<td><%=leave.getLeaveType()%></td>
						<td><span
							class="status-badge <%=leave.getStatus().toLowerCase()%>"><%=leave.getStatus()%></span></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			} else {
			%>
			<div class="empty-state">
				<p>No leave records found.</p>
			</div>
			<%
			}
			%>
		</div>

		<!-- Action Buttons -->
		<div class="action-buttons">
			<button class="btn" onclick="window.print()">🖨️ Print
				Reports</button>
			
		</div>

	</div>

	<!-- Footer -->
	<footer>
		<p>&copy; 2024 ELAMS - Employee Leave & Attendance Management
			System. All rights reserved.</p>
	</footer>

</body>

</html>