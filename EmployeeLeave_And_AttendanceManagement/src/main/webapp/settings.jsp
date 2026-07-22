<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equalsIgnoreCase("MANAGER")) {
response.sendRedirect("login.jsp");
return;
}

String managerName = (String) session.getAttribute("managerName");

if (managerName == null || managerName.trim().isEmpty()) {
managerName = "Manager";
}

String initials = "";

for (String part : managerName.trim().split("\s+")) {
if (!part.isEmpty()) {
initials += part.substring(0, 1).toUpperCase();
}
}

if (initials.length() > 2) {
initials = initials.substring(0, 2);
}
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
 content="width=device-width, initial-scale=1.0">

<title>Settings | ELAMS Manager Portal</title>

<link rel="preconnect"
	href="https://fonts.googleapis.com">

<link rel="preconnect"
	href="https://fonts.gstatic.com"
	crossorigin>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;500;600;600;700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>

/* =========================================================
   GLOBAL RESET
========================================================= */

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

:root {

	--primary: #2563eb;
	--primary-dark: #1d4ed8;
	--primary-light: #eff6ff;

	--success: #16a34a;
	--success-light: #dcfce7;

	--warning: #d97706;
	--warning-light: #fef3c7;

	--danger: #dc2626;
	--danger-light: #fee2e2;

	--text: #172033;
	--text-secondary: #64748b;
	--text-light: #94a3b8;

	--background: #f5f7fb;
	--card: #ffffff;
	--border: #e5e7eb;

	--shadow:
		0 10px 30px rgba(15, 23, 42, 0.06);

	--radius: 16px;
}


/* =========================================================
   BODY
========================================================= */

body {

	background: var(--background);

	color: var(--text);

	min-height: 100vh;

	padding: 28px;

	transition:
		background .3s ease,
		color .3s ease;

}


/* =========================================================
   PAGE CONTAINER
========================================================= */

.settings-container {

	max-width: 1200px;

	margin: 0 auto;

}


/* =========================================================
   PAGE HEADER
========================================================= */

.page-header {

	display: flex;

	align-items: center;

	justify-content: space-between;

	margin-bottom: 28px;

}


.header-left {

	display: flex;

	align-items: center;

	gap: 16px;

}


.header-icon {

	width: 54px;

	height: 54px;

	border-radius: 15px;

	background:
		linear-gradient(
			135deg,
			#2563eb,
			#3b82f6
		);

	color: white;

	display: flex;

	align-items: center;

	justify-content: center;

	font-size: 22px;

	box-shadow:
		0 8px 20px
		rgba(37, 99, 235, .25);

}


.header-text h1 {

	font-size: 25px;

	font-weight: 600;

	letter-spacing: -.4px;

}


.header-text p {

	margin-top: 4px;

	font-size: 13px;

	color: var(--text-secondary);

}


/* =========================================================
   PROFILE MINI CARD
========================================================= */

.profile-mini {

	display: flex;

	align-items: center;

	gap: 12px;

	background: white;

	border: 1px solid var(--border);

	padding: 8px 14px 8px 8px;

	border-radius: 14px;

	box-shadow: var(--shadow);

}


.profile-avatar {

	width: 40px;

	height: 40px;

	border-radius: 50%;

	background:
		linear-gradient(
			135deg,
			#2563eb,
			#0ea5e9
		);

	color: white;

	display: flex;

	align-items: center;

	justify-content: center;

	font-weight: 600;

	font-size: 14px;

}


.profile-info strong {

	display: block;

	font-size: 13px;

}


.profile-info span {

	font-size: 11px;

	color: var(--text-secondary);

}


/* =========================================================
   SETTINGS LAYOUT
========================================================= */

.settings-layout {

	display: grid;

	grid-template-columns:
		250px
		1fr;

	gap: 24px;

	align-items: start;

}


/* =========================================================
   SETTINGS SIDEBAR
========================================================= */

.settings-sidebar {

	background: white;

	border: 1px solid var(--border);

	border-radius: var(--radius);

	padding: 12px;

	box-shadow: var(--shadow);

}


.settings-sidebar-title {

	padding: 12px 14px;

	font-size: 11px;

	text-transform: uppercase;

	letter-spacing: 1px;

	font-weight: 600;

	color: var(--text-light);

}


