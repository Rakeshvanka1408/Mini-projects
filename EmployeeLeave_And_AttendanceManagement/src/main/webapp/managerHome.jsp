<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String managerName = (String) session.getAttribute("managerName");

if(managerName == null || managerName.trim().isEmpty()){
    managerName = "Manager";
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

/* Welcome Card */
.welcome-card {
	background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
	border-radius: 16px;
	padding: 50px 40px;
	color: white;
	margin-bottom: 40px;
	box-shadow: 0 20px 40px rgba(99, 102, 241, 0.2);
	animation: slideDown 0.5s ease-out;
	position: relative;
	overflow: hidden;
}

.welcome-card::before {
	content: '';
	position: absolute;
	top: -50%;
	right: -10%;
	width: 400px;
	height: 400px;
	background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
	border-radius: 50%;
}

.welcome-card::after {
	content: '';
	position: absolute;
	bottom: -30%;
	left: -5%;
	width: 300px;
	height: 300px;
	background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
	border-radius: 50%;
}

@keyframes slideDown {
	from {
		opacity: 0;
		transform: translateY(-30px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.welcome-content {
	position: relative;
	z-index: 1;
	display: flex;
	align-items: center;
	gap: 30px;
}

.welcome-icon {
	font-size: 80px;
	opacity: 0.9;
	flex-shrink: 0;
	animation: float 3s ease-in-out infinite;
}

@keyframes float {
	0%, 100% {
		transform: translateY(0px);
	}
	50% {
		transform: translateY(-10px);
	}
}

.welcome-text h1 {
	font-size: 42px;
	font-weight: 700;
	margin: 0 0 12px 0;
	letter-spacing: -0.5px;
}

.welcome-text p {
	font-size: 17px;
	opacity: 0.95;
	margin: 0;
	line-height: 1.6;
}

/* Features Grid */
.features-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
	margin-top: 40px;
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
	.welcome-card {
		padding: 40px 30px;
	}

	.welcome-content {
		gap: 20px;
	}

	.welcome-icon {
		font-size: 60px;
	}

	.welcome-text h1 {
		font-size: 36px;
	}

	.welcome-text p {
		font-size: 16px;
	}

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

	.welcome-card {
		padding: 35px 25px;
		margin-bottom: 30px;
	}

	.welcome-content {
		flex-direction: column;
		gap: 15px;
		text-align: center;
	}

	.welcome-icon {
		font-size: 50px;
	}

	.welcome-text h1 {
		font-size: 28px;
	}

	.welcome-text p {
		font-size: 15px;
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

	.welcome-card {
		padding: 25px 20px;
		margin-bottom: 20px;
	}

	.welcome-icon {
		font-size: 40px;
	}

	.welcome-text h1 {
		font-size: 22px;
	}

	.welcome-text p {
		font-size: 14px;
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

		<!-- Welcome Card -->
		<div class="welcome-card">
			<div class="welcome-content">
				<div class="welcome-icon">
					<i class="fa-solid fa-chart-line"></i>
				</div>
				<div class="welcome-text">
					<h1>Welcome, <%=managerName%>!</h1>
					<p>Manage employees, tasks, and reports from one centralized dashboard. Get real-time insights and stay organized.</p>
				</div>
			</div>
		</div>

		<!-- Features Grid -->
		<div class="features-grid">

			<!-- Manage Employees -->
			<div class="feature-card employees">
				<i class="fa-solid fa-users feature-icon"></i>
				<h2 class="feature-title">Manage Employees</h2>
				<p class="feature-description">View and manage all employee information, departments, and designations.</p>
				<ul class="feature-list">
					<li>View employee profiles</li>
					<li>Track departments</li>
					<li>Monitor designations</li>
				</ul>
			</div>

			<!-- Manage Tasks -->
			<div class="feature-card tasks">
				<i class="fa-solid fa-list-check feature-icon"></i>
				<h2 class="feature-title">Manage Tasks</h2>
				<p class="feature-description">Create, assign, and track tasks for your team with ease.</p>
				<ul class="feature-list">
					<li>Create new tasks</li>
					<li>Assign to employees</li>
					<li>Track progress</li>
				</ul>
			</div>

			<!-- View Reports -->
			<div class="feature-card reports">
				<i class="fa-solid fa-chart-bar feature-icon"></i>
				<h2 class="feature-title">View Reports</h2>
				<p class="feature-description">Access comprehensive reports and analytics for better decision making.</p>
				<ul class="feature-list">
					<li>Task completion rates</li>
					<li>Performance metrics</li>
					<li>Team analytics</li>
				</ul>
			</div>

		</div>

	</div>

</body>
</html>
