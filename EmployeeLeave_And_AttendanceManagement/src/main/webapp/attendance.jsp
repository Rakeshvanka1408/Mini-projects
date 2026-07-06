<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mark Attendance - ELAMS</title>

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
	max-width: 700px;
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

/* ===== FORM STYLING ===== */

/* Form Container */
.form-container {
	background-color: white;
	border: 2px solid #bdc3c7;
	border-radius: 8px;
	padding: 30px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* Form Row - For two columns on desktop */
.form-row {
	display: flex;
	gap: 20px;
	margin-bottom: 0;
}

/* Form Group - Each field wrapper */
.form-group {
	margin-bottom: 20px;
	flex: 1;
}

.form-row .form-group {
	margin-bottom: 0;
}

/* Label Styling */
.form-group label {
	display: block;
	font-weight: bold;
	color: #2c3e50;
	margin-bottom: 8px;
	font-size: 14px;
}

/* Required field indicator */
.form-group label .required {
	color: #e74c3c;
}

/* Input Fields Styling */
.form-group input[type="text"], .form-group input[type="number"],
	.form-group input[type="date"], .form-group input[type="time"],
	.form-group select {
	width: 100%;
	padding: 10px 12px;
	border: 1px solid #bdc3c7;
	border-radius: 4px;
	font-size: 14px;
	font-family: Arial, sans-serif;
	transition: all 0.3s;
}

/* Input Focus Effect */
.form-group input[type="text"]:focus, .form-group input[type="number"]:focus,
	.form-group input[type="date"]:focus, .form-group input[type="time"]:focus,
	.form-group select:focus {
	outline: none;
	border-color: #3498db;
	box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
	background-color: #f9f9f9;
}

/* Input Placeholder */
.form-group input::placeholder {
	color: #95a5a6;
}

/* Help Text */
.form-group .help-text {
	font-size: 12px;
	color: #95a5a6;
	margin-top: 5px;
}

/* Buttons Container */
.button-group {
	display: flex;
	gap: 10px;
	justify-content: center;
	margin-top: 30px;
}

/* Submit Button */
.btn-submit {
	background-color: #3498db;
	color: white;
	padding: 12px 30px;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: all 0.3s;
	flex: 1;
	max-width: 150px;
}

/* Submit Button Hover Effect */
.btn-submit:hover {
	background-color: #2980b9;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

/* Submit Button Active Effect */
.btn-submit:active {
	transform: translateY(0);
}

/* Reset Button */
.btn-reset {
	background-color: #95a5a6;
	color: white;
	padding: 12px 30px;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: all 0.3s;
	flex: 1;
	max-width: 150px;
}

/* Reset Button Hover Effect */
.btn-reset:hover {
	background-color: #7f8c8d;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

/* Back Link */
.back-link {
	display: inline-block;
	margin-top: 20px;
	color: #3498db;
	text-decoration: none;
	font-size: 14px;
	transition: color 0.3s;
}

.back-link:hover {
	color: #2980b9;
	text-decoration: underline;
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
	line-height: 1.6;
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

.alert-error {
	background-color: #f8d7da;
	border-left-color: #e74c3c;
	color: #721c24;
}

/* ===== STATUS BADGE ===== */
.status-badge {
	display: inline-block;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 11px;
	font-weight: bold;
	text-transform: uppercase;
}

.status-present {
	background-color: #d4edda;
	color: #155724;
}

.status-absent {
	background-color: #f8d7da;
	color: #721c24;
}

.status-half-day {
	background-color: #fff3cd;
	color: #856404;
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
	.form-container {
		padding: 20px;
	}

	/* Stack form row fields vertically */
	.form-row {
		flex-direction: column;
		gap: 0;
	}
	.button-group {
		flex-direction: column;
	}
	.btn-submit, .btn-reset {
		max-width: 100%;
		width: 100%;
	}
}
</style>

</head>

<body>

	<!-- ===== HEADER/NAVIGATION ===== -->
	<div class="navbar">
		<h1>ELAMS - Mark Attendance</h1>
	</div>

	<!-- ===== MAIN CONTENT AREA ===== -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Mark Your Attendance</h2>

		<!-- Page Subtitle -->
		<p class="page-subtitle">Record your daily attendance with
			check-in and check-out times</p>

		<!-- Info Box -->
		<div class="info-box">
			<strong>ℹ️ Note:</strong>
			<ul style="margin-left: 20px; margin-top: 10px;">
				<li>All fields marked with <span style="color: #e74c3c;">*</span>
					are required
				</li>
				<li>Check-out time must be after check-in time</li>
				<li>Select appropriate status for the day</li>
			</ul>
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

		<!-- Display Error Message if any -->
		<%
		String errorMessage = (String) request.getAttribute("errorMessage");
		if (errorMessage != null && !errorMessage.isEmpty()) {
		%>
		<div class="alert alert-error">
			✕
			<%=errorMessage%>
		</div>
		<%
		}
		%>

		<!-- ===== MARK ATTENDANCE FORM ===== -->
		<div class="form-container">
			<form action="markAttendance" method="post"
				onsubmit="return validateForm()">

				<!-- Row 1: Employee ID and Date -->
				<div class="form-row">


					<!-- Date Field -->
					<div class="form-group">
						<label for="attendanceDate"> Date <span class="required">*</span>
						</label> <input type="date" id="attendanceDate" name="attendanceDate"
							required readonly title="Please select attendance date">
						<div class="help-text">Select the date for attendance</div>
					</div>

				</div>

				<!-- Row 2: Check In and Check Out -->
				<div class="form-row">

					<!-- Check In Time -->
					<div class="form-group">
						<label for="checkIn"> Check In Time <span class="required">*</span>
						</label> <input type="time" id="checkIn" name="checkIn" min="10:00"
							max="11:00" required>
						<div class="help-text">Time you arrived at work</div>
					</div>

					<!-- Check Out Time -->
					<div class="form-group">
						<label for="checkOut"> Check Out Time <span
							class="required">*</span>
						</label> <input type="time" id="checkOut" name="checkOut" min="18:00"
							max="19:00" required>
						<div class="help-text">Time you left from work</div>
					</div>

				</div>

				<!-- Status Field -->
				<div class="form-group">
					<label for="status"> Attendance Status <span
						class="required">*</span>
					</label> <select id="status" name="status" required
						title="Please select attendance status">
						<option value="">-- Select Status --</option>
						<option value="Present">Present</option>
						<option value="Absent">Absent</option>
						<option value="Half Day">Half Day</option>
					</select>
					<div class="help-text">
						<span class="status-badge status-present">Present</span> - Full
						day attendance &nbsp; <span class="status-badge status-absent">Absent</span>
						- Not present &nbsp; <span class="status-badge status-half-day">Half
							Day</span> - Partial attendance
					</div>
				</div>

				<!-- Buttons -->
				<div class="button-group">
					<button type="submit" class="btn-submit">Mark Attendance</button>
					<button type="reset" class="btn-reset">Clear Form</button>
				</div>

			</form>
		</div>

		<!-- Back Link -->
		<%
		String role = (String) session.getAttribute("role");
		%>

		<a
			href="<%="admin".equalsIgnoreCase(role) ? "adminDashboardServlet" : "employeeDashboardServlet"%>"
			class="back-link"> ← Back to Dashboard </a>
	</div>

	<!-- ===== FOOTER ===== -->
	<footer>
		<p>&copy; 2024 ELAMS - Employee Leave & Attendance Management
			System. All rights reserved.</p>
	</footer>

	<!-- ===== JAVASCRIPT VALIDATION ===== -->
	<script>
		// Validate form before submission
		function validateForm() {
			var employeeId = document.getElementById("employeeId").value.trim();
			var attendanceDate = document.getElementById("attendanceDate").value;
			var checkIn = document.getElementById("checkIn").value;
			var checkOut = document.getElementById("checkOut").value;
			var status = document.getElementById("status").value;

			// Validate Employee ID
			if (employeeId === "" || employeeId <= 0) {
				alert("Please enter a valid Employee ID");
				document.getElementById("employeeId").focus();
				return false;
			}

			// Validate Date
			if (attendanceDate === "") {
				alert("Please select a date");
				document.getElementById("attendanceDate").focus();
				return false;
			}

			// Validate Check In Time
			if (checkIn === "") {
				alert("Please enter check-in time");
				document.getElementById("checkIn").focus();
				return false;
			}

			// Validate Check Out Time
			if (checkOut === "") {
				alert("Please enter check-out time");
				document.getElementById("checkOut").focus();
				return false;
			}

			// Compare check-in and check-out time
			if (checkIn >= checkOut) {
				alert("Check-out time must be after check-in time");
				document.getElementById("checkOut").focus();
				return false;
			}

			// Validate Status
			if (status === "" || status === null) {
				alert("Please select attendance status");
				document.getElementById("status").focus();
				return false;
			}

			// All validations passed
			return true;
		}

		// Set today's date as default
		window.addEventListener('load', function() {
			var today = new Date();
			var dateString = today.getFullYear() + '-'
					+ String(today.getMonth() + 1).padStart(2, '0') + '-'
					+ String(today.getDate()).padStart(2, '0');
			document.getElementById("attendanceDate").value = dateString;
		});

		// Show visual feedback on input focus
		var inputElements = document.querySelectorAll("input, select");
		inputElements.forEach(function(element) {
			element.addEventListener("focus", function() {
				this.style.borderColor = "#3498db";
			});

			element.addEventListener("blur", function() {
				this.style.borderColor = "#bdc3c7";
			});
		});
	</script>

</body>

</html>