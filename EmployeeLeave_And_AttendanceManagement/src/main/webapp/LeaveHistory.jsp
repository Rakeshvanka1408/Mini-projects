<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rakesh.elams.model.Leave"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Leave History - ELAMS</title>

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
			max-width: 1400px;
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

		/* ===== STATS SECTION ===== */
		.stats-section {
			display: flex;
			gap: 20px;
			justify-content: center;
			margin-bottom: 30px;
			flex-wrap: wrap;
		}

		.stat-card {
			background-color: white;
			border: 2px solid #bdc3c7;
			border-radius: 8px;
			padding: 15px 25px;
			text-align: center;
			box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}

		.stat-card .stat-label {
			font-size: 12px;
			color: #7f8c8d;
			text-transform: uppercase;
			font-weight: bold;
		}

		.stat-card .stat-value {
			font-size: 28px;
			color: #2c3e50;
			font-weight: bold;
			margin-top: 8px;
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
			border: 1px solid #2c3e50;
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

		.status-pending {
			background-color: #fff3cd;
			color: #856404;
		}

		.status-approved {
			background-color: #d4edda;
			color: #155724;
		}

		.status-rejected {
			background-color: #f8d7da;
			color: #721c24;
		}

		/* Leave Type Badge */
		.leave-type-badge {
			display: inline-block;
			padding: 4px 10px;
			background-color: #e8f4f8;
			border-radius: 12px;
			font-size: 12px;
			font-weight: bold;
			color: #2980b9;
		}

		/* Action Buttons */
		.action-button {
			padding: 6px 12px;
			text-decoration: none;
			border-radius: 4px;
			font-size: 12px;
			font-weight: bold;
			cursor: pointer;
			border: none;
			transition: all 0.3s;
			display: inline-block;
		}

		/* Cancel Button */
		.btn-cancel {
			background-color: #e74c3c;
			color: white;
			border: 1px solid #e74c3c;
		}

		.btn-cancel:hover {
			background-color: #c0392b;
			border-color: #c0392b;
		}

		/* N/A Button (Disabled) */
		.btn-na {
			background-color: #ecf0f1;
			color: #95a5a6;
			border: 1px solid #bdc3c7;
			cursor: not-allowed;
		}

		/* ===== ACTION BUTTONS SECTION ===== */
		.action-bar {
			display: flex;
			justify-content: center;
			gap: 15px;
			margin-bottom: 30px;
			flex-wrap: wrap;
		}

		.btn-apply {
			background-color: #27ae60;
			color: white;
			padding: 12px 24px;
			text-decoration: none;
			border-radius: 4px;
			font-weight: bold;
			transition: all 0.3s;
			display: inline-block;
			border: 2px solid #27ae60;
		}

		.btn-apply:hover {
			background-color: #229954;
			border-color: #229954;
			transform: translateY(-2px);
			box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
		}

		.btn-back {
			background-color: #95a5a6;
			color: white;
			padding: 12px 24px;
			text-decoration: none;
			border-radius: 4px;
			font-weight: bold;
			transition: all 0.3s;
			display: inline-block;
			border: 2px solid #95a5a6;
		}

		.btn-back:hover {
			background-color: #7f8c8d;
			border-color: #7f8c8d;
			transform: translateY(-2px);
			box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
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

			.stats-section {
				flex-direction: column;
				align-items: center;
			}

			.stat-card {
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

			.status-badge,
			.leave-type-badge {
				font-size: 10px;
				padding: 3px 8px;
			}

			.action-button {
				font-size: 11px;
				padding: 5px 10px;
			}

			.action-bar {
				flex-direction: column;
				align-items: center;
			}

			.btn-apply,
			.btn-back {
				width: 100%;
				max-width: 300px;
				text-align: center;
			}
		}

	</style>

</head>

<body>

	<!-- ===== HEADER/NAVIGATION ===== -->
	<div class="navbar">
		<h1>ELAMS - Leave History</h1>
	</div>

	<!-- ===== MAIN CONTENT AREA ===== -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Your Leave History</h2>

		<!-- Page Subtitle -->
		<p class="page-subtitle">View all your leave requests and their status</p>

		<!-- Info Box -->
		<div class="info-box">
			<strong>ℹ️ Note:</strong> This page displays all your leave requests. You can view the leave type, dates, reason, and current status. Pending leaves can be cancelled if needed.
		</div>

		<!-- ===== LEAVE STATISTICS ===== -->
		<%
			List<Leave> leaves = (List<Leave>) request.getAttribute("leaves");
			int totalLeaves = 0;
			int pendingLeaves = 0;
			int approvedLeaves = 0;
			int rejectedLeaves = 0;

			if (leaves != null) {
				totalLeaves = leaves.size();
				for (Leave leave : leaves) {
					if ("Pending".equals(leave.getStatus())) {
						pendingLeaves++;
					} else if ("Approved".equals(leave.getStatus())) {
						approvedLeaves++;
					} else if ("Rejected".equals(leave.getStatus())) {
						rejectedLeaves++;
					}
				}
			}
		%>

		<div class="stats-section">
			<div class="stat-card">
				<div class="stat-label">Total Leaves</div>
				<div class="stat-value"><%= totalLeaves %></div>
			</div>
			<div class="stat-card">
				<div class="stat-label">Pending</div>
				<div class="stat-value"><%= pendingLeaves %></div>
			</div>
			<div class="stat-card">
				<div class="stat-label">Approved</div>
				<div class="stat-value"><%= approvedLeaves %></div>
			</div>
			<div class="stat-card">
				<div class="stat-label">Rejected</div>
				<div class="stat-value"><%= rejectedLeaves %></div>
			</div>
		</div>

		<!-- ===== ACTION BUTTONS ===== -->
		<div class="action-bar">
			<a href="applyLeave.jsp" class="btn-apply">+ Apply New Leave</a>
			
		</div>

		<!-- ===== LEAVE HISTORY TABLE SECTION ===== -->
		<div class="table-section">
			<h2>📋 Leave Requests</h2>

			<%
				if (leaves != null && !leaves.isEmpty()) {
			%>

			<!-- Leave History Table -->
			<table>
				<thead>
					<tr>
						<th>Leave ID</th>
						<th>Leave Type</th>
						<th>Start Date</th>
						<th>End Date</th>
						<th>Reason</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (Leave leave : leaves) {
							String statusClass = "";
							String status = leave.getStatus();
							
							if ("Pending".equals(status)) {
								statusClass = "status-pending";
							} else if ("Approved".equals(status)) {
								statusClass = "status-approved";
							} else if ("Rejected".equals(status)) {
								statusClass = "status-rejected";
							}
					%>
					<tr>
						<td>
							<strong>#<%= leave.getLeaveId() %></strong>
						</td>
						<td>
							<span class="leave-type-badge"><%= leave.getLeaveType() %></span>
						</td>
						<td>
							<strong><%= leave.getStartDate() %></strong>
						</td>
						<td>
							<strong><%= leave.getEndDate() %></strong>
						</td>
						<td>
							<%= leave.getReason() %>
						</td>
						<td>
							<span class="status-badge <%= statusClass %>">
								<%= status %>
							</span>
						</td>
						<td>
							<%
								if ("Pending".equals(leave.getStatus())) {
							%>
								<a href="javascript:void(0);" onclick="cancelLeave(<%= leave.getLeaveId() %>, '<%= leave.getLeaveType() %>')" class="action-button btn-cancel">Cancel</a>
							<%
							} else {
							%>
								<span class="action-button btn-na">N/A</span>
							<%
							}
							%>
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
				<p>No leave requests found.</p>
				<p><a href="applyLeave.jsp" style="color: #3498db; text-decoration: none;">Click here to apply for a leave</a></p>
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

	<!-- ===== JAVASCRIPT FUNCTIONS ===== -->
	<script>
		// Cancel leave with confirmation
		function cancelLeave(leaveId, leaveType) {
			var confirmCancel = confirm(
				"Are you sure you want to cancel this leave request?\n\n" +
				"Leave ID: " + leaveId + "\n" +
				"Leave Type: " + leaveType + "\n\n" +
				"This action cannot be undone!"
			);

			if (confirmCancel) {
				// Get employee ID (you may need to pass this as a parameter)
				var employeeId = prompt("Please enter your Employee ID:");
				
				if (employeeId && employeeId.trim() !== "") {
					// Redirect to cancel leave servlet
					window.location.href = "cancelLeave?leaveId=" + leaveId + "&employeeId=" + employeeId;
				} else {
					alert("Employee ID is required to cancel leave!");
				}
			}
		}

		// Print leave history
		function printLeaveHistory() {
			window.print();
		}
	</script>

</body>

</html>