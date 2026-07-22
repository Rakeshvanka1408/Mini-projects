<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");
Integer employeeId = (Integer) session.getAttribute("employeeId");
String employeeName = (String) session.getAttribute("employeeName");

if (role == null || !role.equalsIgnoreCase("EMPLOYEE")) {
	response.sendRedirect("login.jsp");
	return;
}

if (employeeName == null || employeeName.trim().isEmpty()) {
	employeeName = "Employee";
}

// Extract initials from employee name
String[] nameParts = employeeName.trim().split(" ");
String initials = "";
for (String part : nameParts) {
	if (!part.isEmpty()) {
		initials += part.substring(0, 1).toUpperCase();
	}
}
if (initials.isEmpty()) {
	initials = "E";
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Dashboard - ELAMS</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', 'Roboto', sans-serif;
}

:root {
	--primary-color: #6366f1;
	--secondary-color: #8b5cf6;
	--accent-color: #f59e0b;
	--dark-bg: #1f2937;
	--light-bg: #f9fafb;
	--card-bg: #ffffff;
	--border-color: #e5e7eb;
	--text-primary: #1f2937;
	--text-secondary: #6b7280;
	--success-color: #10b981;
	--warning-color: #f59e0b;
	--danger-color: #ef4444;
	--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
	--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
	--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

body {
	background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
	color: var(--text-primary);
	overflow: hidden;
}

/* ===== SIDEBAR ===== */
.sidebar {
	position: fixed;
	left: 0;
	top: 0;
	width: 280px;
	height: 100vh;
	background: linear-gradient(135deg, var(--dark-bg) 0%, #111827 100%);
	box-shadow: var(--shadow-lg);
	transition: left 0.4s cubic-bezier(0.4, 0, 0.2, 1);
	z-index: 1000;
	overflow-y: auto;
}

.sidebar.hide {
	left: -280px;
}

.sidebar::-webkit-scrollbar {
	width: 6px;
}

.sidebar::-webkit-scrollbar-thumb {
	background: rgba(255, 255, 255, 0.2);
	border-radius: 3px;
}

.logo {
	height: 90px;
	background: linear-gradient(135deg, var(--primary-color) 0%,
		var(--secondary-color) 100%);
	display: flex;
	justify-content: center;
	align-items: center;
	color: white;
	font-size: 28px;
	font-weight: 700;
	letter-spacing: 1px;
	padding: 20px;
	gap: 12px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.logo i {
	font-size: 32px;
}

.sidebar ul {
	list-style: none;
	padding: 20px 0;
}

.sidebar ul li {
	margin: 8px 12px;
}

.sidebar ul li a {
	display: flex;
	align-items: center;
	gap: 16px;
	padding: 14px 20px;
	text-decoration: none;
	color: #e5e7eb;
	border-radius: 10px;
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	font-size: 15px;
	font-weight: 500;
	position: relative;
	overflow: hidden;
}

.sidebar ul li a::before {
	content: '';
	position: absolute;
	left: 0;
	top: 0;
	width: 4px;
	height: 100%;
	background: var(--accent-color);
	border-radius: 0 4px 4px 0;
	transform: scaleY(0);
	transition: transform 0.3s ease;
}

.sidebar ul li a:hover {
	background: rgba(99, 102, 241, 0.15);
	color: white;
	padding-left: 24px;
	transform: translateX(4px);
}

.sidebar ul li a:hover::before {
	transform: scaleY(1);
}

.sidebar ul li a.active {
	background: rgba(99, 102, 241, 0.2);
	color: white;
	border-left: 4px solid var(--primary-color);
	padding-left: 20px;
}

.sidebar ul li a i {
	width: 24px;
	text-align: center;
	font-size: 18px;
}

.sidebar-divider {
	height: 1px;
	background: rgba(255, 255, 255, 0.1);
	margin: 20px 0;
}

/* ===== HEADER ===== */
.header {
	position: fixed;
	left: 280px;
	right: 0;
	top: 0;
	height: 90px;
	background: var(--card-bg);
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 30px;
	box-shadow: var(--shadow-md);
	transition: left 0.4s cubic-bezier(0.4, 0, 0.2, 1);
	z-index: 900;
	border-bottom: 1px solid var(--border-color);
}

.header.full {
	left: 0;
}

.header-left {
	display: flex;
	align-items: center;
	gap: 20px;
}

.menu-btn {
	font-size: 24px;
	cursor: pointer;
	display: none;
	color: var(--text-primary);
	transition: color 0.3s ease;
	padding: 8px;
	border-radius: 8px;
}

.menu-btn:hover {
	color: var(--primary-color);
	background: var(--light-bg);
}

.menu-btn.show {
	display: block;
}

.header-title {
	font-size: 24px;
	font-weight: 700;
	background: linear-gradient(135deg, var(--primary-color),
		var(--secondary-color));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
	display: flex;
	align-items: center;
	gap: 12px;
}

.header-right {
	display: flex;
	align-items: center;
	gap: 25px;
}

.header-info {
	display: flex;
	align-items: center;
	gap: 15px;
	padding-right: 25px;
	border-right: 1px solid var(--border-color);
	cursor: pointer;
	transition: all 0.3s ease;
	padding: 8px 15px;
	border-radius: 8px;
}

.header-info:hover {
	background: var(--light-bg);
}

.user-avatar {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background: linear-gradient(135deg, var(--primary-color),
		var(--secondary-color));
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-weight: 700;
	font-size: 18px;
	box-shadow: var(--shadow-md);
	flex-shrink: 0;
}

.user-details {
	display: flex;
	flex-direction: column;
	gap: 2px;
	min-width: 150px;
}

.user-details h4 {
	font-size: 14px;
	font-weight: 700;
	color: var(--text-primary);
	margin: 0;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.user-details p {
	font-size: 12px;
	color: var(--text-secondary);
	margin: 0;
	font-weight: 500;
}

.logout-btn {
	padding: 10px 16px;
	background: linear-gradient(135deg, var(--danger-color), #dc2626);
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 600;
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
	gap: 8px;
}

.logout-btn:hover {
	transform: translateY(-2px);
	box-shadow: var(--shadow-lg);
}

/* ===== CONTENT ===== */
.content {
	margin-left: 280px;
	margin-top: 90px;
	padding: 30px;
	height: calc(100vh - 90px);
	transition: margin-left 0.4s cubic-bezier(0.4, 0, 0.2, 1);
	background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
	overflow-y: auto;
	overflow-x: hidden;
}

.content.full {
	margin-left: 0;
}

.content::-webkit-scrollbar {
	width: 8px;
}

.content::-webkit-scrollbar-thumb {
	background: var(--primary-color);
	border-radius: 10px;
}

.content::-webkit-scrollbar-track {
	background: var(--light-bg);
}

.content iframe {
	width: 100%;
	height: 100%;
	border: none;
	border-radius: 16px;
	background: var(--card-bg);
	box-shadow: var(--shadow-lg);
}

/* ===== RESPONSIVE ===== */
@media ( max-width : 1024px) {
	.sidebar {
		width: 250px;
		left: -250px;
	}
	.header {
		left: 0;
		padding: 0 20px;
	}
	.content {
		margin-left: 0;
		padding: 20px;
	}
	.menu-btn.show {
		display: block;
	}
	.header-info {
		border-right: none;
		padding-right: 0;
	}
	.user-details {
		display: none;
	}
}

@media ( max-width : 768px) {
	.sidebar {
		width: 240px;
		left: -240px;
		z-index: 1001;
	}
	.header {
		left: 0;
		padding: 0 16px;
	}
	.content {
		margin-left: 0;
		padding: 16px;
		margin-top: 80px;
	}
	.header-right {
		gap: 15px;
	}
	.logo {
		font-size: 22px;
		height: 80px;
	}
	.logout-btn {
		padding: 8px 12px;
		font-size: 12px;
	}
	.user-avatar {
		width: 45px;
		height: 45px;
		font-size: 16px;
	}
}

@media ( max-width : 480px) {
	.sidebar {
		width: 220px;
	}
	.header-title {
		font-size: 18px;
	}
	.user-avatar {
		width: 40px;
		height: 40px;
		font-size: 14px;
	}
	.user-details {
		display: none;
	}
	.header-info {
		padding: 5px;
		gap: 10px;
	}
}
</style>
</head>

<body>
	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div class="logo">
			<i class="fa-solid fa-layer-group"></i> <span>ELAMS</span>
		</div>

		<ul>
			<li><a href="employeeHome.jsp" target="contentFrame"
				onclick="loadPage(this)" class="active"> <i
					class="fa-solid fa-gauge"></i> <span>Dashboard</span>
			</a></li>

			<li><a href="EmployeeTasksServlet" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-list-check"></i>
					<span>My Tasks</span>
			</a></li>

			<li><a href="attendance.jsp" target="contentFrame"
				onclick="loadPage(this)"> <i
					class="fa-solid fa-calendar-check"></i> <span>Mark
						Attendance</span>
			</a></li>

			<li><a href="applyLeave.jsp" target="contentFrame"
				onclick="loadPage(this)"> <i
					class="fa-solid fa-file-signature"></i> <span>Apply Leave</span>
			</a></li>

			<li><a href="leaveHistory?employeeId=<%=employeeId%>"
				target="contentFrame" onclick="loadPage(this)"> <i
					class="fa-solid fa-clock-rotate-left"></i> <span>Leave
						History</span>
			</a></li>

			<li><a href="attendanceHistory?employeeId=<%=employeeId%>"
				target="contentFrame" onclick="loadPage(this)"> <i
					class="fa-solid fa-chart-column"></i> <span>Attendance
						History</span>
			</a></li>

			<div class="sidebar-divider"></div>

			<li><a href="logout"> <i
					class="fa-solid fa-right-from-bracket"></i> <span>Logout</span>
			</a></li>
		</ul>
	</div>

	<!-- Header -->
	<div class="header" id="header">
		<div class="header-left">
			<i class="fa-solid fa-bars menu-btn" id="menuBtn"
				onclick="toggleSidebar()"></i>
			<div class="header-title">
				<i class="fa-solid fa-user"></i> Employee Portal
			</div>
		</div>

		<div class="header-right">
			<div class="header-info" title="<%=employeeName%>">
				<div class="user-avatar">
					<%=initials%>
				</div>

				<div class="user-details">
					<h4><%=employeeName%></h4>
					<p>Employee</p>
				</div>
			</div>
			<form action="logout" method="POST" style="display: none;"
				id="logoutForm"></form>
			<button class="logout-btn"
				onclick="document.getElementById('logoutForm').submit()">
				<i class="fa-solid fa-power-off"></i> <span>Logout</span>
			</button>
		</div>
	</div>

	<!-- Content -->
	<div class="content" id="content">
		<iframe name="contentFrame" src="employeeHome.jsp"></iframe>
	</div>

	<script>
        function toggleSidebar() {
            const sidebar = document.getElementById("sidebar");
            const header = document.getElementById("header");
            const content = document.getElementById("content");
            const menuBtn = document.getElementById("menuBtn");

            sidebar.classList.toggle("hide");

            if (sidebar.classList.contains("hide")) {
                header.classList.add("full");
                content.classList.add("full");
                menuBtn.classList.add("show");
            } else {
                header.classList.remove("full");
                content.classList.remove("full");
                menuBtn.classList.remove("show");
            }
        }

        function loadPage(link) {
            document.querySelectorAll(".sidebar a")
                .forEach(item => item.classList.remove("active"));

            link.classList.add("active");

            const sidebar = document.getElementById("sidebar");
            const header = document.getElementById("header");
            const content = document.getElementById("content");
            const menuBtn = document.getElementById("menuBtn");

            sidebar.classList.add("hide");
            header.classList.add("full");
            content.classList.add("full");
            menuBtn.classList.add("show");
        }

        // Close sidebar when clicking outside
        document.addEventListener("click", function(event) {
            const sidebar = document.getElementById("sidebar");
            const menuBtn = document.getElementById("menuBtn");

            if (!sidebar.contains(event.target) && !menuBtn.contains(event.target)) {
                if (!sidebar.classList.contains("hide")) {
                    toggleSidebar();
                }
            }
        });
    </script>

</body>
</html>