.settings-tab {

	width: 100%;

	display: flex;

	align-items: center;

	gap: 13px;

	padding: 13px 14px;

	border: none;

	background: transparent;

	border-radius: 11px;

	cursor: pointer;

	color: var(--text-secondary);

	text-align: left;

	font-size: 13px;

	font-weight: 500;

	transition: all .2s ease;

	margin-bottom: 4px;

}


.settings-tab i {

	width: 20px;

	text-align: center;

	font-size: 15px;

}


.settings-tab:hover {

	background: #f8fafc;

	color: var(--primary);

}


.settings-tab.active {

	background: var(--primary-light);

	color: var(--primary);

	font-weight: 600;

}


.sidebar-divider {

	height: 1px;

	background: var(--border);

	margin: 12px 5px;

}


/* =========================================================
   MAIN SETTINGS CARD
========================================================= */

.settings-content {

	background: white;

	border: 1px solid var(--border);

	border-radius: var(--radius);

	box-shadow: var(--shadow);

	overflow: hidden;

}


/* =========================================================
   SECTION
========================================================= */

.settings-section {

	display: none;

}


.settings-section.active {

	display: block;

}


/* =========================================================
   SECTION HEADER
========================================================= */

.section-header {

	padding: 25px 28px;

	border-bottom: 1px solid var(--border);

}


.section-header h2 {

	font-size: 18px;

	font-weight: 600;

}


.section-header p {

	margin-top: 5px;

	font-size: 12px;

	color: var(--text-secondary);

}


/* =========================================================
   SETTINGS BODY
========================================================= */

.settings-body {

	padding: 5px 28px 28px;

}


/* =========================================================
   SETTING ITEM
========================================================= */

.setting-item {

	display: flex;

	align-items: center;

	justify-content: space-between;

	gap: 30px;

	padding: 22px 0;

	border-bottom: 1px solid #f1f5f9;

}


.setting-item:last-child {

	border-bottom: none;

}


.setting-content {

	display: flex;

	align-items: flex-start;

	gap: 15px;

}


.setting-icon {

	width: 40px;

	height: 40px;

	border-radius: 11px;

	background: #f8fafc;

	color: var(--primary);

	display: flex;

	align-items: center;

	justify-content: center;

	flex-shrink: 0;

}


.setting-info h3 {

	font-size: 14px;

	font-weight: 600;

	margin-bottom: 4px;

}


.setting-info p {

	font-size: 12px;

	color: var(--text-secondary);

	line-height: 1.6;

}


/* =========================================================
   TOGGLE SWITCH
========================================================= */

.switch {

	position: relative;

	width: 48px;

	height: 26px;

	flex-shrink: 0;

}


.switch input {

	opacity: 0;

	width: 0;

	height: 0;

}


.slider {

	position: absolute;

	inset: 0;

	background: #cbd5e1;

	border-radius: 30px;

	cursor: pointer;

	transition: .25s;

}


.slider:before {

	content: "";

	position: absolute;

	width: 20px;

	height: 20px;

	left: 3px;

	top: 3px;

	background: white;

	border-radius: 50%;

	box-shadow:
		0 2px 5px rgba(0,0,0,.15);

	transition: .25s;

}


.switch input:checked + .slider {

	background: var(--primary);

}


.switch input:checked + .slider:before {

	transform:
		translateX(22px);

}


/* =========================================================
   SELECT
========================================================= */

.select-control {

	min-width: 180px;

	padding: 10px 13px;

	border: 1px solid #dbe2ea;

	border-radius: 9px;

	background: white;

	color: var(--text);

	outline: none;

	font-size: 12px;

	cursor: pointer;

}


.select-control:focus {

	border-color: var(--primary);

	box-shadow:
		0 0 0 3px
		rgba(37,99,235,.1);

}


/* =========================================================
   SAVE BAR
========================================================= */

.save-bar {

	display: flex;

	align-items: center;

	justify-content: space-between;

	background: #f8fafc;

	border-top: 1px solid var(--border);

	padding: 18px 28px;

}


.save-status {

	display: flex;

	align-items: center;

	gap: 8px;

	font-size: 12px;

	color: var(--text-secondary);

}


.status-dot {

	width: 8px;

	height: 8px;

	border-radius: 50%;

	background: var(--success);

}


.save-button {

	border: none;

	background: var(--primary);

	color: white;

	padding: 11px 20px;

	border-radius: 9px;

	font-size: 12px;

	font-weight: 600;

	cursor: pointer;

	display: flex;

	align-items: center;

	gap: 8px;

	transition: .2s;

}


