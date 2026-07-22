<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.rakesh.elams.model.Task"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equalsIgnoreCase("EMPLOYEE")) {
	response.sendRedirect("login.jsp");
	return;
}

String employeeName = (String) session.getAttribute("employeeName");

if (employeeName == null || employeeName.trim().isEmpty()) {
	employeeName = "Employee";
}

List<Task> tasks = (List<Task>) request.getAttribute("tasks");

int totalTasks = 0;
int pendingTasks = 0;
int progressTasks = 0;
int completedTasks = 0;

if (tasks != null) {
	totalTasks = tasks.size();

	for (Task task : tasks) {
		if ("PENDING".equals(task.getStatus().toString())) {
	pendingTasks++;
		} else if ("IN_PROGRESS".equals(task.getStatus().toString())) {
	progressTasks++;
		} else if ("COMPLETED".equals(task.getStatus().toString())) {
	completedTasks++;
		}
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Tasks - ELAMS</title>

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
	--success: #10b981;
	--warning: #f59e0b;
	--danger: #ef4444;
	--light: #f9fafb;
	--light2: #f3f4f6;
	--border: #e5e7eb;
	--text: #1f2937;
	--text-light: #6b7280;
	--shadow-sm: 0 1px 2px rgba(0, 0, 0, .05);
	--shadow-md: 0 4px 6px rgba(0, 0, 0, .08);
	--shadow-lg: 0 15px 35px rgba(0, 0, 0, .08);
}

body {
	background: linear-gradient(135deg, #f9fafb, #f3f4f6);
	min-height: 100vh;
	padding: 30px;
	color: var(--text);
}

/* Header */
.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	flex-wrap: wrap;
	gap: 20px;
}

.page-title {
	font-size: 38px;
	font-weight: 700;
	display: flex;
	align-items: center;
	gap: 15px;
}

.page-title i {
	color: var(--primary);
}

.page-subtitle {
	margin-top: 10px;
	color: var(--text-light);
}

.user-box {
	display: flex;
	align-items: center;
	gap: 12px;
	background: white;
	padding: 12px 20px;
	border-radius: 50px;
	box-shadow: var(--shadow-md);
}

.user-box i {
	color: var(--primary);
	font-size: 22px;
}

.user-box span {
	font-weight: 600;
}

/* Stats */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
}

.stat-card {
	background: white;
	border-radius: 18px;
	padding: 25px;
	box-shadow: var(--shadow-lg);
	transition: .3s;
	border-top: 5px solid var(--primary);
}

.stat-card:hover {
	transform: translateY(-6px);
}

.stat-card.pending {
	border-top-color: var(--warning);
}

.stat-card.progress {
	border-top-color: #0ea5e9;
}

.stat-card.completed {
	border-top-color: var(--success);
}

.stat-card h2 {
	font-size: 34px;
}

.stat-card p {
	color: var(--text-light);
	margin-top: 8px;
}

.stat-card i {
	float: right;
	font-size: 30px;
	opacity: .2;
}

/* Task Table */
.task-card {
	background: white;
	border-radius: 20px;
	padding: 25px;
	box-shadow: var(--shadow-lg);
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 1200px;
}

th {
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	color: white;
	padding: 18px;
	text-align: left;
}

td {
	padding: 18px;
	border-bottom: 1px solid var(--border);
}

tr:hover {
	background: #f8fafc;
}

.manager-badge {
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	color: white;
	padding: 7px 14px;
	border-radius: 20px;
	font-size: 13px;
	font-weight: 600;
}

/* Priority */
.priority {
	padding: 8px 14px;
	border-radius: 20px;
	font-weight: 700;
	font-size: 13px;
}

.high {
	background: #fee2e2;
	color: #dc2626;
}

.medium {
	background: #fef3c7;
	color: #d97706;
}

.low {
	background: #dcfce7;
	color: #16a34a;
}

/* Status */
.status {
	color: white;
	padding: 8px 14px;
	border-radius: 20px;
	font-size: 13px;
	font-weight: 600;
}

.pending-status {
	background: #f59e0b;
}

.progress-status {
	background: #0ea5e9;
}

.completed-status {
	background: #10b981;
}

/* Form */
select {
	width: 100%;
	padding: 10px;
	border-radius: 10px;
	border: 2px solid var(--border);
}

