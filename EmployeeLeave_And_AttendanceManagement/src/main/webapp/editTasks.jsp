<%@page import="com.rakesh.elams.dao.TaskDaoImpl"%>
<%@page import="com.rakesh.elams.dao.TaskDao"%>
<%@page import="com.rakesh.elams.model.Task"%>

<%
String role = (String)session.getAttribute("role");

if(role == null || !role.equalsIgnoreCase("MANAGER")){
    response.sendRedirect("login.jsp");
    return;
}

String taskId = request.getParameter("taskId");

TaskDao dao = new TaskDaoImpl();
Task task = dao.getTaskById(taskId);

if(task == null){
    response.sendRedirect("ViewTasksServlet");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Task - ELAMS</title>

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
	--danger: #ef4444;
	--warning: #f59e0b;
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
	max-width: 800px;
	margin: 0 auto;
}

.card {
	background: white;
	border-radius: 16px;
	box-shadow: var(--shadow-lg);
	padding: 40px;
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
	gap: 15px;
	margin-bottom: 35px;
	padding-bottom: 25px;
	border-bottom: 2px solid var(--light-2);
}

.card-header i {
	font-size: 32px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.card-header h2 {
	font-size: 28px;
	font-weight: 700;
	color: var(--text-primary);
	margin: 0;
}

/* Task Info Box */
.task-info-box {
	background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, white 100%);
	border-left: 4px solid var(--primary);
	padding: 20px;
	border-radius: 12px;
	margin-bottom: 30px;
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.task-info-item {
	display: flex;
	flex-direction: column;
}

.task-info-label {
	font-size: 12px;
	font-weight: 600;
	color: var(--text-secondary);
	text-transform: uppercase;
	letter-spacing: 0.5px;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.task-info-value {
	font-size: 16px;
	font-weight: 600;
	color: var(--text-primary);
	display: flex;
	align-items: center;
	gap: 8px;
}

.task-info-value i {
	color: var(--primary);
	font-size: 18px;
}

/* Form Group */
.form-group {
	margin-bottom: 25px;
}

.form-group label {
	display: block;
	font-size: 15px;
	font-weight: 600;
	color: var(--text-primary);
	margin-bottom: 10px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.form-group label i {
	font-size: 16px;
	color: var(--primary);
}

.form-group label .required {
	color: var(--danger);
	font-weight: 700;
	margin-left: auto;
}

.form-group input, .form-group textarea, .form-group select {
	width: 100%;
	padding: 13px 15px;
	border: 2px solid var(--border);
	border-radius: 10px;
	font-size: 15px;
	font-family: inherit;
	transition: all 0.3s ease;
	background: var(--light);
}

.form-group input:focus, .form-group textarea:focus, .form-group select:focus {
	outline: none;
	border-color: var(--primary);
	background: white;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.form-row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

textarea {
	resize: vertical;
	min-height: 120px;
	font-family: inherit;
}

select {
	cursor: pointer;
	appearance: none;
	background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%234f46e5' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 12px center;
	padding-right: 35px;
}

input[readonly] {
	background: var(--light-2);
	color: var(--text-secondary);
	cursor: not-allowed;
}

/* Button Group */
.button-group {
	display: flex;
	gap: 15px;
	margin-top: 35px;
}

.btn {
	flex: 1;
	padding: 14px 25px;
	border: none;
	border-radius: 10px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	text-decoration: none;
	text-align: center;
}

.update-btn {
	background: linear-gradient(135deg, var(--success), #059669);
	color: white;
	box-shadow: var(--shadow-md);
}

.update-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 20px rgba(16, 185, 129, 0.3);
}

.update-btn:active {
	transform: translateY(0);
}

.cancel-btn {
	background: var(--light-2);
	color: var(--text-primary);
	border: 2px solid var(--border);
}

.cancel-btn:hover {
	background: var(--border);
	border-color: var(--text-secondary);
	transform: translateY(-2px);
}

/* Help Text */
.help-text {
	font-size: 13px;
	color: var(--text-secondary);
	margin-top: 6px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.help-text i {
	color: var(--info);
	font-size: 12px;
}

/* Divider */
.divider {
	height: 1px;
	background: var(--border);
	margin: 30px 0;
}

/* Badge Styles */
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

/* Responsive */
@media (max-width: 768px) {
	.card {
		padding: 25px;
	}

	.form-row {
		grid-template-columns: 1fr;
	}

	.task-info-box {
		grid-template-columns: 1fr;
	}

	.button-group {
		flex-direction: column;
	}

	.btn {
		width: 100%;
	}

	.card-header h2 {
		font-size: 24px;
	}
}

@media (max-width: 480px) {
	body {
		padding: 15px 10px;
	}

	.card {
		padding: 20px;
	}

	.card-header {
		gap: 10px;
	}

	.card-header h2 {
		font-size: 20px;
	}

	.card-header i {
		font-size: 28px;
	}

	.task-info-box {
		gap: 15px;
		padding: 15px;
	}

	.form-group label {
		font-size: 14px;
	}

	.form-group input, .form-group textarea, .form-group select {
		padding: 11px 12px;
	}
}
</style>

</head>
<body>

	<div class="container">

		<div class="card">

			<!-- Card Header -->
			<div class="card-header">
				<i class="fa-solid fa-pen-to-square"></i>
				<h2>Edit Task</h2>
			</div>

			<!-- Task Info Box -->
			<div class="task-info-box">
				<div class="task-info-item">
					<span class="task-info-label">
						<i class="fa-solid fa-tag"></i> Task ID
					</span>
					<span class="task-info-value">
						<%=task.getTaskId()%>
					</span>
				</div>

				<div class="task-info-item">
					<span class="task-info-label">
						<i class="fa-solid fa-user"></i> Employee ID
					</span>
					<span class="task-info-value">
						<%=task.getEmployeeId()%>
					</span>
				</div>

				<div class="task-info-item">
					<span class="task-info-label">
						<i class="fa-solid fa-calendar"></i> Assigned Date
					</span>
					<span class="task-info-value">
						<%=task.getAssignedDate()%>
					</span>
				</div>

				<div class="task-info-item">
					<span class="task-info-label">
						<i class="fa-solid fa-history"></i> Last Updated
					</span>
					<span class="task-info-value">
						<%=task.getAssignedDate()%>
					</span>
				</div>
			</div>

			<!-- Edit Form -->
			<form action="UpdateTaskServlet" method="post">

				<input type="hidden" name="taskId"
					value="<%=task.getTaskId()%>">

				<!-- Task Name -->
				<div class="form-group">
					<label>
						<i class="fa-solid fa-heading"></i> Task Name <span
							class="required">*</span>
					</label>
					<input type="text" name="taskName"
						value="<%=task.getTaskName()%>" placeholder="Enter task name" required>
				</div>

				<!-- Description -->
				<div class="form-group">
					<label>
						<i class="fa-solid fa-align-left"></i> Description <span
							class="required">*</span>
					</label>
					<textarea name="description" placeholder="Enter detailed task description..." required><%=task.getDescription()%></textarea>
				</div>

				<div class="divider"></div>

				<!-- Priority & Status Row -->
				<div class="form-row">

					<!-- Priority -->
					<div class="form-group">
						<label>
							<i class="fa-solid fa-flag"></i> Priority <span
								class="required">*</span>
						</label>
						<select name="priority" required>
							<%
							String currentPriority = task.getPriority().toString();
							%>
							<option value="HIGH"
								<%= "HIGH".equals(currentPriority) ? "selected" : "" %>>
								High
							</option>
							<option value="MEDIUM"
								<%= "MEDIUM".equals(currentPriority) ? "selected" : "" %>>
								Medium
							</option>
							<option value="LOW"
								<%= "LOW".equals(currentPriority) ? "selected" : "" %>>
								Low
							</option>
						</select>
						<p class="help-text">
							<i class="fa-solid fa-circle-info"></i>
							Current:
							<span class="badge badge-priority-<%=currentPriority.toLowerCase()%>">
								<%=currentPriority%>
							</span>
						</p>
					</div>

					<!-- Status -->
					<div class="form-group">
						<label>
							<i class="fa-solid fa-circle-check"></i> Status <span
								class="required">*</span>
						</label>
						<select name="status" required>
							<%
							String currentStatus = task.getStatus().toString();
							%>
							<option value="PENDING"
								<%= "PENDING".equals(currentStatus) ? "selected" : "" %>>
								Pending
							</option>
							<option value="IN_PROGRESS"
								<%= "IN_PROGRESS".equals(currentStatus) ? "selected" : "" %>>
								In Progress
							</option>
							<option value="COMPLETED"
								<%= "COMPLETED".equals(currentStatus) ? "selected" : "" %>>
								Completed
							</option>
						</select>
						<p class="help-text">
							<i class="fa-solid fa-circle-info"></i>
							Current:
							<span class="badge badge-status-<%=currentStatus.toLowerCase().replace("_", "")%>">
								<%=currentStatus%>
							</span>
						</p>
					</div>

				</div>

				<!-- Due Date -->
				<div class="form-group">
					<label>
						<i class="fa-solid fa-hourglass-end"></i> Due Date <span
							class="required">*</span>
					</label>
					<input type="date" name="dueDate"
						value="<%=task.getDueDate()%>" required>
					<p class="help-text">
						<i class="fa-solid fa-circle-info"></i>
						Set the deadline for task completion
					</p>
				</div>

				<div class="divider"></div>

				<!-- Button Group -->
				<div class="button-group">

					<button type="submit" class="btn update-btn">
						<i class="fa-solid fa-floppy-disk"></i> Save Changes
					</button>

					<a href="ViewTasksServlet" class="btn cancel-btn">
						<i class="fa-solid fa-arrow-left"></i> Cancel
					</a>

				</div>

			</form>

		</div>

	</div>

</body>
</html>
