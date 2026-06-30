<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Apply Leave - ELAMS</title>

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

/* Form Group - Each field wrapper */
.form-group {
	margin-bottom: 20px;
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
	.form-group input[type="date"], .form-group select, .form-group textarea
	{
	width: 100%;
	padding: 10px 12px;
	border: 1px solid #bdc3c7;
	border-radius: 4px;
	font-size: 14px;
	font-family: Arial, sans-serif;
	transition: all 0.3s;
	resize: vertical;
}

/* Input Focus Effect */
.form-group input[type="text"]:focus, .form-group input[type="number"]:focus,
	.form-group input[type="date"]:focus, .form-group select:focus,
	.form-group textarea:focus {
	outline: none;
	border-color: #3498db;
	box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
	background-color: #f9f9f9;
}

/* Input Placeholder */
.form-group input::placeholder, .form-group textarea::placeholder {
	color: #95a5a6;
}

/* Textarea Styling */
.form-group textarea {
	min-height: 100px;
	line-height: 1.5;
}

/* Help Text */
.form-group .help-text {
	font-size: 12px;
	color: #95a5a6;
	margin-top: 5px;
}

/* Leave Type Info Box */
.leave-types-info {
	background-color: #ecf0f1;
	border-left: 4px solid #3498db;
	padding: 12px;
	border-radius: 4px;
	font-size: 12px;
	color: #2c3e50;
	margin-top: 5px;
	line-height: 1.6;
}

.leave-types-info ul {
	margin-left: 20px;
	margin-top: 8px;
}

.leave-types-info li {
	margin-bottom: 5px;
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
	background-color: #27ae60;
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
	background-color: #229954;
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

.alert-warning {
	background-color: #fff3cd;
	border-left-color: #f39c12;
	color: #856404;
}

/* ===== LEAVE BALANCE SECTION ===== */
.leave-balance {
	background-color: white;
	border: 2px solid #bdc3c7;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 30px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.leave-balance h3 {
	font-size: 16px;
	color: #2c3e50;
	margin-bottom: 15px;
	border-bottom: 2px solid #3498db;
	padding-bottom: 10px;
}

.balance-item {
	display: flex;
	justify-content: space-between;
	padding: 8px 0;
	border-bottom: 1px solid #ecf0f1;
	font-size: 13px;
}

.balance-item:last-child {
	border-bottom: none;
}

.balance-item .label {
	font-weight: bold;
	color: #2c3e50;
}

.balance-item .value {
	color: #3498db;
	font-weight: bold;
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
	.button-group {
		flex-direction: column;
	}
	.btn-submit, .btn-reset {
		max-width: 100%;
		width: 100%;
	}
	.leave-balance {
		padding: 15px;
	}
	.info-box {
		font-size: 12px;
	}
}
</style>

</head>

<body>

	<!-- ===== HEADER/NAVIGATION ===== -->
	<div class="navbar">
		<h1>ELAMS - Apply Leave</h1>
	</div>

	<!-- ===== MAIN CONTENT AREA ===== -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Apply for Leave</h2>

		<!-- Page Subtitle -->
		<p class="page-subtitle">Submit a new leave request</p>

		<!-- Info Box -->
		<div class="info-box">
			<strong>ℹ️ Instructions:</strong>
			<ul style="margin-left: 20px; margin-top: 10px;">
				<li>All fields marked with <span style="color: #e74c3c;">*</span>
					are required
				</li>
				<li>End date must be the same or after the start date</li>
				<li>Provide a clear reason for your leave request</li>
				<li>Your request will be reviewed by the admin and you'll be
					notified via email</li>
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

		<!-- Display Warning Message if any -->
		<%
		String warningMessage = (String) request.getAttribute("warningMessage");
		if (warningMessage != null && !warningMessage.isEmpty()) {
		%>
		<div class="alert alert-warning">
			⚠️
			<%=warningMessage%>
		</div>
		<%
		}
		%>

		<!-- ===== LEAVE BALANCE SECTION ===== -->
		<div class="leave-balance">
			<h3>📊 Your Leave Balance</h3>
			<div class="balance-item">
				<span class="label">Sick Leave Balance:</span> <span class="value">
					<%
					Object sickLeave = request.getAttribute("sickLeaveBalance");
					out.print(sickLeave != null ? sickLeave : "0 days");
					%>
				</span>
			</div>
			<div class="balance-item">
				<span class="label">Casual Leave Balance:</span> <span class="value">
					<%
					Object casualLeave = request.getAttribute("casualLeaveBalance");
					out.print(casualLeave != null ? casualLeave : "0 days");
					%>
				</span>
			</div>
			<div class="balance-item">
				<span class="label">Earned Leave Balance:</span> <span class="value">
					<%
					Object earnedLeave = request.getAttribute("earnedLeaveBalance");
					out.print(earnedLeave != null ? earnedLeave : "0 days");
					%>
				</span>
			</div>
		</div>

		<!-- ===== APPLY LEAVE FORM ===== -->
		<div class="form-container">
			<form action="applyLeave" method="post"
				onsubmit="return validateForm()">

				<!-- Employee ID Field -->
				<div class="form-group">
					<label for="employeeId"> Employee ID <span class="required">*</span>
					</label> <input type="number" id="employeeId" name="employeeId"
						placeholder="Enter your employee ID" required min="1"
						title="Please enter a valid employee ID">
					<div class="help-text">Your unique employee identification
						number</div>
				</div>

				<!-- Leave Type Field -->
				<div class="form-group">
					<label for="leaveType"> Leave Type <span class="required">*</span>
					</label> <select id="leaveType" name="leaveType" required
						title="Please select leave type">
						<option value="">-- Select Leave Type --</option>
						<option value="Sick">Sick Leave</option>
						<option value="Casual">Casual Leave</option>
						<option value="Earned">Earned Leave</option>
						<option value="Emergency">Emergency Leave</option>
					</select>
					<div class="leave-types-info">
						<strong>Leave Types:</strong>
						<ul>
							<li><strong>Sick Leave:</strong> For medical emergencies and
								health issues</li>
							<li><strong>Casual Leave:</strong> For personal reasons and
								casual absences</li>
							<li><strong>Earned Leave:</strong> Planned vacation and time
								off</li>
							<li><strong>Emergency Leave:</strong> For unforeseen
								emergencies</li>
						</ul>
					</div>
				</div>

				<!-- Start Date Field -->
				<div class="form-group">
					<label for="startDate"> Start Date <span class="required">*</span>
					</label> <input type="date" id="startDate" name="startDate" required
						title="Please select start date">
					<div class="help-text">Date when your leave will begin</div>
				</div>

				<!-- End Date Field -->
				<div class="form-group">
					<label for="endDate"> End Date <span class="required">*</span>
					</label> <input type="date" id="endDate" name="endDate" required
						title="Please select end date">
					<div class="help-text">Date when your leave will end (must be
						same or after start date)</div>
				</div>

				<!-- Number of Days (Calculated) -->
				<div class="form-group">
					<label for="numberOfDays"> Number of Days </label> <input
						type="text" id="numberOfDays" readonly
						placeholder="Calculated automatically" value="0 days">
					<div class="help-text">Total number of days requested
						(auto-calculated)</div>
				</div>

				<!-- Reason Field -->
				<div class="form-group">
					<label for="reason"> Reason <span class="required">*</span>
					</label>
					<textarea id="reason" name="reason"
						placeholder="Please provide a brief reason for your leave request..."
						required minlength="10" maxlength="500"
						title="Reason must be between 10 and 500 characters"></textarea>
					<div class="help-text">Minimum 10 characters, Maximum 500
						characters</div>
				</div>

				<!-- Buttons -->
				<div class="button-group">
					<button type="submit" class="btn-submit">Apply Leave</button>
					<button type="reset" class="btn-reset">Clear Form</button>
				</div>

			</form>
		</div>

		<!-- Back Link -->
		<a href="employeeDashboardServlet" class="back-link">← Back to Dashboard</a>

	</div>

	<!-- ===== FOOTER ===== -->
	<footer>
		<p>&copy; 2024 ELAMS - Employee Leave & Attendance Management
			System. All rights reserved.</p>
	</footer>

	<!-- ===== JAVASCRIPT VALIDATION ===== -->
	<script>
		// Calculate number of days between start and end date
		function calculateDays() {
			var startDate = document.getElementById("startDate").value;
			var endDate = document.getElementById("endDate").value;

			if (startDate && endDate) {
				var start = new Date(startDate);
				var end = new Date(endDate);
				var diffTime = Math.abs(end - start);
				var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
				
				document.getElementById("numberOfDays").value = diffDays + " day" + (diffDays > 1 ? "s" : "");
			}
		}

		// Update days on start date change
		document.getElementById("startDate").addEventListener("change", function() {
			calculateDays();
		});

		// Update days on end date change
		document.getElementById("endDate").addEventListener("change", function() {
			calculateDays();
		});

		// Validate form before submission
		function validateForm() {
			var employeeId = document.getElementById("employeeId").value.trim();
			var leaveType = document.getElementById("leaveType").value;
			var startDate = document.getElementById("startDate").value;
			var endDate = document.getElementById("endDate").value;
			var reason = document.getElementById("reason").value.trim();

			// Validate Employee ID
			if (employeeId === "" || employeeId <= 0) {
				alert("Please enter a valid Employee ID");
				document.getElementById("employeeId").focus();
				return false;
			}

			// Validate Leave Type
			if (leaveType === "" || leaveType === null) {
				alert("Please select a leave type");
				document.getElementById("leaveType").focus();
				return false;
			}

			// Validate Start Date
			if (startDate === "") {
				alert("Please select start date");
				document.getElementById("startDate").focus();
				return false;
			}

			// Validate End Date
			if (endDate === "") {
				alert("Please select end date");
				document.getElementById("endDate").focus();
				return false;
			}

			// Validate that end date is not before start date
			var start = new Date(startDate);
			var end = new Date(endDate);

			if (end < start) {
				alert("End date must be same or after start date");
				document.getElementById("endDate").focus();
				return false;
			}

			// Validate Reason
			if (reason.length < 10 || reason.length > 500) {
				alert("Reason must be between 10 and 500 characters");
				document.getElementById("reason").focus();
				return false;
			}

			// All validations passed
			return true;
		}

		// Show visual feedback on input focus
		var inputElements = document.querySelectorAll("input, select, textarea");
		inputElements.forEach(function(element) {
			element.addEventListener("focus", function() {
				this.style.borderColor = "#3498db";
			});

			element.addEventListener("blur", function() {
				this.style.borderColor = "#bdc3c7";
			});
		});

		// Prevent selecting past dates
		window.addEventListener('load', function() {
			var today = new Date();
			var dateString = today.getFullYear() + '-' + 
							String(today.getMonth() + 1).padStart(2, '0') + '-' + 
							String(today.getDate()).padStart(2, '0');
			document.getElementById("startDate").setAttribute("min", dateString);
			document.getElementById("endDate").setAttribute("min", dateString);
		});
	</script>

</body>

</html>