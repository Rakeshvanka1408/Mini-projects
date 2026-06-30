<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rakesh.elams.model.Leave"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Leave Requests - ELAMS</title>

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

/* Employee Badge */
.employee-badge {
	display: inline-block;
	padding: 4px 10px;
	background-color: #f0f0f0;
	border-radius: 12px;
	font-size: 12px;
	font-weight: bold;
	color: #2c3e50;
}

/* Action Buttons */
.action-buttons {
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
}

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

/* Approve Button */
.btn-approve {
	background-color: #27ae60;
	color: white;
	border: 1px solid #27ae60;
}

.btn-approve:hover {
	background-color: #229954;
	border-color: #229954;
}

/* Reject Button */
.btn-reject {
	background-color: #e74c3c;
	color: white;
	border: 1px solid #e74c3c;
}

.btn-reject:hover {
	background-color: #c0392b;
	border-color: #c0392b;
}

/* ===== ACTION BUTTONS SECTION ===== */
.action-bar {
	display: flex;
	justify-content: center;
	gap: 15px;
	margin-bottom: 30px;
	flex-wrap: wrap;
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

.btn-refresh {
	background-color: #3498db;
	color: white;
	padding: 12px 24px;
	text-decoration: none;
	border-radius: 4px;
	font-weight: bold;
	transition: all 0.3s;
	display: inline-block;
	border: 2px solid #3498db;
}

.btn-refresh:hover {
	background-color: #2980b9;
	border-color: #2980b9;
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

/* ===== ALERT MESSAGES ===== */
.alert {
	padding: 12px 15px;
	border-radius: 4px;
	margin-bottom: 20px;
	border-left: 4px solid;
}

.alert-success {
	background-color: #d4edda;
	border-left-color: #27ae60;
	color: #155724;
}

.alert-info {
	background-color: #d1ecf1;
	border-left-color: #3498db;
	color: #0c5460;
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
@media ( max-width : 768px) {
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
	table th, table td {
		padding: 8px 10px;
	}
	.status-badge, .leave-type-badge, .employee-badge {
		font-size: 10px;
		padding: 3px 8px;
	}
	.action-button {
		font-size: 11px;
		padding: 5px 10px;
	}
	.action-buttons {
		flex-direction: column;
	}
	.action-button {
		width: 100%;
	}
	.action-bar {
		flex-direction: column;
		align-items: center;
	}
	.btn-back, .btn-refresh {
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
		<h1>ELAMS - Leave Management</h1>
	</div>

	<!-- ===== MAIN CONTENT AREA ===== -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Pending Leave Requests</h2>

		<!-- Page Subtitle -->
		<p class="page-subtitle">Review and approve/reject employee leave
			requests</p>

		<!-- Info Box -->
		<div class="info-box">
			<strong>ℹ️ Note:</strong> As an administrator, you can review pending
			leave requests from employees. Click "Approve" to approve the request
			or "Reject" to deny it. Approved/Rejected requests will be moved to
			the leave history.
		</div>

		<!-- Display Success Message if any -->
		<%
		String successMessage = (String) request.getAttribute("successMessage");
		if (successMessage != null && !successMessage.isEmpty()) {
		%>
		<div class="alert alert-success">
			✓
			<%=successMessage%>
		</div>
		<%
		}
		%>

		<!-- Display Info Message if any -->
		<%
		String infoMessage = (String) request.getAttribute("infoMessage");
		if (infoMessage != null && !infoMessage.isEmpty()) {
		%>
		<div class="alert alert-info">
			ℹ️
			<%=infoMessage%>
		</div>
		<%
		}
		%>

		<!-- ===== LEAVE REQUEST STATISTICS ===== -->
		<%
		List<Leave> pendingLeaves = (List<Leave>) request.getAttribute("pendingLeaves");
		int totalPending = 0;

		if (pendingLeaves != null) {
			totalPending = pendingLeaves.size();
		}
		%>

		<div class="stats-section">
			<div class="stat-card">
				<div class="stat-label">Pending Requests</div>
				<div class="stat-value"><%=totalPending%></div>
			</div>
		</div>

		<!-- ===== ACTION BUTTONS ===== -->
		<div class="action-bar">
			<a href="javascript:location.reload();" class="btn-refresh">🔄
				Refresh</a> <a href="adminDashboard.jsp" class="btn-back">← Back to Dashboard</a>
		</div>

		<!-- ===== LEAVE REQUESTS TABLE SECTION ===== -->
		<div class="table-section">
			<h2>📋 Leave Requests for Review</h2>

			<%
			if (pendingLeaves != null && !pendingLeaves.isEmpty()) {
			%>

			<!-- Pending Leaves Table -->
			<table>
				<thead>
					<tr>
						<th>Leave ID</th>
						<th>Employee ID</th>
						<th>Leave Type</th>
						<th>Start Date</th>
						<th>End Date</th>
						<th>Reason</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Leave leave : pendingLeaves) {
					%>
					<tr>
						<td><strong>#<%=leave.getLeaveId()%></strong></td>
						<td><span class="employee-badge">EMP<%=leave.getEmployeeId()%></span>
						</td>
						<td><span class="leave-type-badge"><%=leave.getLeaveType()%></span>
						</td>
						<td><strong><%=leave.getStartDate()%></strong></td>
						<td><strong><%=leave.getEndDate()%></strong></td>
						<td><%=leave.getReason()%></td>
						<td><span class="status-badge status-pending"> <%=leave.getStatus()%>
						</span></td>
						<td>
							<div class="action-buttons">
								<a href="javascript:void(0);"
									onclick="approveLeave(<%=leave.getLeaveId()%>, '<%=leave.getLeaveType()%>')"
									class="action-button btn-approve">Approve</a> <a
									href="javascript:void(0);"
									onclick="rejectLeave(<%=leave.getLeaveId()%>, '<%=leave.getLeaveType()%>')"
									class="action-button btn-reject">Reject</a>
							</div>
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
				<div class="no-data-icon">✅</div>
				<p>No pending leave requests!</p>
				<p style="font-size: 14px; margin-top: 10px; color: #27ae60;">All
					leave requests have been processed.</p>
			</div>

			<%
			}
			%>

		</div>

	</div>

	<!-- ===== FOOTER ===== -->
	<footer>
		<p>&copy; 2024 ELAMS - Employee Leave & Attendance Management
			System. All rights reserved.</p>
	</footer>

	<!-- ===== JAVASCRIPT FUNCTIONS ===== -->
	<script>
		// Approve leave with confirmation
		function approveLeave(leaveId, leaveType) {
			var confirmApprove = confirm(
				"Are you sure you want to APPROVE this leave request?\n\n" +
				"Leave ID: " + leaveId + "\n" +
				"Leave Type: " + leaveType + "\n\n" +
				"Once approved, the employee will be notified."
			);

			if (confirmApprove) {
				// Redirect to approve leave servlet
				window.location.href = "approveLeave?leaveId=" + leaveId;
			}
		}

		// Reject leave with confirmation
		function rejectLeave(leaveId, leaveType) {
			var confirmReject = confirm(
				"Are you sure you want to REJECT this leave request?\n\n" +
				"Leave ID: " + leaveId + "\n" +
				"Leave Type: " + leaveType + "\n\n" +
				"Once rejected, the employee will be notified."
			);

			if (confirmReject) {
				// Optionally ask for rejection reason
				var rejectionReason = prompt("Please provide a reason for rejection (optional):");
				
				if (rejectionReason !== null) {
					// Redirect to reject leave servlet with reason
					var reason = rejectionReason.trim() !== "" ? "&reason=" + encodeURIComponent(rejectionReason) : "";
					window.location.href = "rejectLeave?leaveId=" + leaveId + reason;
				}
			}
		}

		// Print pending leave requests
		function printPendingLeaves() {
			window.print();
		}

		// Export to CSV (optional feature)
		function exportToCSV() {
			var table = document.querySelector("table");
			var csv = [];
			var rows = table.querySelectorAll("tr");

			rows.forEach(function(row) {
				var cols = row.querySelectorAll("td, th");
				var csvRow = [];
				cols.forEach(function(col) {
					csvRow.push(col.innerText);
				});
				csv.push(csvRow.join(","));
			});

			var csvContent = "data:text/csv;charset=utf-8," + csv.join("\n");
			var link = document.createElement("a");
			link.setAttribute("href", encodeURI(csvContent));
			link.setAttribute("download", "pending_leaves.csv");
			link.click();
		}
	</script>

</body>

</html>