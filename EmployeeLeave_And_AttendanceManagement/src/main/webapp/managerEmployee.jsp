<%@ page import="java.util.List"%>
<%@ page import="com.rakesh.elams.model.Employee"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equalsIgnoreCase("MANAGER")) {
	response.sendRedirect("login.jsp");
	return;
}

List<Employee> employees = (List<Employee>) request.getAttribute("employees");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Management - ELAMS</title>

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
	--warning: #f59e0b;
	--danger: #ef4444;
	--info: #3b82f6;
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
	max-width: 1400px;
	margin: 0 auto;
}

.header {
	display: flex;
	align-items: center;
	gap: 15px;
	margin-bottom: 35px;
	padding-bottom: 25px;
	border-bottom: 2px solid white;
	animation: slideDown 0.5s ease-out;
}

@
keyframes slideDown {from { opacity:0;
	transform: translateY(-20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.header i {
	font-size: 36px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.header h1 {
	font-size: 32px;
	font-weight: 700;
	color: var(--text-primary);
	margin: 0;
}

/* Summary Cards */
.summary {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
	animation: slideUp 0.6s ease-out;
}

@
keyframes slideUp {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.card {
	background: white;
	padding: 30px;
	border-radius: 16px;
	box-shadow: var(--shadow-lg);
	border-left: 4px solid var(--primary);
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	position: relative;
	overflow: hidden;
}

.card::before {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	width: 100px;
	height: 100px;
	background: radial-gradient(circle, rgba(99, 102, 241, 0.1) 0%,
		transparent 70%);
	border-radius: 50%;
	transform: translate(30px, -30px);
	pointer-events: none;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 15px 35px rgba(99, 102, 241, 0.15);
}

.card h3 {
	font-size: 14px;
	color: var(--text-secondary);
	text-transform: uppercase;
	letter-spacing: 0.5px;
	font-weight: 600;
	margin-bottom: 12px;
	display: flex;
	align-items: center;
	gap: 8px;
	position: relative;
	z-index: 1;
}

.card h3 i {
	font-size: 18px;
	color: var(--primary);
}

.card .count {
	font-size: 42px;
	font-weight: 700;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
	position: relative;
	z-index: 1;
}

/* Table Container */
.table-container {
	background: white;
	border-radius: 16px;
	box-shadow: var(--shadow-lg);
	overflow: hidden;
	border: 1px solid var(--border);
	animation: slideUp 0.7s ease-out;
}

.table-wrapper {
	overflow-x: auto;
	overflow-y: auto;
	max-height: 650px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

thead {
	position: sticky;
	top: 0;
	z-index: 10;
}

th {
	background: linear-gradient(135deg, var(--primary), var(--primary-dark));
	color: white;
	padding: 16px 15px;
	text-align: left;
	font-size: 13px;
	font-weight: 600;
	letter-spacing: 0.5px;
	border-bottom: 2px solid var(--primary-dark);
}

td {
	padding: 15px;
	border-bottom: 1px solid var(--border);
	font-size: 14px;
}

tbody tr {
	transition: background-color 0.3s ease;
}

tbody tr:hover {
	background: var(--light-2);
}

tbody tr:last-child td {
	border-bottom: none;
}

/* Employee ID */
.employee-id {
	font-weight: 600;
	color: var(--primary);
	display: inline-flex;
	align-items: center;
	gap: 6px;
}

.employee-id i {
	font-size: 16px;
}

/* Department & Designation Badges */
.badge {
	display: inline-block;
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	white-space: nowrap;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.department {
	background: #dbeafe;
	color: #1e40af;
}

.designation {
	background: #dcfce7;
	color: #15803d;
}

/* Contact Info */
.email-cell, .phone-cell {
	display: flex;
	align-items: center;
	gap: 8px;
}

.email-cell i, .phone-cell i {
	color: var(--primary);
	font-size: 14px;
}

/* Empty State */
.empty-state {
	text-align: center;
	padding: 80px 20px;
}

.empty-state i {
	font-size: 64px;
	color: var(--text-secondary);
	margin-bottom: 20px;
	opacity: 0.5;
}

.empty-state h3 {
	font-size: 20px;
	color: var(--text-primary);
	margin-bottom: 10px;
}

.empty-state p {
	font-size: 16px;
	color: var(--text-secondary);
}

/* Responsive */
@media ( max-width : 1024px) {
	.table-wrapper {
		max-height: 550px;
	}
	th, td {
		padding: 12px 10px;
	}
	table {
		font-size: 13px;
	}
}

@media ( max-width : 768px) {
	body {
		padding: 20px 15px;
	}
	.container {
		max-width: 100%;
	}
	.header {
		flex-direction: column;
		align-items: flex-start;
		margin-bottom: 25px;
	}
	.header h1 {
		font-size: 24px;
	}
	.summary {
		grid-template-columns: 1fr;
		margin-bottom: 20px;
	}
	.card {
		padding: 20px;
	}
	.card .count {
		font-size: 36px;
	}
	.table-wrapper {
		max-height: 450px;
	}
	th, td {
		padding: 12px 8px;
	}
	table {
		font-size: 12px;
	}
	.badge {
		font-size: 11px;
		padding: 5px 12px;
	}
	.email-cell, .phone-cell {
		flex-direction: column;
		align-items: flex-start;
		gap: 4px;
	}
}

@media ( max-width : 480px) {
	body {
		padding: 15px 10px;
	}
	.header i {
		font-size: 28px;
	}
	.header h1 {
		font-size: 20px;
	}
	.summary {
		gap: 12px;
	}
	.card {
		padding: 16px;
	}
	.card h3 {
		font-size: 12px;
	}
	.card .count {
		font-size: 32px;
	}
	.table-wrapper {
		max-height: 400px;
	}
	th, td {
		padding: 10px 6px;
		font-size: 11px;
	}
	.badge {
		font-size: 10px;
		padding: 4px 10px;
	}
	.employee-id {
		font-size: 13px;
	}
}
</style>

</head>

<body>

	<div class="container">

		<!-- Page Header -->
		<div class="header">
			<i class="fa-solid fa-users"></i>
			<h1>Employee Management</h1>
		</div>

		<!-- Summary Cards -->
		<div class="summary">
			<div class="card">
				<h3>
					<i class="fa-solid fa-users-line"></i> Total Employees
				</h3>
				<div class="count">
					<%=employees != null ? employees.size() : 0%>
				</div>
			</div>
		</div>

		<!-- Employee Table -->
		<div class="table-container">

			<%
			if (employees == null || employees.isEmpty()) {
			%>

			<div class="empty-state">
				<i class="fa-solid fa-inbox"></i>
				<h3>No Employees Found</h3>
				<p>There are currently no employees to display.</p>
			</div>

			<%
			} else {
			%>

			<div class="table-wrapper">
				<table>

					<thead>
						<tr>
							<th><i class="fa-solid fa-id-card"></i> Employee ID</th>
							<th><i class="fa-solid fa-user"></i> Name</th>
							<th><i class="fa-solid fa-envelope"></i> Email</th>
							<th><i class="fa-solid fa-phone"></i> Phone</th>
							<th><i class="fa-solid fa-building"></i> Department</th>
							<th><i class="fa-solid fa-briefcase"></i> Designation</th>
							<th><i class="fa-solid fa-user-tie"></i> Reports To</th>
						</tr>
					</thead>

					<tbody>
						<%
						for (Employee emp : employees) {
						%>

						<tr>
							<td><span class="employee-id"> <i
									class="fa-solid fa-circle-user"></i> EMP-<%=emp.getEmployee_id()%>
							</span></td>

							<td><strong><%=emp.getEmployee_name()%></strong></td>

							<td>
								<div class="email-cell">
									<i class="fa-solid fa-envelope"></i> <span><%=emp.getEmail()%></span>
								</div>
							</td>

							<td>
								<div class="phone-cell">
									<i class="fa-solid fa-phone"></i> <span><%=emp.getPhone()%></span>
								</div>
							</td>

							<td><span class="badge department"> <%=emp.getDepartment()%>
							</span></td>

							<td><span class="badge designation"> <%=emp.getDesignation()%>
							</span></td>
							<td><span class="badge designation"> <%=emp.getManagerName()%>
							</span></td>
						</tr>

						<%
						}
						%>
					</tbody>

				</table>
			</div>

			<%
			}
			%>

		</div>

	</div>

</body>
</html>