.save-button:hover {

	background: var(--primary-dark);

	transform:
		translateY(-1px);

}


.save-button:disabled {

	opacity: .7;

	cursor: not-allowed;

	transform: none;

}


/* =========================================================
   SECURITY CARD
========================================================= */

.security-card {

	margin-top: 20px;

	background: #f8fafc;

	border: 1px solid var(--border);

	border-radius: 12px;

	padding: 18px;

}


.security-row {

	display: flex;

	align-items: center;

	justify-content: space-between;

	padding: 10px 0;

}


.security-row:not(:last-child) {

	border-bottom: 1px solid #e2e8f0;

}


.security-row span {

	font-size: 12px;

	color: var(--text-secondary);

}


.security-row strong {

	font-size: 12px;

}


.active-status {

	color: var(--success);

}


/* =========================================================
   DANGER ZONE
========================================================= */

.danger-zone {

	margin-top: 25px;

	border: 1px solid #fecaca;

	background: #fffafa;

	border-radius: 12px;

	padding: 20px;

}


.danger-zone h3 {

	font-size: 14px;

	color: var(--danger);

	margin-bottom: 5px;

}


.danger-zone p {

	font-size: 12px;

	color: var(--text-secondary);

	margin-bottom: 15px;

}


.logout-btn {

	border: 1px solid #fecaca;

	background: white;

	color: var(--danger);

	padding: 9px 15px;

	border-radius: 8px;

	font-size: 12px;

	cursor: pointer;

	font-weight: 600;

}


/* =========================================================
   TOAST
========================================================= */

.toast {

	position: fixed;

	right: 25px;

	bottom: 25px;

	background: #172033;

	color: white;

	padding: 14px 18px;

	border-radius: 10px;

	display: flex;

	align-items: center;

	gap: 10px;

	font-size: 12px;

	box-shadow:
		0 10px 30px
		rgba(0,0,0,.2);

	transform:
		translateY(100px);

	opacity: 0;

	transition: .3s;

	z-index: 9999;

}


.toast.show {

	transform:
		translateY(0);

	opacity: 1;

}


.toast i {

	color: #4ade80;

}


/* =========================================================
   DARK MODE
========================================================= */

body.dark {

	--background: #0f172a;

	--card: #1e293b;

	--text: #f8fafc;

	--text-secondary: #94a3b8;

	--text-light: #64748b;

	--border: #334155;

	background: #0f172a;

	color: #f8fafc;

}


body.dark .settings-sidebar,

body.dark .settings-content,

body.dark .profile-mini {

	background: #1e293b;

	border-color: #334155;

}


body.dark .settings-tab:hover {

	background: #334155;

}


body.dark .settings-tab.active {

	background: rgba(37,99,235,.2);

}


body.dark .setting-icon {

	background: #334155;

}


body.dark .save-bar {

	background: #172033;

	border-color: #334155;

}


body.dark .select-control {

	background: #1e293b;

	color: white;

	border-color: #475569;

}


body.dark .security-card {

	background: #172033;

	border-color: #334155;

}


body.dark .danger-zone {

	background: #2a1717;

	border-color: #7f1d1d;

}


body.dark .logout-btn {

	background: #1e293b;

	border-color: #7f1d1d;

}


body.dark .profile-info span {

	color: #94a3b8;

}


/* =========================================================
   RESPONSIVE
========================================================= */

@media(max-width: 850px) {

	body {

		padding: 18px;

	}


	.page-header {

		align-items: flex-start;

		gap: 15px;

	}


	.profile-mini {

		display: none;

	}


	.settings-layout {

		grid-template-columns: 1fr;

	}


	.settings-sidebar {

		display: flex;

		overflow-x: auto;

		padding: 8px;

	}


	.settings-sidebar-title,

	.sidebar-divider {

		display: none;

	}


	.settings-tab {

		min-width: 140px;

		justify-content: center;

		margin: 0;

	}


}


@media(max-width: 600px) {

	body {

		padding: 12px;

	}


	.header-text h1 {

		font-size: 21px;

	}


	.header-icon {

		width: 46px;

		height: 46px;

	}


	.settings-body {

		padding:
			5px 18px 20px;

	}


	.section-header {

		padding:
			20px 18px;

	}


	.setting-item {

		align-items: flex-start;

	}


	.setting-content {

		gap: 10px;

	}


	.setting-info p {

		max-width: 220px;

	}


	.save-bar {

		padding:
			15px 18px;

	}


	.save-status {

		display: none;

	}


	.select-control {

		min-width: 140px;

	}

}

