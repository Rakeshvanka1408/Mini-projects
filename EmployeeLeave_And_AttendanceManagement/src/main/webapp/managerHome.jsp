<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equalsIgnoreCase("MANAGER")) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manager Dashboard - ELAMS</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', 'Roboto', sans-serif;
}

:root {
	--primary: #6366f1;
	--primary-dark: #4f46e5;
	--secondary: #8b5cf6;
	--accent: #f59e0b;
	--success: #10b981;
	--danger: #ef4444;
	--light: #f9fafb;
	--light-2: #f3f4f6;
	--border: #e5e7eb;
	--text-primary: #1f2937;
	--text-secondary: #6b7280;
	--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
	--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
	--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

body {
	background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
	min-height: 100vh;
	padding: 30px 20px;
	color: var(--text-primary);
}

.container {
	width: 100%;
	max-width: 1200px;
	margin: 0 auto;
}

/* Features Grid */
.features-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
	animation: slideUp 0.6s ease-out;
}

@keyframes slideUp {
	from {
		opacity: 0;
		transform: translateY(30px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.feature-card {
	background: white;
	border-radius: 16px;
	padding: 40px 30px;
	box-shadow: var(--shadow-lg);
	border-top: 5px solid var(--primary);
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	position: relative;
	overflow: hidden;
	height: 100%;
	display: block;
	text-decoration: none;
	color: inherit;
	cursor: pointer;
}

.feature-card::before {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	width: 150px;
	height: 150px;
	background: radial-gradient(circle, rgba(99, 102, 241, 0.08) 0%, transparent 70%);
	border-radius: 50%;
	transform: translate(50px, -50px);
}

.feature-card:hover {
	transform: translateY(-12px);
	box-shadow: 0 25px 50px rgba(99, 102, 241, 0.15);
}

.feature-card.employees {
	border-top-color: var(--primary);
}

.feature-card.tasks {
	border-top-color: var(--accent);
}

.feature-card.reports {
	border-top-color: var(--success);
}

.feature-icon {
	font-size: 64px;
	margin-bottom: 20px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
	position: relative;
	z-index: 1;
	display: block;
}

.feature-card.employees .feature-icon {
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.feature-card.tasks .feature-icon {
	background: linear-gradient(135deg, var(--accent), #d97706);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.feature-card.reports .feature-icon {
	background: linear-gradient(135deg, var(--success), #059669);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.feature-title {
	font-size: 24px;
	font-weight: 700;
	color: var(--text-primary);
	margin: 0 0 12px 0;
	position: relative;
	z-index: 1;
}

.feature-description {
	font-size: 15px;
	color: var(--text-secondary);
	line-height: 1.6;
	margin: 0 0 24px 0;
	position: relative;
	z-index: 1;
}

.feature-list {
	list-style: none;
	margin: 0;
	padding: 0;
	position: relative;
	z-index: 1;
}

.feature-list li {
	font-size: 15px;
	color: var(--text-primary);
	padding: 10px 0;
	display: flex;
	align-items: center;
	gap: 12px;
	font-weight: 500;
}

.feature-list li::before {
	content: '✓';
	width: 20px;
	height: 20px;
	background: var(--success);
	border-radius: 4px;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-shrink: 0;
	color: white;
	font-size: 12px;
	font-weight: bold;
}

/* Responsive */
@media (max-width: 1024px) {
	.features-grid {
		gap: 20px;
	}

	.feature-card {
		padding: 30px 25px;
	}

	.feature-title {
		font-size: 22px;
	}
}

@media (max-width: 768px) {
	body {
		padding: 20px 15px;
	}

	.features-grid {
		grid-template-columns: 1fr;
		gap: 15px;
	}

	.feature-card {
		padding: 25px 20px;
	}

	.feature-title {
		font-size: 20px;
	}

	.feature-icon {
		font-size: 50px;
		margin-bottom: 15px;
	}

	.feature-description {
		font-size: 14px;
		margin-bottom: 20px;
	}

	.feature-list li {
		font-size: 14px;
		padding: 8px 0;
	}
}

@media (max-width: 480px) {
	body {
		padding: 15px 10px;
	}

	.features-grid {
		gap: 12px;
	}

	.feature-card {
		padding: 20px 15px;
	}

	.feature-title {
		font-size: 18px;
	}

	.feature-icon {
		font-size: 40px;
		margin-bottom: 12px;
	}

	.feature-description {
		font-size: 13px;
		margin-bottom: 15px;
	}

	.feature-list li {
		font-size: 13px;
		padding: 6px 0;
	}
}
</style>

</head>

<body>

	<div class="container">

		<!-- Features Grid -->
		<div class="features-grid">

			<!-- Manage Employees -->
			<a class="feature-card employees" href="ManagerViewEmployeesServlet">
				<i class="fa-solid fa-users feature-icon"></i>
				<h2 class="feature-title">Manage Employees</h2>
				<p class="feature-description">View and manage all employee information, departments, and designations.</p>
				<ul class="feature-list">
					<li>View employee profiles</li>
					<li>Track departments</li>
					<li>Monitor designations</li>
				</ul>
			</a>

			<!-- Manage Tasks -->
			<a class="feature-card tasks" href="ViewTasksServlet">
				<i class="fa-solid fa-list-check feature-icon"></i>
				<h2 class="feature-title">Manage Tasks</h2>
				<p class="feature-description">Create, assign, and track tasks for your team with ease.</p>
				<ul class="feature-list">
					<li>Create new tasks</li>
					<li>Assign to employees</li>
					<li>Track progress</li>
				</ul>
			</a>

			<!-- View Reports -->
			<a class="feature-card reports" href="TaskReportServlet">
				<i class="fa-solid fa-chart-bar feature-icon"></i>
				<h2 class="feature-title">View Reports</h2>
				<p class="feature-description">Access comprehensive reports and analytics for better decision making.</p>
				<ul class="feature-list">
					<li>Task completion rates</li>
					<li>Performance metrics</li>
					<li>Team analytics</li>
				</ul>
			</a>

		</div>

	</div>

</body>
</html>