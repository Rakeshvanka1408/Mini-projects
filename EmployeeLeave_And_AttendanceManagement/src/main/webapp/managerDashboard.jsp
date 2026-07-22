Q<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");
String managerName = (String) session.getAttribute("managerName");
String username = (String) session.getAttribute("username");

if (role == null || !role.equalsIgnoreCase("MANAGER")) {
	response.sendRedirect("login.jsp");
	return;
}

if (managerName == null || managerName.trim().isEmpty())
	managerName = "Manager";

if (username == null || username.trim().isEmpty())
	username = managerName;

String initials = "";
for (String part : managerName.trim().split("\\s+")) {
	if (!part.isEmpty())
		initials += part.substring(0, 1).toUpperCase();
}

if (initials.length() > 2)
	initials = initials.substring(0, 2);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ELAMS | Manager Dashboard</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

:root {
	--primary: #2563eb;
	--secondary: #1e40af;
	--accent: #0ea5e9;
	--success: #22c55e;
	--warning: #f59e0b;
	--danger: #ef4444;
	--bg: #f4f7fb;
	--card: #ffffff;
	--sidebar: #111827;
	--sidebarHover: #1f2937;
	--text: #1f2937;
	--gray: #64748b;
	--radius: 16px;
	--shadow: 0 10px 25px rgba(0, 0, 0, .08);
}

body {
	background: var(--bg);
	overflow: hidden;
	color: var(--text);
}

