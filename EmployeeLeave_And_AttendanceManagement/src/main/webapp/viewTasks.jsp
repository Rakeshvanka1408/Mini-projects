<%@page import="java.util.List"%>
<%@page import="com.rakesh.elams.model.Task"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !"MANAGER".equalsIgnoreCase(role)) {
	response.sendRedirect("login.jsp");
	return;
}

List<Task> tasks = (List<Task>) request.getAttribute("tasks");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Task Management - ELAMS</title>

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

.card {
	background: white;
	border-radius: 16px;
	box-shadow: var(--shadow-lg);
	padding: 30px;
	animation: slideUp 0.5s ease-out;
}

@keyframes slideUp {
	from {
		opacity: 0;
		transform: translateY(20px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.card-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 30px;
	padding-bottom: 25px;
	border-bottom: 2px solid var(--light-2);
	flex-wrap: wrap;
	gap: 20px;
}

.header-left {
	display: flex;
	align-items: center;
	gap: 15px;
}

.header-left i {
	font-size: 32px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.header-left h2 {
	font-size: 28px;
	font-weight: 700;
	color: var(--text-primary);
	margin: 0;
}

.create-btn {
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 12px 24px;
	background: linear-gradient(135deg, var(--success), #059669);
	color: white;
	border: none;
	border-radius: 10px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	text-decoration: none;
	font-size: 15px;
}

.create-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3);
}

/* Search & Filter Section */
.search-section {
	background: var(--light-2);
	padding: 20px;
	border-radius: 12px;
	margin-bottom: 25px;
}

.search-form {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 15px;
	align-items: end;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-group label {
	font-size: 13px;
	font-weight: 600;
	color: var(--text-primary);
	margin-bottom: 6px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.form-group input, .form-group select {
	padding: 11px 13px;
	border: 1px solid var(--border);
	border-radius: 8px;
	font-size: 14px;
	font-family: inherit;
	transition: all 0.3s ease;
	background: white;
}

.form-group input:focus, .form-group select:focus {
	outline: none;
	border-color: var(--primary);
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.form-group select {
	appearance: none;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%234f46e5' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 10px center;
	padding-right: 30px;
	cursor: pointer;
}

.btn-group {
	display: flex;
	gap: 10px;
}

.search-btn, .reset-btn {
	flex: 1;
	padding: 11px 18px;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}

.search-btn {
	background: var(--primary);
	color: white;
}

.search-btn:hover {
	background: var(--primary-dark);
	transform: translateY(-1px);
}

.reset-btn {
	background: var(--border);
	color: var(--text-primary);
}

.reset-btn:hover {
	background: #d1d5db;
}

/* Table Section */
.table-section {
	overflow: hidden;
	border-radius: 12px;
	border: 1px solid var(--border);
	background: white;
	box-shadow: var(--shadow-sm);
}

.table-wrapper {
	overflow-x: auto;
	overflow-y: auto;
	max-height: 600px;
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

/* Status & Priority Badge Styles */
.badge {
	display: inline-block;
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	white-space: nowrap;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

/* Priority Badges */
.badge-priority-high {
	background: #fee2e2;
	color: #991b1b;
}

.badge-priority-medium {
	background: #fef3c7;
	color: #b45309;
}

.badge-priority-low {
	background: #dcfce7;
	color: #15803d;
}

/* Status Badges */
.badge-status-pending {
	background: #fef3c7;
	color: #b45309;
}

.badge-status-progress {
	background: #dbeafe;
	color: #1e40af;
}

.badge-status-completed {
	background: #dcfce7;
	color: #15803d;
}

/* Action Buttons */
.action-buttons {
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
}

.action-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
	padding: 8px 12px;
	border: none;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	text-decoration: none;
	font-family: inherit;
}

.edit-btn {
	background: #dbeafe;
	color: #1e40af;
}

.edit-btn:hover {
	background: var(--info);
	color: white;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}

.delete-btn {
	background: #fee2e2;
	color: #991b1b;
}

.delete-btn:hover {
	background: var(--danger);
	color: white;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
}

.delete-form {
	display: inline-block;
	margin: 0;
}

.download-btn {
	background: #d1fae5;
	color: #065f46;
}

.download-btn:hover {
	background: var(--success);
	color: white;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

/* Empty State */
.empty-state {
	text-align: center;
	padding: 60px 20px;
}

.empty-state i {
	font-size: 48px;
	color: var(--text-secondary);
	margin-bottom: 15px;
	opacity: 0.5;
}

.empty-state p {
	font-size: 16px;
	color: var(--text-secondary);
	margin-bottom: 20px;
}

.empty-state a {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 12px 24px;
	background: var(--primary);
	color: white;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 600;
	transition: all 0.3s ease;
}

.empty-state a:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
}

/* Stats Bar */
.stats-bar {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
	gap: 15px;
	margin-bottom: 25px;
}

.stat-card {
	background: white;
	padding: 15px;
	border-radius: 12px;
	border-left: 4px solid var(--primary);
	text-align: center;
	box-shadow: var(--shadow-sm);
}

.stat-card.warning {
	border-left-color: var(--warning);
}

.stat-card.success {
	border-left-color: var(--success);
}

.stat-card.danger {
	border-left-color: var(--danger);
}

.stat-value {
	font-size: 24px;
	font-weight: 700;
	color: var(--text-primary);
}

.stat-label {
	font-size: 12px;
	color: var(--text-secondary);
	margin-top: 5px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

@media ( max-width : 1024px) {
	.card {
		padding: 20px;
	}
	.search-form {
		grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
	}
	table {
		font-size: 13px;
	}
	th, td {
		padding: 12px 10px;
	}
}

@media ( max-width : 768px) {
	.card-header {
		flex-direction: column;
		align-items: flex-start;
	}
	.create-btn {
		width: 100%;
	}
	.search-form {
		grid-template-columns: 1fr;
	}
	.btn-group {
		width: 100%;
	}
	.search-btn, .reset-btn {
		flex: 1;
	}
	.action-buttons {
		flex-direction: column;
	}
	.action-btn {
		width: 100%;
	}
	.stats-bar {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 480px) {
	body {
		padding: 15px 10px;
	}
	.card {
		padding: 15px;
	}
	.header-left h2 {
		font-size: 22px;
	}
	.table-wrapper {
		max-height: 400px;
	}
	table {
		font-size: 12px;
	}
	th, td {
		padding: 10px 8px;
	}
	.stats-bar {
		grid-template-columns: 1fr;
	}
}
</style>

</head>
<body>

	<div class="container">

		<div class="card">

			<div class="card-header">
				<div class="header-left">
					<i class="fa-solid fa-list-check"></i>
					<h2>Task Management</h2>
				</div>
				<a href="CreateTaskPageServlet" class="create-btn"> <i
					class="fa-solid fa-plus"></i> Create Task
				</a>
			</div>

			<div class="stats-bar">
				<div class="stat-card">
					<div class="stat-value">
						<%
						if (tasks != null) {
							out.print(tasks.size());
						} else {
							out.print("0");
						}
						%>
					</div>
					<div class="stat-label">Total Tasks</div>
				</div>
				<div class="stat-card warning">
					<div class="stat-value">
						<%
						int pending = 0;
						if (tasks != null) {
							for (Task task : tasks) {
								if (task.getStatus() == Task.Status.PENDING) {
							pending++;
								}
							}
						}
						out.print(pending);
						%>
					</div>
					<div class="stat-label">Pending</div>
				</div>
				<div class="stat-card">
					<div class="stat-value">
						<%
						int progress = 0;
						if (tasks != null) {
							for (Task task : tasks) {
								if (task.getStatus() == Task.Status.IN_PROGRESS) {
							progress++;
								}
							}
						}
						out.print(progress);
						%>
					</div>
					<div class="stat-label">In Progress</div>
				</div>
				<div class="stat-card success">
					<div class="stat-value">
						<%
						int completed = 0;
						if (tasks != null) {
							for (Task task : tasks) {
								if (task.getStatus() == Task.Status.COMPLETED) {
							completed++;
								}
							}
						}
						out.print(completed);
						%>
					</div>
					<div class="stat-label">Completed</div>
				</div>
			</div>

			<div class="search-section">
				<form action="SearchTaskServlet" method="get" class="search-form">

					<div class="form-group">
						<label><i class="fa-solid fa-search"></i> Task ID</label> <input
							type="text" name="taskId" placeholder="Search task ID...">
					</div>

					<div class="form-group">
						<label><i class="fa-solid fa-user"></i> Employee ID</label> <input
							type="number" name="employeeId" placeholder="Search employee...">
					</div>

					<div class="form-group">
						<label><i class="fa-solid fa-circle-check"></i> Status</label> <select
							name="status">
							<option value="">All Status</option>
							<option value="PENDING">Pending</option>
							<option value="IN_PROGRESS">In Progress</option>
							<option value="COMPLETED">Completed</option>
						</select>
					</div>

					<div class="form-group">
						<label><i class="fa-solid fa-flag"></i> Priority</label> <select
							name="priority">
							<option value="">All Priority</option>
							<option value="HIGH">High</option>
							<option value="MEDIUM">Medium</option>
							<option value="LOW">Low</option>
						</select>
					</div>

					<div class="btn-group">
						<button type="submit" class="search-btn">
							<i class="fa-solid fa-search"></i> Search
						</button>
						<a href="ViewTasksServlet" class="reset-btn"> <i
							class="fa-solid fa-redo"></i> Reset
						</a>
					</div>

				</form>
			</div>

			<div class="table-section">
				<%
				if (tasks != null && !tasks.isEmpty()) {
				%>
				<div class="table-wrapper">
					<table>
						<thead>
							<tr>
								<th>Task ID</th>
								<th>Task Name</th>
								<th>Employee ID</th>
								<th>Priority</th>
								<th>Status</th>
								<th>Assigned Date</th>
								<th>Due Date</th>
								<th>Completed Date</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Task task : tasks) {
								String priorityClass = "badge-priority-" + task.getPriority().toString().toLowerCase();
								String statusValue = task.getStatus().toString();
								String statusClass = "badge-status-pending";

								if (statusValue.equals("IN_PROGRESS")) {
									statusClass = "badge-status-progress";
								} else if (statusValue.equals("COMPLETED")) {
									statusClass = "badge-status-completed";
								}
							%>
							<tr>
								<td><strong><%=task.getTaskId()%></strong></td>
								<td><%=task.getTaskName()%></td>
								<td><%=task.getEmployeeId()%></td>
								<td><span class="badge <%=priorityClass%>"> <%=task.getPriority()%>
								</span></td>
								<td><span class="badge <%=statusClass%>"> <%=statusValue%>
								</span></td>
								<td><%=task.getAssignedDate()%></td>

								<td><%=task.getDueDate()%></td>

								<td>
									<%
									if (task.getCompletionDate() != null) {
										out.print(task.getCompletionDate());
									} else {
										out.print("-");
									}
									%>
								</td>

								
								<td>
									<div class="action-buttons">
										<a class="action-btn edit-btn"
											href="editTasks.jsp?taskId=<%=task.getTaskId()%>"
											title="Edit Task"> <i class="fa-solid fa-pen"></i> Edit
										</a>
										<%
										if (task.getDocumentPath() != null && !task.getDocumentPath().trim().isEmpty()) {
										%>
										<a class="action-btn download-btn"
											href="DownloadTaskFileServlet?file=<%=java.net.URLEncoder.encode(task.getDocumentPath(), "UTF-8")%>"
											title="Download Document"> <i
											class="fa-solid fa-download"></i> Download
										</a>
										<%
										}
										%>
										<form class="delete-form" action="DeleteTaskServlet"
											method="post"
											onsubmit="return confirm('Are you sure you want to delete this task?');">
											<input type="hidden" name="taskId"
												value="<%=task.getTaskId()%>">
											<button type="submit" class="action-btn delete-btn"
												title="Delete Task">
												<i class="fa-solid fa-trash"></i> Delete
											</button>
										</form>
									</div>
								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				<%
				} else {
				%>
				<div class="empty-state">
					<i class="fa-solid fa-inbox"></i>
					<p>No tasks found</p>
					<a href="CreateTaskPageServlet"> <i class="fa-solid fa-plus"></i>
						Create Your First Task
					</a>
				</div>
				<%
				}
				%>
			</div>

		</div>

	</div>

</body>
</html>