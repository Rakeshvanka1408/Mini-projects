<%@page import="java.util.List"%>
<%@page import="com.rakesh.elams.model.Task"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equalsIgnoreCase("EMPLOYEE")) {
	response.sendRedirect("login.jsp");
	return;
}

List<Task> tasks = (List<Task>) request.getAttribute("tasks");
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
	font-family: 'Segoe UI', sans-serif;
}

body {
	background: linear-gradient(135deg, #0f172a, #1e293b, #334155);
	min-height: 100vh;
	padding: 40px;
}

.task-container {
	width: 100%;
	max-width: 1600px;
	margin: auto;
	background: rgba(255, 255, 255, 0.08);
	backdrop-filter: blur(18px);
	border: 1px solid rgba(255, 255, 255, 0.15);
	border-radius: 25px;
	padding: 35px;
	box-shadow: 0 8px 40px rgba(0, 0, 0, 0.3);
}

.page-title {
	color: white;
	font-size: 42px;
	margin-bottom: 30px;
	font-weight: 700;
}

table {
	width: 100%;
	border-collapse: collapse;
	overflow: hidden;
	border-radius: 18px;
	background: white;
}

th {
	background: linear-gradient(90deg, #2563eb, #1d4ed8);
	color: white;
	padding: 20px;
	font-size: 15px;
	position: sticky;
	top: 0;
}

td {
	padding: 18px;
	color: #475569;
	border-bottom: 1px solid #e2e8f0;
}

tr {
	transition: 0.3s;
}

tr:hover {
	background: #f8fafc;
	transform: scale(1.003);
}

.manager-badge {
	background: linear-gradient(135deg, #2563eb, #3b82f6);
	color: white;
	padding: 7px 15px;
	border-radius: 30px;
	font-size: 13px;
	font-weight: 600;
}

.status {
	padding: 8px 16px;
	border-radius: 30px;
	color: white;
	font-weight: 600;
	font-size: 13px;
}

.pending {
	background: linear-gradient(135deg, #f59e0b, #d97706);
}

.progress {
	background: linear-gradient(135deg, #0ea5e9, #0284c7);
}

.completed {
	background: linear-gradient(135deg, #22c55e, #16a34a);
}

.priority-high {
	background: #fee2e2;
	color: #dc2626;
	padding: 7px 14px;
	border-radius: 20px;
	font-weight: 700;
}

.priority-medium {
	background: #fef3c7;
	color: #d97706;
	padding: 7px 14px;
	border-radius: 20px;
	font-weight: 700;
}

.priority-low {
	background: #dcfce7;
	color: #16a34a;
	padding: 7px 14px;
	border-radius: 20px;
	font-weight: 700;
}

select {
	width: 100%;
	padding: 10px;
	border-radius: 10px;
	border: 1px solid #cbd5e1;
	background: white;
}

.update-btn {
	margin-top: 10px;
	width: 100%;
	border: none;
	padding: 10px;
	border-radius: 10px;
	background: linear-gradient(135deg, #22c55e, #16a34a);
	color: white;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
}

.update-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(34, 197, 94, 0.4);
}

.file-link {
	text-decoration: none;
	color: #2563eb;
	font-weight: 600;
}

.file-link:hover {
	color: #1d4ed8;
}

.action-bar {
	margin-top: 35px;
	display: flex;
	justify-content: space-between;
}

.btn-refresh, .btn-back {
	padding: 14px 30px;
	text-decoration: none;
	color: white;
	border-radius: 12px;
	font-weight: 600;
	transition: 0.3s;
}

.btn-refresh {
	background: linear-gradient(135deg, #0ea5e9, #2563eb);
}

.btn-back {
	background: linear-gradient(135deg, #64748b, #475569);
}

.btn-refresh:hover, .btn-back:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
}

.no-task-box {
	text-align: center;
	padding: 80px;
	color: white;
}

.no-task-box i {
	font-size: 80px;
	margin-bottom: 20px;
	color: #94a3b8;
}

.no-task-box h2 {
	margin-bottom: 10px;
}

@media ( max-width :1100px) {
	body {
		padding: 15px;
	}
	.task-container {
		overflow-x: auto;
	}
	table {
		min-width: 1200px;
	}
	.action-bar {
		flex-direction: column;
		gap: 15px;
	}
	.btn-refresh, .btn-back {
		text-align: center;
	}
}
</style>

</head>

<body>

	<div class="task-container">

		<h1 class="page-title">My Tasks</h1>

		<%
		if (tasks == null || tasks.isEmpty()) {
		%>

		<div class="no-task-box">
			<i class="fa-solid fa-list-check"></i>
			<h2>No Tasks Found</h2>
			<p>You don't have any assigned tasks at the moment.</p>
		</div>

		<%
		} else {
		%>

		<table>

			<tr>
				<th>Task ID</th>
				<th>Task Name</th>
				<th>Description</th>
				<th>Manager</th>
				<th>Priority</th>
				<th>Status</th>
				<th>Due Date</th>
				<th>Attachment</th>
				<th>Update Status</th>
			</tr>

			<%
			for (Task task : tasks) {
			%>

			<tr>

				<td><%=task.getTaskId()%></td>

				<td><%=task.getTaskName()%></td>

				<td><%=task.getDescription()%></td>

				<td><span class="manager-badge"> <%=task.getManagerId()%>
				</span></td>

				<td>
<%
if(task.getPriority().toString().equals("HIGH")){
%>
    <span class="priority-high">HIGH</span>
<%
}else if(task.getPriority().toString().equals("MEDIUM")){
%>
    <span class="priority-medium">MEDIUM</span>
<%
}else{
%>
    <span class="priority-low">LOW</span>
<%
}
%>
</td>
				<td>
					<%
					if (task.getStatus().toString().equals("PENDING")) {
					%> <span class="status pending">Pending</span> <%
 } else if (task.getStatus().toString().equals("IN_PROGRESS")) {
 %> <span class="status progress">In Progress</span> <%
 } else {
 %> <span class="status completed">Completed</span> <%
 }
 %>
				</td>

				<td><%=task.getDueDate()%></td>

				<td>
					<%
					if (task.getDocumentPath() != null && !task.getDocumentPath().trim().isEmpty()) {
					%> <a
					href="DownloadTaskFileServlet?file=<%=task.getDocumentPath()%>"
					target="_blank" class="file-link"> <i
						class="fa-solid fa-file-arrow-down"></i> Download File
				</a> <%
 } else {
 %> <span style="color: #999;">No File</span> <%
 }
 %>
				</td>

				<td>

					<form action="UpdateTaskStatusServlet" method="post">

						<input type="hidden" name="taskId" value="<%=task.getTaskId()%>">

						<select name="status">

							<option value="PENDING"
								<%=task.getStatus().toString().equals("PENDING") ? "selected" : ""%>>
								Pending</option>

							<option value="IN_PROGRESS"
								<%=task.getStatus().toString().equals("IN_PROGRESS") ? "selected" : ""%>>
								In Progress</option>

							<option value="COMPLETED"
								<%=task.getStatus().toString().equals("COMPLETED") ? "selected" : ""%>>
								Completed</option>

						</select> <br> <br>

						<button type="submit" class="update-btn">Update</button>

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
			<a href="javascript:location.reload();" class="btn-refresh">🔄
				Refresh</a> <a href="employeeDashboard.jsp" class="btn-back">← Back
				to Dashboard</a>
		</div>
	</div>

</body>
</html>