/* ===============================
 SIDEBAR
================================ */
.sidebar {
	position: fixed;
	left: 0;
	top: 0;
	width: 280px;
	height: 100vh;
	background: linear-gradient(180deg, #111827, #1f2937);
	color: white;
	transition: .35s;
	overflow: auto;
	z-index: 999;
}

.sidebar.hide {
	left: -280px;
}

.sidebar-header {
	height: 90px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 28px;
	font-weight: 700;
	gap: 12px;
	background: #2563eb;
	letter-spacing: 1px;
}

.sidebar-header i {
	font-size: 32px;
}

.sidebar ul {
	list-style: none;
	padding: 20px 15px;
}

.sidebar ul li {
	margin-bottom: 10px;
}

.sidebar ul li a {
	display: flex;
	align-items: center;
	gap: 15px;
	padding: 15px;
	text-decoration: none;
	color: #d1d5db;
	border-radius: 12px;
	transition: .3s;
	font-size: 15px;
	font-weight: 500;
}

.sidebar ul li a:hover {
	background: #374151;
	color: #fff;
	transform: translateX(5px);
}

.sidebar ul li a.active {
	background: var(--primary);
	color: #fff;
	box-shadow: var(--shadow);
}

.sidebar ul li a i {
	width: 22px;
	text-align: center;
}

/* ===============================
HEADER
=============================== */
.header {
	position: fixed;
	left: 280px;
	right: 0;
	top: 0;
	height: 90px;
	background: white;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 35px;
	box-shadow: var(--shadow);
	transition: .35s;
	z-index: 900;
}

.header.full {
	left: 0;
}

/* search */
.search-box {
	width: 420px;
	background: #f1f5f9;
	display: flex;
	align-items: center;
	padding: 12px 18px;
	border-radius: 50px;
}

.search-box input {
	border: none;
	background: none;
	outline: none;
	width: 100%;
	font-size: 14px;
	margin-left: 10px;
}

/* right side */
.header-right {
	display: flex;
	align-items: center;
	gap: 25px;
}

/* notification */
.notification {
	position: relative;
	cursor: pointer;
	font-size: 22px;
}

.badge {
	position: absolute;
	top: -6px;
	right: -8px;
	background: red;
	color: white;
	font-size: 11px;
	padding: 2px 6px;
	border-radius: 50px;
}

/* profile */
.profile {
	display: flex;
	align-items: center;
	gap: 15px;
	cursor: pointer;
}

.avatar {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background: linear-gradient(135deg, var(--primary), var(--accent));
	display: flex;
	justify-content: center;
	align-items: center;
	color: white;
	font-weight: bold;
	font-size: 18px;
}

.profile-info h4 {
	font-size: 15px;
}

.profile-info p {
	font-size: 12px;
	color: gray;
}

/* ==========================
CONTENT
========================== */
.main {
	margin-left: 280px;
	margin-top: 90px;
	padding: 30px;
	height: calc(100vh - 90px);
	overflow: hidden;
	transition: .35s;
	display: flex;
	flex-direction: column;
}

.main.full {
	margin-left: 0;
}

/* breadcrumb */
.breadcrumb {
	display: flex;
	align-items: center;
	gap: 10px;
	color: gray;
	margin-bottom: 25px;
	font-size: 14px;
	flex-shrink: 0;
}

.breadcrumb.hide {
	display: none;
}

/* welcome */
.welcome {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: white;
	padding: 30px;
	border-radius: 20px;
	box-shadow: var(--shadow);
	margin-bottom: 30px;
	flex-shrink: 0;
}

.welcome.hide {
	display: none;
}

.welcome h2 {
	font-size: 30px;
}

.welcome p {
	color: gray;
	margin-top: 8px;
}

.quick-buttons {
	display: flex;
	gap: 15px;
}

.quick-buttons button {
	border: none;
	padding: 12px 20px;
	border-radius: 10px;
	background: var(--primary);
	color: white;
	cursor: pointer;
	font-weight: 600;
	transition: .3s;
}

.quick-buttons button:hover {
	transform: translateY(-3px);
	background: var(--secondary);
}

/* ==========================
IFRAME PANEL
========================== */
.content-panel {
	background: white;
	border-radius: 20px;
	box-shadow: var(--shadow);
	overflow: hidden;
	flex: 1;
	min-height: 0;
}

.content-panel iframe {
	width: 100%;
	height: 100%;
	border: none;
	display: block;
}

/* ===========================
DARK MODE
===========================*/
body.dark {
	background: #0f172a;
	color: white;
}

body.dark .header, body.dark .content-panel, body.dark .welcome {
	background: #1e293b;
	color: white;
}

body.dark .search-box {
	background: #334155;
}

body.dark input {
	color: white;
}

body.dark .profile-info p, body.dark .breadcrumb {
	color: #cbd5e1;
}

/* ===========================
RESPONSIVE
===========================*/
@media ( max-width : 992px) {
	.sidebar {
		left: -280px;
	}
	.header {
		left: 0;
	}
	.main {
		margin-left: 0;
	}
}
</style>

</head>

<body>
	<!-- ===========================
     SIDEBAR
=========================== -->

	<div class="sidebar" id="sidebar">

		<div class="sidebar-header">
			<i class="fa-solid fa-layer-group"></i> <span>ELAMS</span>
		</div>

		<ul>

			<!-- MAIN -->

			<li
				style="color: #9CA3AF; font-size: 12px; text-transform: uppercase; margin: 20px 15px 10px; letter-spacing: 1px;">
				Main</li>

			<li><a href="managerHome.jsp" target="contentFrame"
				class="active" onclick="loadPage(this)"> <i
					class="fa-solid fa-house"></i> <span>Dashboard</span>
			</a></li>

			<li><a href="ManagerViewEmployeesServlet" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-users"></i> <span>Employees</span>
			</a></li>

			<li><a href="attendanceReport" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-calendar-check"></i>
					<span>Attendance</span>
			</a></li>

			<!-- TASK MANAGEMENT -->

			<li
				style="color: #9CA3AF; font-size: 12px; text-transform: uppercase; margin: 28px 15px 10px; letter-spacing: 1px;">
				Task Management</li>

			<li><a href="CreateTaskPageServlet" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-circle-plus"></i>
					<span>Create Task</span>
			</a></li>

			<li><a href="ViewTasksServlet" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-list-check"></i>
					<span>View Tasks</span>
			</a></li>

			<li><a href="TaskReportServlet" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-chart-column"></i>
					<span>Task Reports</span>
			</a></li>


			<!-- ANALYTICS -->

			<li
				style="color: #9CA3AF; font-size: 12px; text-transform: uppercase; margin: 28px 15px 10px; letter-spacing: 1px;">
				Analytics</li>


			<li><a href="PerformanceServlet" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-chart-line"></i>
					<span>Performance</span>
			</a></li>


			<li><a href="reports.jsp" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-chart-pie"></i>
					<span>Reports</span>
			</a></li>


			<!-- SETTINGS -->

			<li
				style="color: #9CA3AF; font-size: 12px; text-transform: uppercase; margin: 28px 15px 10px; letter-spacing: 1px;">
				Account</li>

			<li><a href="profile.jsp" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-user-gear"></i>
					<span>Profile</span>
			</a></li>

			<li><a href="settings.jsp" target="contentFrame"
				onclick="loadPage(this)"> <i class="fa-solid fa-gear"></i> <span>Settings</span>
			</a></li>

			<li><a href="#" onclick="logoutConfirmation()"
				style="margin-top: 25px; background: #dc2626; color: white;"> <i
					class="fa-solid fa-right-from-bracket"></i> <span>Logout</span>

			</a></li>

		</ul>

	</div>


	<!-- Hidden Logout Form -->

	<form action="logout" method="post" id="logoutForm"
		style="display: none;"></form>
	<!-- ===================================================
                    HEADER
=================================================== -->

	<div class="header" id="header">

		<!-- Left Section -->

		<div style="display: flex; align-items: center; gap: 25px;">

			<!-- Mobile Menu -->

			<i class="fa-solid fa-bars" id="menuBtn"
				style="font-size: 24px; cursor: pointer;" onclick="toggleSidebar()">
			</i>

			<!-- Search -->

			<div class="search-box">

				<i class="fa-solid fa-magnifying-glass" style="color: #64748b;"></i>

				<input type="text" id="searchInput"
					placeholder="Search employees, tasks, reports..."
					oninput="filterSidebar(this.value)"
					onkeydown="handleSearchEnter(event)">

			</div>

		</div>



		<!-- Right Section -->

		<div class="header-right">

			<!-- Current Date -->

			<div style="text-align: right;">

				<h4 style="font-size: 14px; color: #111827;">
					<span id="todayDate"></span>
				</h4>

				<small style="color: gray;" id="currentTime"></small>

			</div>



			<!-- Notification -->

			<div class="notification" onclick="toggleNotification()">
				<i class="fa-regular fa-bell"></i> <span class="badge"> 3 </span>

			</div>



			<!-- Dark Mode -->

			<div id="themeToggle"
				style="width: 45px; height: 45px; background: #EEF2FF; border-radius: 50%; display: flex; justify-content: center; align-items: center; cursor: pointer; transition: .3s;">

				<i class="fa-solid fa-moon"></i>

			</div>



			<!-- Profile -->

			<div class="profile">

				<div class="avatar">

					<%=initials%>

				</div>

				<div class="profile-info">

					<h4>

						<%=managerName%>

					</h4>

					<p>Manager</p>

				</div>

				<i class="fa-solid fa-angle-down"></i>

			</div>

		</div>

	</div>



	<!-- ===================================================
             PAGE CONTENT
=================================================== -->

	<div class="main" id="main">

		<!-- Breadcrumb -->

		<div class="breadcrumb" id="breadcrumb">

			<i class="fa-solid fa-house"></i> Dashboard <i
				class="fa-solid fa-angle-right"></i> Manager Portal

		</div>



		<!-- Welcome Banner -->

		<div class="welcome" id="welcomeBanner">

			<div>

				<h2>

					Welcome Back,

					<%=managerName%>
					👋

				</h2>

				<p>Manage employees, attendance, leave requests and tasks from
					one place.</p>

			</div>



			<div class="quick-buttons">
				<button
					onclick="window.frames['contentFrame'].location='CreateTaskPageServlet'">
					<i class="fa-solid fa-circle-plus"></i> Create Task
				</button>


				<button style="background: #16a34a;"
					onclick="window.frames['contentFrame'].location='ManagerViewEmployeesServlet'">

					<i class="fa-solid fa-user-plus"></i> Add Employee

				</button>

			</div>

		</div>



		<!-- IFRAME PANEL (fills remaining space, no scrolling needed) -->
		<div class="content-panel">

			<iframe name="contentFrame" src="managerHome.jsp"> </iframe>

		</div>

	</div>
	<script>
		// ==============================
		// SIDEBAR
		// ==============================

		const sidebar = document.getElementById("sidebar");
		const header = document.getElementById("header");
		const main = document.getElementById("main");

		function toggleSidebar() {

			sidebar.classList.toggle("hide");
			header.classList.toggle("full");
			main.classList.toggle("full");

		}

		// ==============================
		// ACTIVE MENU
		// ==============================

		function loadPage(link) {

			document.querySelectorAll(".sidebar a").forEach(function(item) {

				item.classList.remove("active");

			});

			link.classList.add("active");

			// Show the welcome banner and breadcrumb only for the Dashboard link,
			// hide them for every other functionality so the iframe gets full space
			const welcomeBanner = document.getElementById("welcomeBanner");
			const breadcrumb = document.getElementById("breadcrumb");
			const isDashboard = link.getAttribute("href") === "managerHome.jsp";

			if (isDashboard) {
				welcomeBanner.classList.remove("hide");
				breadcrumb.classList.remove("hide");
			} else {
				welcomeBanner.classList.add("hide");
				breadcrumb.classList.add("hide");
			}

			if (window.innerWidth < 992) {

				sidebar.classList.add("hide");
				header.classList.add("full");
				main.classList.add("full");

			}

			return true;

		}

		// ==============================
		// DATE
		// ==============================

		function updateDate() {

			const today = new Date();

			const options = {

				weekday : 'long',

				year : 'numeric',

				month : 'long',

				day : 'numeric'

			};

			document.getElementById("todayDate").innerHTML = today
					.toLocaleDateString("en-US", options);

		}

		updateDate();

		// ==============================
		// CLOCK
		// ==============================

		function updateClock() {

			const now = new Date();

			document.getElementById("currentTime").innerHTML = now
					.toLocaleTimeString();

		}

		updateClock();

		setInterval(updateClock, 1000);

		// ==============================
		// DARK MODE
		// ==============================

		const themeButton = document.getElementById("themeToggle");

		themeButton.addEventListener("click", function() {

			document.body.classList.toggle("dark");

			if (document.body.classList.contains("dark")) {

				localStorage.setItem("theme", "dark");

				themeButton.innerHTML = '<i class="fa-solid fa-sun"></i>';

			}

			else {

				localStorage.setItem("theme", "light");

				themeButton.innerHTML = '<i class="fa-solid fa-moon"></i>';

			}

		});

		if (localStorage.getItem("theme") == "dark") {

			document.body.classList.add("dark");

			themeButton.innerHTML = '<i class="fa-solid fa-sun"></i>';

		}

		// ==============================
		// SEARCH
		// ==============================

		function filterSidebar(query) {

			const q = query.trim().toLowerCase();

			document.querySelectorAll(".sidebar ul li").forEach(function(li) {

				const link = li.querySelector("a");

				// Leave section headers (no <a>) and the logout item untouched
				if (!link) {
					return;
				}

				const label = link.innerText.trim().toLowerCase();

				li.style.display = (q === "" || label.includes(q)) ? "" : "none";

			});

		}

		function handleSearchEnter(e) {

			if (e.key !== "Enter") {
				return;
			}

			const q = e.target.value.trim().toLowerCase();

			if (q === "") {
				return;
			}

			const links = document.querySelectorAll(".sidebar ul li a");

			for (const link of links) {

				if (link.innerText.trim().toLowerCase().includes(q)) {
					link.click();
					break;
				}

			}

		}

		// ==============================
		// NOTIFICATION
		// ==============================

		function toggleNotification() {

			alert("Notifications feature coming soon.");

		}

		// ==============================
		// LOGOUT
		// ==============================

		function logoutConfirmation() {

			if (confirm("Logout from ELAMS?")) {

				document.getElementById("logoutForm").submit();

			}

		}

		// ==============================
		// IFRAME LOADER
		// ==============================

		const frame = document.querySelector("iframe");

		frame.onload = function() {

			console.log("Page Loaded");

		};

		// ==============================
		// ESC CLOSE SIDEBAR
		// ==============================

		document.addEventListener("keydown", function(e) {

			if (e.key === "Escape") {

				sidebar.classList.add("hide");

				header.classList.add("full");

				main.classList.add("full");

			}

		});

		// ==============================
		// WINDOW RESIZE
		// ==============================

		window.addEventListener("resize", function() {

			if (window.innerWidth > 992) {

				sidebar.classList.remove("hide");

				header.classList.remove("full");

				main.classList.remove("full");

			}

		});
	</script>
</body>
</html>