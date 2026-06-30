<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - ELAMS</title>

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

.navbar .logout-btn {
	background-color: #e74c3c;
	color: white;
	padding: 8px 15px;
	border-radius: 4px;
	text-decoration: none;
	transition: background-color 0.3s;
}

.navbar .logout-btn:hover {
	background-color: #c0392b;
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

/* Dashboard Cards Grid */
.dashboard-cards {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
	margin-bottom: 50px;
}

.card {
	background-color: white;
	border: 2px solid #bdc3c7;
	border-radius: 8px;
	padding: 25px;
	text-align: center;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s, box-shadow 0.3s, border-color 0.3s;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
	border-color: #3498db;
}

/* Card Colors based on type */
.card.total {
	border-left: 5px solid #3498db;
}

.card.present {
	border-left: 5px solid #27ae60;
}

.card.absent {
	border-left: 5px solid #e74c3c;
}

.card.pending {
	border-left: 5px solid #f39c12;
}

.card h3 {
	font-size: 14px;
	color: #7f8c8d;
	text-transform: uppercase;
	letter-spacing: 1px;
	margin-bottom: 15px;
	font-weight: 600;
}

.card .icon {
	font-size: 40px;
	margin-bottom: 10px;
}

.card .count {
	font-size: 42px;
	font-weight: bold;
	color: #2c3e50;
	margin: 15px 0;
}

.card .subtitle {
	font-size: 12px;
	color: #95a5a6;
}

/* Divider */
.divider {
	margin: 40px 0;
	border: none;
	border-top: 2px solid #bdc3c7;
}

/* Actions Section */
.actions-section {
	background-color: white;
	border: 2px solid #bdc3c7;
	border-radius: 8px;
	padding: 30px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.actions-section h2 {
	font-size: 20px;
	color: #2c3e50;
	margin-bottom: 25px;
	border-bottom: 2px solid #3498db;
	padding-bottom: 10px;
}

.actions-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 15px;
}

.action-link {
	background-color: #3498db;
	color: white;
	padding: 15px 20px;
	text-align: center;
	text-decoration: none;
	border-radius: 6px;
	border: 2px solid #3498db;
	font-weight: 600;
	transition: all 0.3s;
	display: inline-block;
	cursor: pointer;
}

.action-link:hover {
	background-color: #2980b9;
	border-color: #2980b9;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.action-link.danger {
	background-color: #e74c3c;
	border-color: #e74c3c;
}

.action-link.danger:hover {
	background-color: #c0392b;
	border-color: #c0392b;
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
	.dashboard-cards {
		grid-template-columns: 1fr;
	}
	.actions-grid {
		grid-template-columns: 1fr;
	}
	.card .count {
		font-size: 32px;
	}
	.container {
		margin: 20px auto;
	}
}

/* Loading Animation */
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.card {
	animation: fadeIn 0.5s ease-out;
}

.card:nth-child(1) {
	animation-delay: 0.1s;
}

.card:nth-child(2) {
	animation-delay: 0.2s;
}

.card:nth-child(3) {
	animation-delay: 0.3s;
}

.card:nth-child(4) {
	animation-delay: 0.4s;
}

/* Status Indicators */
.status-indicator {
	display: inline-block;
	width: 12px;
	height: 12px;
	border-radius: 50%;
	margin-right: 8px;
}

.status-indicator.success {
	background-color: #27ae60;
}

.status-indicator.danger {
	background-color: #e74c3c;
}

.status-indicator.warning {
	background-color: #f39c12;
}

.status-indicator.info {
	background-color: #3498db;
}
</style>

</head>

<body>

	<!-- Navigation Bar -->
	<div class="navbar">
		<h1>ELAMS - Admin Dashboard</h1>
		<a href="logout" class="logout-btn">Logout</a>
	</div>

	<!-- Main Container -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Dashboard Overview</h2>

		<!-- Dashboard Statistics Cards -->
		<div class="dashboard-cards">

			<!-- Total Employees Card -->
			<div class="card total">
				<div class="icon">👥</div>
				<h3>Total Employees</h3>
				<div class="count">
					<%
					Object employeeCount = request.getAttribute("employeeCount");
					out.print(employeeCount != null ? employeeCount : "0");
					%>
				</div>
				<div class="subtitle">Active employees in system</div>
			</div>

			<!-- Present Today Card -->
			<div class="card present">
				<div class="icon">✓</div>
				<h3>Present Today</h3>
				<div class="count">
					<%
					Object presentCount = request.getAttribute("presentCount");
					out.print(presentCount != null ? presentCount : "0");
					%>
				</div>
				<div class="subtitle">Employees marked present</div>
			</div>

			<!-- Absent Today Card -->
			<div class="card absent">
				<div class="icon">✕</div>
				<h3>Absent Today</h3>
				<div class="count">
					<%
					Object absentCount = request.getAttribute("absentCount");
					out.print(absentCount != null ? absentCount : "0");
					%>
				</div>
				<div class="subtitle">Employees marked absent</div>
			</div>

			<!-- Pending Leaves Card -->
			<div class="card pending">
				<div class="icon">⏳</div>
				<h3>Pending Leaves</h3>
				<div class="count">
					<%
					Object pendingLeaves = request.getAttribute("pendingLeaves");
					out.print(pendingLeaves != null ? pendingLeaves : "0");
					%>
				</div>
				<div class="subtitle">Awaiting your approval</div>
			</div>

		</div>

		<!-- Divider -->
		<hr class="divider">

		<!-- Actions Section -->
		<div class="actions-section">
			<h2>Quick Actions</h2>
			<div class="actions-grid">
				<a href="viewEmployeesServlet" class="action-link">Manage
					Employees</a> <a href="attendance.jsp" class="action-link">Mark
					Attendance</a> <a href="leaveRequests" class="action-link">Manage
					Leave Requests</a> <a href="logout" class="action-link danger">Logout</a>
			</div>
		</div>

	</div>

	<!-- Footer -->
	<footer>
		<p>&copy; 2024 ELAMS - Employee Leave & Attendance Management
			System. All rights reserved.</p>
	</footer>

	<script>
		// Add click confirmation for important actions
		document.querySelectorAll('.action-link.danger').forEach(
				function(link) {
					link.addEventListener('click', function(e) {
						if (!confirm('Are you sure you want to logout?')) {
							e.preventDefault();
						}
					});
				});

		// Optional: Auto-refresh every 5 minutes
		// Uncomment the line below to enable auto-refresh
		// setTimeout(function() { location.reload(); }, 300000);
	</script>

</body>
</html>