<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Employee - ELAMS</title>

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
	max-width: 600px;
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

/* Form Group - Last item has no bottom margin */
.form-group:last-of-type {
	margin-bottom: 25px;
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
.form-group input[type="text"], .form-group input[type="email"],
	.form-group input[type="tel"], .form-group select {
	width: 100%;
	padding: 10px 12px;
	border: 1px solid #bdc3c7;
	border-radius: 4px;
	font-size: 14px;
	font-family: Arial, sans-serif;
	transition: all 0.3s;
}

/* Input Focus Effect */
.form-group input[type="text"]:focus, .form-group input[type="email"]:focus,
	.form-group input[type="tel"]:focus, .form-group select:focus {
	outline: none;
	border-color: #3498db;
	box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
	background-color: #f9f9f9;
}

/* Input Placeholder */
.form-group input::placeholder {
	color: #95a5a6;
}

/* Buttons Container */
.button-group {
	display: flex;
	gap: 10px;
	justify-content: center;
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
}

/* ===== ERROR/SUCCESS MESSAGES ===== */
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
}
</style>

</head>

<body>

	<!-- ===== HEADER/NAVIGATION ===== -->
	<div class="navbar">
		<h1>ELAMS - Add Employee</h1>
	</div>

	<!-- ===== MAIN CONTENT AREA ===== -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Add New Employee</h2>

		<!-- Page Subtitle -->
		<p class="page-subtitle">Fill in the form below to add a new
			employee to the system</p>

		<!-- Info Box -->
		<div class="info-box">
			<strong>ℹ️ Note:</strong> All fields marked with <span
				style="color: #e74c3c;">*</span> are required. Please ensure all
			information is accurate.
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

		<!-- ===== ADD EMPLOYEE FORM ===== -->
		<div class="form-container">
			<form action="addEmployee" method="post"
				onsubmit="return validateForm()">

				<!-- Name Field -->
				<div class="form-group">
					<label for="name"> Employee Name <span class="required">*</span>
					</label> <input type="text" id="name" name="name"
						placeholder="Enter full name (e.g., John Doe)" required
						pattern="[A-Za-z\s]{2,50}"
						title="Name must contain only letters and be 2-50 characters">
				</div>

				<!-- Email Field -->
				<div class="form-group">
					<label for="email"> Email Address <span class="required">*</span>
					</label> <input type="email" id="email" name="email"
						placeholder="Enter email address (e.g., john@example.com)"
						required title="Please enter a valid email address">
				</div>

				<!-- Phone Field -->
				<div class="form-group">
					<label for="phone"> Phone Number <span class="required">*</span>
					</label> <input type="tel" id="phone" name="phone"
						placeholder="Enter phone number (e.g., 9876543210)" required
						pattern="[0-9\-\+\s]{10,15}" title="Phone must be 10-15 digits">
				</div>

				<!-- Department Field -->
				<div class="form-group">
					<label for="department"> Department <span class="required">*</span>
					</label> <select id="department" name="department" required
						title="Please select a department">
						<option value="">-- Select Department --</option>
						<option value="IT">Information Technology (IT)</option>
						<option value="HR">Human Resources (HR)</option>
						<option value="Finance">Finance</option>
						<option value="Sales">Sales</option>
						<option value="Marketing">Marketing</option>
						<option value="Operations">Operations</option>
						<option value="Other">Other</option>
					</select>
				</div>

				<!-- Designation Field -->
				<div class="form-group">
					<label for="designation"> Designation <span
						class="required">*</span>
					</label> <select id="designation" name="designation" required
						title="Please select a designation">
						<option value="">-- Select Designation --</option>
						<option value="Manager">Manager</option>
						<option value="Senior Developer">Senior Developer</option>
						<option value="Developer">Developer</option>
						<option value="Junior Developer">Junior Developer</option>
						<option value="Analyst">Analyst</option>
						<option value="Executive">Executive</option>
						<option value="Intern">Intern</option>
						<option value="Other">Other</option>
					</select>
				</div>

				<!-- Buttons -->
				<div class="button-group">
					<button type="submit" class="btn-submit">Save Employee</button>
					<button type="reset" class="btn-reset">Clear Form</button>
				</div>

			</form>
		</div>

		<!-- Back Link -->
		<a href="viewEmployeesServlet" class="back-link">← Back to
			Employees List</a>

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
			// Get form values
			var name = document.getElementById("name").value.trim();
			var email = document.getElementById("email").value.trim();
			var phone = document.getElementById("phone").value.trim();
			var department = document.getElementById("department").value;
			var designation = document.getElementById("designation").value;

			// Check if name is valid
			if (name.length < 2 || name.length > 50) {
				alert("Name must be between 2 and 50 characters");
				document.getElementById("name").focus();
				return false;
			}

			// Check if name contains only letters and spaces
			if (!/^[A-Za-z\s]+$/.test(name)) {
				alert("Name must contain only letters and spaces");
				document.getElementById("name").focus();
				return false;
			}

			// Check if email is valid
			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailRegex.test(email)) {
				alert("Please enter a valid email address");
				document.getElementById("email").focus();
				return false;
			}

			// Check if phone is valid
			var phoneRegex = /^[0-9\-\+\s]{10,15}$/;
			if (!phoneRegex.test(phone)) {
				alert("Phone must be 10-15 digits");
				document.getElementById("phone").focus();
				return false;
			}

			// Check if department is selected
			if (department === "" || department === null) {
				alert("Please select a department");
				document.getElementById("department").focus();
				return false;
			}

			// Check if designation is selected
			if (designation === "" || designation === null) {
				alert("Please select a designation");
				document.getElementById("designation").focus();
				return false;
			}

			// All validations passed
			return true;
		}

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