.update-btn {
	width: 100%;
	margin-top: 10px;
	padding: 10px;
	border: none;
	border-radius: 10px;
	background: linear-gradient(135deg, var(--success), #059669);
	color: white;
	cursor: pointer;
	font-weight: 600;
}

.update-btn:hover {
	transform: translateY(-2px);
}

.update-btn:disabled {
	background: #cbd5e1;
	cursor: not-allowed;
}

.file-link {
	color: var(--primary);
	text-decoration: none;
	font-weight: 600;
}

/* Empty */
.empty-state {
	text-align: center;
	padding: 80px 20px;
}

.empty-state i {
	font-size: 80px;
	color: #cbd5e1;
}

.empty-state h2 {
	margin-top: 20px;
}

.empty-state p {
	margin-top: 10px;
	color: var(--text-light);
}

/* Actions */
.action-bar {
	display: flex;
	gap: 20px;
	margin-top: 25px;
	flex-wrap: wrap;
}

.btn {
	padding: 14px 24px;
	border-radius: 12px;
	text-decoration: none;
	color: white;
	font-weight: 600;
}

.btn-refresh {
	background: linear-gradient(135deg, var(--primary), var(--primary-dark));
}

.btn-back {
	background: linear-gradient(135deg, #64748b, #475569);
}

.btn-logout {
	background: linear-gradient(135deg, #ef4444, #dc2626);
}

@media ( max-width :900px) {
	body {
		padding: 15px;
	}
	.page-title {
		font-size: 28px;
	}
	.action-bar {
		flex-direction: column;
	}
	.btn {
		text-align: center;
	}
}
</style>
</head>

<body>

	<div class="page-header">

		<div>
			<h1 class="page-title">
				<i class="fa-solid fa-list-check"></i> My Tasks
			</h1>

			<p class="page-subtitle">
				Welcome back <strong><%=employeeName%></strong>. Manage your
				assigned tasks here.
			</p>
		</div>

		<div class="user-box">
			<i class="fa-solid fa-user"></i> <span><%=employeeName%></span>
		</div>

	</div>

	<div class="stats-grid">

		<div class="stat-card">
			<i class="fa-solid fa-list"></i>
			<h2><%=totalTasks%></h2>
			<p>Total Tasks</p>
		</div>

		<div class="stat-card pending">
			<i class="fa-solid fa-hourglass-half"></i>
			<h2><%=pendingTasks%></h2>
			<p>Pending Tasks</p>
		</div>

		<div class="stat-card progress">
			<i class="fa-solid fa-spinner"></i>
			<h2><%=progressTasks%></h2>
			<p>In Progress</p>
		</div>

		<div class="stat-card completed">
			<i class="fa-solid fa-circle-check"></i>
			<h2><%=completedTasks%></h2>
			<p>Completed Tasks</p>
		</div>

	</div>

	<div class="task-card">

		<%
		if (tasks == null || tasks.isEmpty()) {
		%>

		<div class="empty-state">
			<i class="fa-solid fa-list-check"></i>
			<h2>No Tasks Assigned Yet</h2>
			<p>Your manager hasn't assigned any tasks yet.</p>
		</div>

		<%
		} else {
		%>

		<table>

			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Description</th>
				<th>Manager</th>
				<th>Priority</th>
				<th>Status</th>
				<th>Assigned Date</th>
				<th>Due Date</th>
				<th>Completed Date</th>
				<th>Attachment</th>
				<th>Update</th>
			</tr>

			<%
			for (Task task : tasks) {
			%>

			<tr>

				<td><%=task.getTaskId()%></td>

				<td><strong><%=task.getTaskName()%></strong></td>

				<td><%=task.getDescription()%></td>
				<td>
    <span class="manager-badge">
        <%=task.getManagerId()%>
    </span>
</td>

				<td>
					<%
					if ("HIGH".equals(task.getPriority().toString())) {
					%> <span class="priority high">HIGH</span> <%
						 } else if ("MEDIUM".equals(task.getPriority().toString())) {
						 %> <span class="priority medium">MEDIUM</span> <%
						 } else {
						 %> <span class="priority low">LOW</span> <%
						 }
					 %>
				</td>

				<td>
					<%
					if ("PENDING".equals(task.getStatus().toString())) {
					%> <span class="status pending-status">Pending</span> <%
 } else if ("IN_PROGRESS".equals(task.getStatus().toString())) {
 %> <span class="status progress-status">In Progress</span> <%
 } else {
 %> <span class="status completed-status">Completed</span> <%
 }
 %>
				</td>
						<td>
    <%= task.getAssignedDate() %>
</td>
				<td>
					<%
					try {
						LocalDate due = task.getDueDate().toLocalDate();

						if (due.isBefore(LocalDate.now()) && !"COMPLETED".equals(task.getStatus().toString())) {
					%> <span style="color: red; font-weight: bold;"> <i
						class="fa-solid fa-triangle-exclamation"></i> Overdue
				</span> <br> <%
 }
 } catch (Exception e) {
 }
 %> <%=task.getDueDate()%>
				</td>
<td>
<%
if(task.getCompletionDate() != null){
%>
    <%= task.getCompletionDate() %>
<%
}else{
%>
    <span style="color:#94a3b8;">Not Completed</span>
<%
}
%>
</td>
				<td>
					<%
					if (task.getDocumentPath() != null && !task.getDocumentPath().trim().isEmpty()) {
					%> <a
					href="DownloadTaskFileServlet?file=<%=task.getDocumentPath()%>"
					class="file-link" target="_blank"> <i
						class="fa-solid fa-download"></i> Download
				</a> <%
 } else {
 %> <span style="color: #94a3b8;">No File</span> <%
 }
 %>

				</td>

				<td>

					<form action="UpdateTaskStatusServlet" method="post">

						<input type="hidden" name="taskId" value="<%=task.getTaskId()%>">

						<select name="status"
							<%="COMPLETED".equals(task.getStatus().toString()) ? "disabled" : ""%>>

							<option value="PENDING"
								<%="PENDING".equals(task.getStatus().toString()) ? "selected" : ""%>>
								Pending</option>

							<option value="IN_PROGRESS"
								<%="IN_PROGRESS".equals(task.getStatus().toString()) ? "selected" : ""%>>
								In Progress</option>

							<option value="COMPLETED"
								<%="COMPLETED".equals(task.getStatus().toString()) ? "selected" : ""%>>
								Completed</option>

						</select>

						<button class="update-btn"
							<%="COMPLETED".equals(task.getStatus().toString()) ? "disabled" : ""%>>
							<i class="fa-solid fa-floppy-disk"></i> Update
						</button>

					</form>

				</td>

			</tr>

			<%
			}
			%>

		</table>

		<%
		}
		%>

		<div class="action-bar">

			<a href="javascript:location.reload()" class="btn btn-refresh"> <i
				class="fa-solid fa-rotate"></i> Refresh
			</a>




		</div>

	</div>

</body>
</html>