</style>

</head>

<body>

<div class="settings-container">

<!-- =====================================================
     HEADER
===================================================== -->

<div class="page-header">

```
<div class="header-left">

	<div class="header-icon">

		<i class="fa-solid fa-sliders"></i>

	</div>

	<div class="header-text">

		<h1>Settings</h1>

		<p>
			Manage your ELAMS manager preferences and account settings.
		</p>

	</div>

</div>


<div class="profile-mini">

	<div class="profile-avatar">

		<%= initials %>

	</div>

	<div class="profile-info">

		<strong>
			<%= managerName %>
		</strong>

		<span>
			Manager Account
		</span>

	</div>

</div>
```

</div>

<!-- =====================================================
     SETTINGS LAYOUT
===================================================== -->

<div class="settings-layout">

<!-- =====================================================
     SIDEBAR
===================================================== -->

<div class="settings-sidebar">

```
<div class="settings-sidebar-title">

	Account Settings

</div>


<button
	class="settings-tab active"
	data-section="general">

	<i class="fa-solid fa-sliders"></i>

	General

</button>


<button
	class="settings-tab"
	data-section="notifications">

	<i class="fa-regular fa-bell"></i>

	Notifications

</button>


<button
	class="settings-tab"
	data-section="security">

	<i class="fa-solid fa-shield-halved"></i>

	Security

</button>


<div class="sidebar-divider"></div>


<button
	class="settings-tab"
	data-section="appearance">

	<i class="fa-solid fa-palette"></i>

	Appearance

</button>
```

</div>

<!-- =====================================================
     CONTENT
===================================================== -->

<div class="settings-content">

<!-- =====================================================
     GENERAL
===================================================== -->

<div
	class="settings-section active"
	id="general">

```
<div class="section-header">

	<h2>General Preferences</h2>

	<p>
		Configure your manager dashboard experience.
	</p>

</div>


<div class="settings-body">


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-gauge-high"></i>

			</div>


			<div class="setting-info">

				<h3>Dashboard Refresh</h3>

				<p>
					Choose how frequently dashboard information
					should be refreshed.
				</p>

			</div>


		</div>


		<select
			class="select-control"
			id="refreshRate">

			<option value="5">
				Every 5 minutes
			</option>

			<option value="10">
				Every 10 minutes
			</option>

			<option value="30">
				Every 30 minutes
			</option>

			<option value="manual">
				Manual
			</option>

		</select>


	</div>


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-language"></i>

			</div>


			<div class="setting-info">

				<h3>Language</h3>

				<p>
					Select the language used throughout your dashboard.
				</p>

			</div>


		</div>


		<select class="select-control">

			<option>English</option>

		</select>


	</div>


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-calendar-days"></i>

			</div>


			<div class="setting-info">

				<h3>Date Format</h3>

				<p>
					Choose how dates are displayed in your dashboard.
				</p>

			</div>


		</div>


		<select class="select-control">

			<option>DD/MM/YYYY</option>

			<option>MM/DD/YYYY</option>

			<option>YYYY-MM-DD</option>

		</select>


	</div>


</div>


<div class="save-bar">


	<div class="save-status">

		<span class="status-dot"></span>

		Your preferences are stored locally.

	</div>


	<button
		class="save-button"
		onclick="saveSettings()">

		<i class="fa-solid fa-check"></i>

		Save Changes

	</button>


</div>
```

</div>

<!-- =====================================================
     NOTIFICATIONS
===================================================== -->

<div
	class="settings-section"
	id="notifications">

