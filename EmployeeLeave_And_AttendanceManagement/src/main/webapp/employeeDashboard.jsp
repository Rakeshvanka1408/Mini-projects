<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Dashboard - ELAMS</title>

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
}

/* ===== HEADER/NAVBAR ===== */
.navbar {
	background-color: #27ae60;
	color: white;
	padding: 15px 20px;
	text-align: center;
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
	float: right;
	transition: background-color 0.3s;
}

.navbar .logout-btn:hover {
	background-color: #c0392b;
}

/* ===== MAIN CONTAINER ===== */
.container {
	max-width: 1000px;
	margin: 30px auto;
	padding: 0 20px;
}

/* Page Title */
.page-title {
	font-size: 28px;
	color: #27ae60;
	margin-bottom: 30px;
	border-bottom: 3px solid #27ae60;
	padding-bottom: 10px;
	text-align: center;
}

/* Subtitle/Description */
.page-subtitle {
	font-size: 14px;
	color: #7f8c8d;
	text-align: center;
	margin-bottom: 30px;
}

/* ===== MENU CARDS SECTION ===== */

/* Cards Container - Holds all menu items */
.menu-cards {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
	margin-bottom: 50px;
}

/* Individual Menu Card */
.menu-card {
	background-color: white;
	border: 2px solid #bdc3c7;
	border-radius: 8px;
	padding: 25px;
	width: 220px;
	text-align: center;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	transition: all 0.3s;
	text-decoration: none;
	color: #333;
	display: block;
}

/* Card hover effect - lift up */
.menu-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
	border-color: #27ae60;
}

/* Card left border colors */
.menu-card.attendance {
	border-left: 5px solid #3498db;
}

.menu-card.leave-apply {
	border-left: 5px solid #f39c12;
}

.menu-card.leave-history {
	border-left: 5px solid #9b59b6;
}

.menu-card.attendance-history {
	border-left: 5px solid #1abc9c;
}

/* Card Icon */
.menu-card .icon {
	font-size: 40px;
	margin-bottom: 15px;
	display: block;
}

/* Card Title */
.menu-card h3 {
	font-size: 16px;
	color: #2c3e50;
	margin-bottom: 10px;
	font-weight: bold;
}

/* Card Description */
.menu-card .description {
	font-size: 12px;
	color: #95a5a6;
	line-height: 1.5;
}

/* Logout Button Card - Different styling */
.menu-card.logout {
	border-left: 5px solid #e74c3c;
	background-color: #fff5f5;
}

.menu-card.logout:hover {
	border-color: #e74c3c;
}

.menu-card.logout h3 {
	color: #e74c3c;
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
	/* Stack navbar items */
	.navbar {
		text-align: left;
	}
	.navbar .logout-btn {
		float: none;
		display: block;
		margin-top: 10px;
		text-align: center;
	}

	/* Make title smaller */
	.page-title {
		font-size: 22px;
	}

	/* Stack cards vertically */
	.menu-cards {
		flex-direction: column;
		align-items: center;
	}
	.menu-card {
		width: 100%;
		max-width: 300px;
	}
	.container {
		margin: 20px auto;
	}
}

/* ===== INFO BOX ===== */
.info-box {
	background-color: #ecf0f1;
	border-left: 4px solid #3498db;
	padding: 15px;
	border-radius: 4px;
	margin-bottom: 30px;
	font-size: 13px;
	color: #2c3e50;
}
</style>

</head>

<body>

	<!-- ===== HEADER/NAVIGATION ===== -->
	<div class="navbar">
		<h1>ELAMS - Employee Dashboard</h1>
		<a href="logout" class="logout-btn">Logout</a>
	</div>

	<!-- ===== MAIN CONTENT AREA ===== -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Welcome to Your Dashboard</h2>

		<!-- Page Subtitle -->
		<p class="page-subtitle">Manage your attendance and leave requests
			from here</p>

		<!-- Info Box -->
		<div class="info-box">
			<strong>ℹ️ Note:</strong> You can mark your daily attendance, apply
			for leaves, and view your history from the options below.
		</div>

		<!-- ===== MENU CARDS SECTION ===== -->
		<div class="menu-cards">
			<li><a
				href="EmployeeTasksServlet?employeeId=${sessionScope.employee.employeeId}">
					My Tasks </a></li>
			<!-- CARD 1: Mark Attendance -->
			<a href="attendance.jsp" class="menu-card attendance"> <span
				class="icon">📋</span>
				<h3>Mark Attendance</h3>
				<p class="description">Record your daily attendance status</p>
			</a>

			<!-- CARD 2: Apply Leave -->
			<a href="applyLeave.jsp" class="menu-card leave-apply"> <span
				class="icon">📝</span>
				<h3>Apply Leave</h3>
				<p class="description">Submit a leave request for your time off</p>
			</a>

			<!-- CARD 3: Leave History -->
			<a href="leaveHistory?employeeId=1" class="menu-card leave-history">
				<span class="icon">📅</span>
				<h3>Leave History</h3>
				<p class="description">View all your leave requests and status</p>
			</a>

			<!-- CARD 4: Attendance History -->
			<a href="attendanceHistory?employeeId=1"
				class="menu-card attendance-history"> <span class="icon">📊</span>
				<h3>Attendance History</h3>
				<p class="description">Check your monthly attendance records</p>
			</a>

			<!-- CARD 5: Logout -->
			<a href="logout" class="menu-card logout"
				onclick="return confirm('Are you sure you want to logout?');"> <span
				class="icon">🚪</span>
				<h3>Logout</h3>
				<p class="description">Sign out from your account</p>
			</a>

		</div>

	</div>

	<!-- ===== FOOTER ===== -->
	<footer>
		<p>&copy; 2024 ELAMS - Employee Leave & Attendance Management
			System. All rights reserved.</p>
	</footer>

</body>

</html>