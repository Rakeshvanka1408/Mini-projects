<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String adminName = (String) session.getAttribute("username");

if (adminName == null || adminName.trim().isEmpty()) {
	adminName = "Administrator";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Home - ELAMS</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', sans-serif;
}

:root {
	--primary: #6366f1;
	--secondary: #8b5cf6;
	--success: #10b981;
	--danger: #ef4444;
	--warning: #f59e0b;
	--light: #f9fafb;
	--card: #ffffff;
	--text: #1f2937;
	--text-light: #6b7280;
}

body {
	background: linear-gradient(135deg, #f9fafb, #f3f4f6);
	padding: 30px;
}

/* Welcome Card */
.welcome-card {
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	border-radius: 20px;
	padding: 45px;
	color: white;
	margin-bottom: 35px;
	box-shadow: 0 20px 40px rgba(99, 102, 241, .25);
	position: relative;
	overflow: hidden;
}

.welcome-card::before {
	content: '';
	position: absolute;
	width: 300px;
	height: 300px;
	border-radius: 50%;
	background: rgba(255, 255, 255, .08);
	top: -100px;
	right: -80px;
}

.welcome-card::after {
	content: '';
	position: absolute;
	width: 220px;
	height: 220px;
	border-radius: 50%;
	background: rgba(255, 255, 255, .05);
	bottom: -80px;
	left: -50px;
}

.welcome-content {
	position: relative;
	z-index: 1;
	display: flex;
	align-items: center;
	gap: 30px;
}

.welcome-icon {
	font-size: 70px;
}

.welcome-text h1 {
	font-size: 38px;
	margin-bottom: 10px;
}

.welcome-text p {
	font-size: 17px;
	opacity: .95;
	line-height: 1.8;
}

/* Dashboard Cards */
.dashboard-cards {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
	gap: 25px;
}

.card {
	background: white;
	border-radius: 18px;
	padding: 30px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	transition: .3s;
	position: relative;
	overflow: hidden;
}

.card:hover {
	transform: translateY(-8px);
	box-shadow: 0 15px 35px rgba(0, 0, 0, .12);
}

.card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 5px;
}

.card.total::before {
	background: var(--primary);
}

.card.present::before {
	background: var(--success);
}

.card.absent::before {
	background: var(--danger);
}

.card.pending::before {
	background: var(--warning);
}

.icon {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 30px;
	margin-bottom: 20px;
}

.total .icon {
	background: rgba(99, 102, 241, .15);
	color: var(--primary);
}

.present .icon {
	background: rgba(16, 185, 129, .15);
	color: var(--success);
}

.absent .icon {
	background: rgba(239, 68, 68, .15);
	color: var(--danger);
}

.pending .icon {
	background: rgba(245, 158, 11, .15);
	color: var(--warning);
}

.card h3 {
	color: var(--text-light);
	font-size: 14px;
	text-transform: uppercase;
	letter-spacing: 1px;
	margin-bottom: 15px;
}

.count {
	font-size: 42px;
	font-weight: 700;
	color: var(--text);
	margin-bottom: 10px;
}

.subtitle {
	color: var(--text-light);
	font-size: 14px;
}

/* Quick Actions */
.quick-actions {
	margin-top: 40px;
	background: white;
	border-radius: 18px;
	padding: 30px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
}

.quick-actions h2 {
	margin-bottom: 25px;
	color: var(--text);
}

.action-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
}

.action-btn {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	padding: 18px;
	border-radius: 12px;
	text-decoration: none;
	color: white;
	font-weight: 600;
	transition: .3s;
}

.action-btn:hover {
	transform: translateY(-5px);
}

.employees {
	background: #6366f1;
}

.attendance {
	background: #3b82f6;
}

.leaves {
	background: #10b981;
}

.reports {
	background: #f59e0b;
}

/* Responsive */
@media ( max-width :768px) {
	body {
		padding: 20px;
	}
	.welcome-content {
		flex-direction: column;
		text-align: center;
	}
	.welcome-text h1 {
		font-size: 28px;
	}
	.welcome-icon {
		font-size: 55px;
	}
	.count {
		font-size: 32px;
	}
}
</style>
</head>

<body>

	<div class="welcome-card">

		<div class="welcome-content">

			<div class="welcome-icon">
				<i class="fa-solid fa-user-shield"></i>
			</div>

			<div class="welcome-text">
				<h1>
					Welcome,
					<%=adminName%>!
				</h1>
				<p>Manage employees, monitor attendance, approve leave requests
					and generate reports from one centralized administration portal.</p>
			</div>

		</div>

	</div>

	<div class="dashboard-cards">

		<div class="card total">

			<div class="icon">
				<i class="fa-solid fa-users"></i>
			</div>

			<h3>Total Employees</h3>

			<div class="count">${employeeCount}</div>

			<div class="subtitle">Active employees in the organization</div>

		</div>

		<div class="card present">

			<div class="icon">
				<i class="fa-solid fa-user-check"></i>
			</div>

			<h3>Present Today</h3>

			<div class="count">${presentCount}</div>

			<div class="subtitle">Employees marked present today</div>

		</div>

		<div class="card absent">

			<div class="icon">
				<i class="fa-solid fa-user-xmark"></i>
			</div>

			<h3>Absent Today</h3>

			<div class="count">${absentCount}</div>

			<div class="subtitle">Employees absent today</div>

		</div>

		<div class="card pending">

			<div class="icon">
				<i class="fa-solid fa-hourglass-half"></i>
			</div>

			<h3>Pending Leaves</h3>

			<div class="count">${pendingLeaves}</div>

			<div class="subtitle">Leave requests awaiting approval</div>

		</div>

	</div>

	<div class="quick-actions">

		<h2>Quick Actions</h2>

		<div class="action-grid">

			<a href="viewEmployeesServlet" class="action-btn employees"> <i
				class="fa-solid fa-users"></i> Manage Employees
			</a> <a href="attendance.jsp" class="action-btn attendance"> <i
				class="fa-solid fa-calendar-check"></i> Attendance
			</a> <a href="leaveRequests" class="action-btn leaves"> <i
				class="fa-solid fa-file-signature"></i> Leave Requests
			</a> <a href="reports" class="action-btn reports"> <i
				class="fa-solid fa-chart-line"></i> Reports
			</a>

		</div>

	</div>

</body>
</html>