```
<div class="section-header">

	<h2>Notification Preferences</h2>

	<p>
		Control which notifications you receive as a manager.
	</p>

</div>


<div class="settings-body">


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-envelope"></i>

			</div>


			<div class="setting-info">

				<h3>Email Notifications</h3>

				<p>
					Receive important ELAMS updates through email.
				</p>

			</div>


		</div>


		<label class="switch">

			<input
				type="checkbox"
				id="emailNotifications"
				checked>

			<span class="slider"></span>

		</label>


	</div>


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-file-circle-plus"></i>

			</div>


			<div class="setting-info">

				<h3>Leave Request Alerts</h3>

				<p>
					Get notified when employees submit new leave requests.
				</p>

			</div>


		</div>


		<label class="switch">

			<input
				type="checkbox"
				id="leaveAlerts"
				checked>

			<span class="slider"></span>

		</label>


	</div>


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-list-check"></i>

			</div>


			<div class="setting-info">

				<h3>Task Updates</h3>

				<p>
					Receive updates when employees complete assigned tasks.
				</p>

			</div>


		</div>


		<label class="switch">

			<input
				type="checkbox"
				id="taskAlerts"
				checked>

			<span class="slider"></span>

		</label>


	</div>


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-calendar-check"></i>

			</div>


			<div class="setting-info">

				<h3>Attendance Alerts</h3>

				<p>
					Get notified about important attendance events.
				</p>

			</div>


		</div>


		<label class="switch">

			<input
				type="checkbox"
				id="attendanceAlerts"
				checked>

			<span class="slider"></span>

		</label>


	</div>


</div>


<div class="save-bar">


	<div class="save-status">

		<span class="status-dot"></span>

		Notification preferences

	</div>


	<button
		class="save-button"
		onclick="saveSettings()">

		<i class="fa-solid fa-check"></i>

		Save Changes

	</button>


</div>
```

</div>

<!-- =====================================================
     SECURITY
===================================================== -->

<div
	class="settings-section"
	id="security">

```
<div class="section-header">

	<h2>Security</h2>

	<p>
		Review your account security and active session information.
	</p>

</div>


<div class="settings-body">


	<div class="security-card">


		<div class="security-row">

			<span>
				Account Role
			</span>

			<strong>
				Manager
			</strong>

		</div>


		<div class="security-row">

			<span>
				Session Status
			</span>

			<strong class="active-status">

				<i class="fa-solid fa-circle"
				   style="font-size:7px;"></i>

				Active

			</strong>

		</div>


		<div class="security-row">

			<span>
				Authentication
			</span>

			<strong>
				Password Protected
			</strong>

		</div>


	</div>


	<div class="danger-zone">


		<h3>

			<i class="fa-solid fa-triangle-exclamation"></i>

			Session Management

		</h3>


		<p>
			If you suspect unauthorized access, you should log out
			of your current session immediately.
		</p>


		<button
			class="logout-btn"
			onclick="logoutManager()">

			<i class="fa-solid fa-right-from-bracket"></i>

			Log Out

		</button>


	</div>


</div>
```

</div>

<!-- =====================================================
     APPEARANCE
===================================================== -->

<div
	class="settings-section"
	id="appearance">

```
<div class="section-header">

	<h2>Appearance</h2>

	<p>
		Customize how the ELAMS manager portal looks.
	</p>

</div>


<div class="settings-body">


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-moon"></i>

			</div>


			<div class="setting-info">

				<h3>Dark Mode</h3>

				<p>
					Use the dark theme across the manager dashboard.
				</p>

			</div>


		</div>


		<label class="switch">

			<input
				type="checkbox"
				id="darkMode">

			<span class="slider"></span>

		</label>


	</div>


	<div class="setting-item">


		<div class="setting-content">


			<div class="setting-icon">

				<i class="fa-solid fa-eye"></i>

			</div>


			<div class="setting-info">

				<h3>Compact Layout</h3>

				<p>
					Use a more compact layout to display additional information.
				</p>

			</div>


		</div>


		<label class="switch">

			<input
				type="checkbox"
				id="compactMode">

			<span class="slider"></span>

		</label>


	</div>


</div>


<div class="save-bar">


	<div class="save-status">

		<span class="status-dot"></span>

		Appearance preferences

	</div>


	<button
		class="save-button"
		onclick="saveSettings()">

		<i class="fa-solid fa-check"></i>

		Save Changes

	</button>


</div>
```

</div>

</div>

</div>

</div>

<!-- =====================================================
     TOAST
===================================================== -->

<div
	class="toast"
	id="toast">

```
<i class="fa-solid fa-circle-check"></i>

<span id="toastMessage">
	Settings saved successfully.
</span>
```

</div>

<script>

/* =========================================================
   SETTINGS TABS
========================================================= */

const tabs =
	document.querySelectorAll(".settings-tab");

const sections =
	document.querySelectorAll(".settings-section");


