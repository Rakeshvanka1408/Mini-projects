<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rakesh.elams.model.Employee"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee List - ELAMS</title>

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
	line-height: 1.6;
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
	max-width: 1400px;
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

/* ===== ACTION BUTTONS SECTION ===== */
.action-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	flex-wrap: wrap;
	gap: 15px;
}

.btn-add-employee {
	background-color: #27ae60;
	color: white;
	padding: 12px 24px;
	text-decoration: none;
	border-radius: 4px;
	font-weight: bold;
	transition: all 0.3s;
	display: inline-block;
	border: 2px solid #27ae60;
}

.btn-add-employee:hover {
	background-color: #229954;
	border-color: #229954;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}
.btn-dashboard {
    background-color: #34495e;
    color: white;
    padding: 12px 24px;
    text-decoration: none;
    border-radius: 4px;
    font-weight: bold;
    margin-left: 10px;
    display: inline-block;
    border: 2px solid #34495e;
    transition: all 0.3s;
}

.btn-dashboard:hover {
    background-color: #2c3e50;
    border-color: #2c3e50;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
}

/* Search/Filter Box */
.search-box {
	display: flex;
	gap: 10px;
}

.search-box input {
	padding: 10px 12px;
	border: 1px solid #bdc3c7;
	border-radius: 4px;
	font-size: 14px;
}

.search-box button {
	background-color: #3498db;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
	transition: all 0.3s;
}

.search-box button:hover {
	background-color: #2980b9;
}

/* ===== STATS SECTION ===== */
.stats-section {
	display: flex;
	gap: 20px;
	justify-content: center;
	margin-bottom: 30px;
	flex-wrap: wrap;
}

.stat-card {
	background-color: white;
	border: 2px solid #bdc3c7;
	border-radius: 8px;
	padding: 15px 25px;
	text-align: center;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.stat-card .stat-label {
	font-size: 12px;
	color: #7f8c8d;
	text-transform: uppercase;
	font-weight: bold;
}

.stat-card .stat-value {
	font-size: 28px;
	color: #2c3e50;
	font-weight: bold;
	margin-top: 8px;
}

/* ===== TABLE SECTION ===== */
.table-section {
	background-color: white;
	border: 2px solid #bdc3c7;
	border-radius: 8px;
	padding: 25px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	overflow-x: auto;
}

.table-section h2 {
	font-size: 20px;
	color: #2c3e50;
	margin-bottom: 20px;
	border-bottom: 2px solid #3498db;
	padding-bottom: 10px;
}

/* Table Styling */
table {
	width: 100%;
	border-collapse: collapse;
}

/* Table Header */
table thead {
	background-color: #34495e;
	color: white;
}

table th {
	padding: 12px 15px;
	text-align: left;
	font-weight: 600;
	font-size: 13px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	border: 1px solid #2c3e50;
}

/* Table Body */
table td {
	padding: 12px 15px;
	border: 1px solid #ecf0f1;
	font-size: 14px;
}

/* Table Row */
table tbody tr {
	transition: background-color 0.3s;
}

table tbody tr:hover {
	background-color: #f9f9f9;
}

/* Alternate Row Colors */
table tbody tr:nth-child(even) {
	background-color: #f5f5f5;
}

/* Employee ID - Bold */
.employee-id {
	font-weight: bold;
	color: #2c3e50;
}

/* Employee Name - Emphasis */
.employee-name {
	font-weight: 600;
	color: #2c3e50;
}

/* Department Badge */
.department-badge {
	display: inline-block;
	padding: 4px 10px;
	background-color: #ecf0f1;
	border-radius: 12px;
	font-size: 12px;
	font-weight: bold;
	color: #2c3e50;
}

/* Designation Badge */
.designation-badge {
	display: inline-block;
	padding: 4px 10px;
	background-color: #e8f4f8;
	border-radius: 12px;
	font-size: 12px;
	font-weight: bold;
	color: #2980b9;
}

/* Action Buttons in Table */
.action-buttons {
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
}

.btn-edit, .btn-delete {
	padding: 6px 12px;
	text-decoration: none;
	border-radius: 4px;
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
	border: none;
	transition: all 0.3s;
	display: inline-block;
}

/* Edit Button */
.btn-edit {
	background-color: #3498db;
	color: white;
	border: 1px solid #3498db;
}

.btn-edit:hover {
	background-color: #2980b9;
	border-color: #2980b9;
}

/* Delete Button */
.btn-delete {
	background-color: #e74c3c;
	color: white;
	border: 1px solid #e74c3c;
}

.btn-delete:hover {
	background-color: #c0392b;
	border-color: #c0392b;
}

/* ===== NO DATA MESSAGE ===== */
.no-data {
	text-align: center;
	padding: 40px 20px;
	color: #7f8c8d;
	font-size: 16px;
}

.no-data-icon {
	font-size: 48px;
	margin-bottom: 15px;
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

/* ===== PAGINATION ===== */
.pagination {
	display: flex;
	justify-content: center;
	gap: 5px;
	margin-top: 25px;
	flex-wrap: wrap;
}

.pagination a, .pagination span {
	padding: 8px 12px;
	border: 1px solid #bdc3c7;
	border-radius: 4px;
	text-decoration: none;
	color: #3498db;
	transition: all 0.3s;
}

.pagination a:hover {
	background-color: #3498db;
	color: white;
}

.pagination .active {
	background-color: #3498db;
	color: white;
	border-color: #3498db;
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
	.action-bar {
		flex-direction: column;
		align-items: stretch;
	}
	.btn-add-employee {
		text-align: center;
		width: 100%;
	}
	.search-box {
		flex-direction: column;
		width: 100%;
	}
	.search-box input, .search-box button {
		width: 100%;
	}
	.stats-section {
		flex-direction: column;
		align-items: center;
	}
	.stat-card {
		width: 100%;
		max-width: 300px;
	}
	.table-section {
		padding: 15px;
		overflow-x: auto;
	}
	table {
		font-size: 12px;
	}
	table th, table td {
		padding: 8px 10px;
	}
	.action-buttons {
		flex-direction: column;
	}
	.btn-edit, .btn-delete {
		width: 100%;
		text-align: center;
	}
	.department-badge, .designation-badge {
		font-size: 10px;
		padding: 3px 8px;
	}
}
</style>

</head>

<body>

	<!-- ===== HEADER/NAVIGATION ===== -->
	<div class="navbar">
		<h1>ELAMS - Employee Management</h1>
	</div>

	<!-- ===== MAIN CONTENT AREA ===== -->
	<div class="container">

		<!-- Page Title -->
		<h2 class="page-title">Employee Directory</h2>

		<!-- Page Subtitle -->
		<p class="page-subtitle">Manage all employees and their
			information</p>

		<!-- Info Box -->
		<div class="info-box">
			<strong>ℹ️ Note:</strong> You can add new employees, view details,
			edit information, or remove employees from the system. Click "Edit"
			to modify employee details or "Delete" to remove an employee.
		</div>

		<!-- Action Bar - Add Employee Button and Search -->
		<div class="action-bar">

			<div>
				<a href="addEmployee.jsp" class="btn-add-employee"> + Add NewEmployee </a> 
				<a href="adminDashboard.jsp" class="btn-dashboard"> ←Back to Dashboard </a>
			</div>

		</div>

		<!-- Employee Statistics -->
		<%
		List<Employee> employees = (List<Employee>) request.getAttribute("employees");
		int totalEmployees = 0;
		if (employees != null) {
			totalEmployees = employees.size();
		}
		%>

		<div class="stats-section">
			<div class="stat-card">
				<div class="stat-label">Total Employees</div>
				<div class="stat-value"><%=totalEmployees%></div>
			</div>
		</div>

		<!-- ===== EMPLOYEE TABLE SECTION ===== -->
		<div class="table-section">
			<h2>👥 Employee List</h2>

			<%
			if (employees != null && !employees.isEmpty()) {
			%>

			<!-- Employees Table -->
			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Department</th>
						<th>Designation</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Employee emp : employees) {
					%>
					<tr>
						<td><span class="employee-id">#<%=emp.getEmployee_id()%></span>
						</td>
						<td><span class="employee-name"><%=emp.getEmployee_name()%></span>
						</td>
						<td><a href="mailto:<%=emp.getEmail()%>"
							style="color: #3498db; text-decoration: none;"> <%=emp.getEmail()%>
						</a></td>
						<td><a href="tel:<%=emp.getPhone()%>"
							style="color: #3498db; text-decoration: none;"> <%=emp.getPhone()%>
						</a></td>
						<td><span class="department-badge"><%=emp.getDepartment()%></span>
						</td>
						<td><span class="designation-badge"><%=emp.getDesignation()%></span>
						</td>
						<td>
							<div class="action-buttons">
								<a href="editEmployee?id=<%=emp.getEmployee_id()%>"
									class="btn-edit">Edit</a> <a href="javascript:void(0);"
									onclick="deleteEmployee(<%=emp.getEmployee_id()%>, '<%=emp.getEmployee_name()%>')"
									class="btn-delete">Delete</a>
							</div>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<%
			} else {
			%>

			<!-- No Data Message -->
			<div class="no-data">
				<div class="no-data-icon">📭</div>
				<p>No employees found in the system.</p>
				<p>
					<a href="addEmployee.jsp"
						style="color: #3498db; text-decoration: none;">Click here to
						add the first employee</a>
				</p>
			</div>

			<%
			}
			%>

		</div>

	</div>

	<!-- ===== FOOTER ===== -->
	<footer>
		<p>&copy; 2024 ELAMS - Employee Leave & Attendance Management
			System. All rights reserved.</p>
	</footer>

	<!-- ===== JAVASCRIPT FUNCTIONS ===== -->
	<script>
		// Delete employee with confirmation
		function deleteEmployee(employeeId, employeeName) {
			var confirmDelete = confirm(
				"Are you sure you want to delete this employee?\n\n" +
				"Employee ID: " + employeeId + "\n" +
				"Employee Name: " + employeeName + "\n\n" +
				"This action cannot be undone!"
			);

			if (confirmDelete) {
				// Redirect to delete servlet
				window.location.href = "deleteEmployee?id=" + employeeId;
			}
		}

		// Optional: Search functionality
		function filterTable(searchTerm) {
			var table = document.querySelector("table");
			var rows = table.querySelectorAll("tbody tr");

			rows.forEach(function(row) {
				var text = row.textContent.toLowerCase();
				if (text.includes(searchTerm.toLowerCase())) {
					row.style.display = "";
				} else {
					row.style.display = "none";
				}
			});
		}

		// Print employee list
		function printEmployeeList() {
			window.print();
		}
	</script>

</body>

</html>