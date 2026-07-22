<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");
String adminName = (String) session.getAttribute("username");

if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
	response.sendRedirect("login.jsp");
	return;
}

if (adminName == null || adminName.trim().isEmpty()) {
	adminName = "Administrator";
}

String initials = "";
String[] parts = adminName.split(" ");

for (String p : parts) {
	if (!p.isEmpty()) {
		initials += p.substring(0, 1).toUpperCase();
	}
}

if (initials.isEmpty()) {
	initials = "A";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - ELAMS</title>

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
	--danger: #ef4444;
	--dark: #1f2937;
	--light: #f9fafb;
	--card: #ffffff;
	--border: #e5e7eb;
}

body {
	overflow: hidden;
	background: #f5f7fb;
}

/* Sidebar */
.sidebar {
	position: fixed;
	left: 0;
	top: 0;
	width: 280px;
	height: 100vh;
	background: linear-gradient(135deg, #1f2937, #111827);
	transition: .4s;
	z-index: 1000;
}

.sidebar.hide {
	left: -280px;
}

.logo {
	height: 90px;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 12px;
	color: white;
	font-size: 28px;
	font-weight: 700;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
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
	gap: 15px;
	padding: 15px 20px;
	text-decoration: none;
	color: #e5e7eb;
	border-radius: 10px;
	transition: .3s;
}

.sidebar ul li a:hover, .sidebar ul li a.active {
	background: rgba(99, 102, 241, .2);
	color: white;
}

.sidebar ul li a i {
	width: 25px;
	text-align: center;
}

/* Header */
.header {
	position: fixed;
	top: 0;
	left: 280px;
	right: 0;
	height: 90px;
	background: white;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 30px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, .1);
	transition: .4s;
}

.header.full {
	left: 0;
}

.header-title {
	font-size: 24px;
	font-weight: 700;
	color: var(--primary);
}

.menu-btn {
	display: none;
	font-size: 24px;
	cursor: pointer;
	margin-right: 20px;
}

.menu-btn.show {
	display: block;
}

.header-left {
	display: flex;
	align-items: center;
}

.header-right {
	display: flex;
	align-items: center;
	gap: 20px;
}

.avatar {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	display: flex;
	justify-content: center;
	align-items: center;
	color: white;
	font-weight: bold;
}

.logout-btn {
	padding: 10px 15px;
	border: none;
	border-radius: 8px;
	background: var(--danger);
	color: white;
	cursor: pointer;
}

/* Content */
.content {
	margin-left: 280px;
	margin-top: 90px;
	height: calc(100vh - 90px);
	padding: 25px;
	transition: .4s;
}

.content.full {
	margin-left: 0;
}

.content iframe {
	width: 100%;
	height: 100%;
	border: none;
	border-radius: 15px;
	background: white;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .1);
}

/* Responsive */
@media ( max-width :768px) {
	.sidebar {
		left: -280px;
	}
	.header {
		left: 0;
	}
	.content {
		margin-left: 0;
	}
	.menu-btn {
		display: block;
	}
}
</style>
</head>

<body>

	<div class="sidebar" id="sidebar">

		<div class="logo">
			<i class="fa-solid fa-layer-group"></i> ELAMS
		</div>

		<ul>

			<li><a href="adminHome.jsp" target="contentFrame"
				onclick="loadPage(this)" class="active"> <i
					class="fa-solid fa-gauge"></i> Dashboard
			</a></li>

			<li><a href="viewEmployeesServlet" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-users"></i>
					Employees
			</a></li>

			<li><a href="attendance.jsp" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-calendar-check"></i>
					Attendance
			</a></li>

			<li><a href="leaveRequests" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-file-signature"></i>
					Leave Requests
			</a></li>

			<li><a href="reports" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-chart-line"></i>
					Reports
			</a></li>

			<li><a href="logout"> <i
					class="fa-solid fa-right-from-bracket"></i> Logout
			</a></li>

		</ul>

	</div>

	<div class="header" id="header">

		<div class="header-left">

			<i class="fa-solid fa-bars menu-btn" id="menuBtn"
				onclick="toggleSidebar()"></i>

			<div class="header-title">
				<i class="fa-solid fa-user-shield"></i> Admin Portal
			</div>

		</div>

		<div class="header-right">

			<div class="avatar">
				<%=initials%>
			</div>

			<div>
				<strong><%=adminName%></strong><br> <small>Administrator</small>
			</div>

			<form action="logout" method="post">
				<button class="logout-btn">
					<i class="fa-solid fa-power-off"></i> Logout
				</button>
			</form>

		</div>

	</div>

	<div class="content" id="content">
		<iframe name="contentFrame" src="adminHome.jsp"></iframe>
	</div>

	<script>

function toggleSidebar(){

    const sidebar=document.getElementById("sidebar");
    const header=document.getElementById("header");
    const content=document.getElementById("content");
    const menuBtn=document.getElementById("menuBtn");

    sidebar.classList.toggle("hide");

    if(sidebar.classList.contains("hide")){
        header.classList.add("full");
        content.classList.add("full");
        menuBtn.classList.add("show");
    }
    else{
        header.classList.remove("full");
        content.classList.remove("full");
        menuBtn.classList.remove("show");
    }
}

function loadPage(link){

    document.querySelectorAll(".sidebar a")
    .forEach(a=>a.classList.remove("active"));

    link.classList.add("active");

    document.getElementById("sidebar").classList.add("hide");
    document.getElementById("header").classList.add("full");
    document.getElementById("content").classList.add("full");
    document.getElementById("menuBtn").classList.add("show");
}

</script>

</body>
</html>