tabs.forEach(function(tab) {

	tab.addEventListener("click", function() {


		const sectionId =
			this.getAttribute("data-section");


		tabs.forEach(function(item) {

			item.classList.remove("active");

		});


		sections.forEach(function(section) {

			section.classList.remove("active");

		});


		this.classList.add("active");


		document
			.getElementById(sectionId)
			.classList.add("active");


	});

});


/* =========================================================
   DARK MODE
   Synchronizes with manager dashboard localStorage
========================================================= */

const darkMode =
	document.getElementById("darkMode");


function applyDarkMode() {


	if (localStorage.getItem("theme") === "dark") {

		document.body.classList.add("dark");

		if (darkMode) {

			darkMode.checked = true;

		}

	} else {

		document.body.classList.remove("dark");

		if (darkMode) {

			darkMode.checked = false;

		}

	}

}


applyDarkMode();


if (darkMode) {


	darkMode.addEventListener("change", function() {


		if (this.checked) {

			localStorage.setItem(
				"theme",
				"dark"
			);

		} else {

			localStorage.setItem(
				"theme",
				"light"
			);

		}


		applyDarkMode();


		showToast(
			"Appearance updated successfully."
		);


	});

}


/* =========================================================
   LOAD SAVED SETTINGS
========================================================= */

function loadSettings() {


	const refreshRate =
		localStorage.getItem(
			"refreshRate"
		);


	if (refreshRate) {

		document.getElementById(
			"refreshRate"
		).value = refreshRate;

	}


	const emailNotifications =
		localStorage.getItem(
			"emailNotifications"
		);


	if (emailNotifications !== null) {

		document.getElementById(
			"emailNotifications"
		).checked =
			emailNotifications === "true";

	}


	const leaveAlerts =
		localStorage.getItem(
			"leaveAlerts"
		);


	if (leaveAlerts !== null) {

		document.getElementById(
			"leaveAlerts"
		).checked =
			leaveAlerts === "true";

	}


	const taskAlerts =
		localStorage.getItem(
			"taskAlerts"
		);


	if (taskAlerts !== null) {

		document.getElementById(
			"taskAlerts"
		).checked =
			taskAlerts === "true";

	}


	const attendanceAlerts =
		localStorage.getItem(
			"attendanceAlerts"
		);


	if (attendanceAlerts !== null) {

		document.getElementById(
			"attendanceAlerts"
		).checked =
			attendanceAlerts === "true";

	}

}


loadSettings();


/* =========================================================
   SAVE SETTINGS
========================================================= */

function saveSettings() {


	const saveButtons =
		document.querySelectorAll(
			".save-button"
		);


	saveButtons.forEach(function(button) {

		button.disabled = true;

		button.innerHTML =
			'<i class="fa-solid fa-spinner fa-spin"></i> Saving...';

	});


	setTimeout(function() {


		localStorage.setItem(

			"refreshRate",

			document.getElementById(
				"refreshRate"
			).value

		);


		localStorage.setItem(

			"emailNotifications",

			document.getElementById(
				"emailNotifications"
			).checked

		);


		localStorage.setItem(

			"leaveAlerts",

			document.getElementById(
				"leaveAlerts"
			).checked

		);


		localStorage.setItem(

			"taskAlerts",

			document.getElementById(
				"taskAlerts"
			).checked

		);


		localStorage.setItem(

			"attendanceAlerts",

			document.getElementById(
				"attendanceAlerts"
			).checked

		);


		saveButtons.forEach(function(button) {

			button.disabled = false;

			button.innerHTML =
				'<i class="fa-solid fa-check"></i> Save Changes';

		});


		showToast(
			"Settings saved successfully."
		);


	}, 700);

}


/* =========================================================
   TOAST MESSAGE
========================================================= */

function showToast(message) {


	const toast =
		document.getElementById(
			"toast"
		);


	const toastMessage =
		document.getElementById(
			"toastMessage"
		);


	toastMessage.innerText =
		message;


	toast.classList.add("show");


	setTimeout(function() {

		toast.classList.remove("show");

	}, 3000);

}


/* =========================================================
   LOGOUT
========================================================= */

function logoutManager() {


	if (confirm(
		"Are you sure you want to log out?"
	)) {


		window.parent.location.href =
			"logout";


	}

}


/* =========================================================
   SYNC THEME WITH PARENT DASHBOARD
========================================================= */

window.addEventListener(
	"storage",
	function(event) {


		if (event.key === "theme") {

			applyDarkMode();

		}

	}
);

</script>

</body>

</html>
