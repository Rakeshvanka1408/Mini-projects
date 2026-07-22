<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.rakesh.elams.model.Employee"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !"MANAGER".equalsIgnoreCase(role)) {
	response.sendRedirect("login.jsp");
	return;
}

Integer managerId = (Integer) session.getAttribute("employeeId");
String managerIdDisplay = (managerId == null) ? "N/A" : String.valueOf(managerId);

java.time.LocalDate today = java.time.LocalDate.now();

List<Employee> employees =
        (List<Employee>) request.getAttribute("employees");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Create Task - ELAMS</title>

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
	max-width: 750px;
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

.form-group {
	margin-bottom: 25px;
}

.form-group label {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 15px;
	font-weight: 600;
	color: var(--text-primary);
	margin-bottom: 10px;
}

.form-group label i {
	font-size: 16px;
	color: var(--primary);
	flex-shrink: 0;
}

.form-group label .label-text {
	display: flex;
	align-items: center;
	gap: 6px;
}

.required {
	color: var(--danger);
	font-weight: 700;
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

.form-group input:focus, .form-group textarea:focus, .form-group select:focus
	{
	outline: none;
	border-color: var(--primary);
	background: white;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.form-group input::placeholder {
	color: var(--text-secondary);
}

.form-row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

textarea {
	resize: vertical;
	min-height: 110px;
	font-family: inherit;
}

input[readonly] {
	background: var(--light-2);
	color: var(--text-secondary);
	cursor: not-allowed;
}

input[type="file"] {
	padding: 20px 15px;
	border: 2px dashed var(--border);
	border-radius: 10px;
	cursor: pointer;
	transition: all 0.3s ease;
}

input[type="file"]:hover {
	border-color: var(--primary);
	background: rgba(99, 102, 241, 0.05);
}

select {
	cursor: pointer;
	appearance: none;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%234f46e5' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 12px center;
	padding-right: 35px;
}

.button-group {
	display: flex;
	gap: 15px;
	margin-top: 35px;
}

.submit-btn, .reset-btn {
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
}

.submit-btn {
	background: linear-gradient(135deg, var(--primary), var(--primary-dark));
	color: white;
	box-shadow: var(--shadow-md);
}

.submit-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 20px rgba(99, 102, 241, 0.3);
}

.submit-btn:active {
	transform: translateY(0);
}

.reset-btn {
	background: var(--light-2);
	color: var(--text-primary);
	border: 2px solid var(--border);
}

.reset-btn:hover {
	background: var(--border);
	border-color: var(--text-secondary);
}

.help-text {
	font-size: 13px;
	color: var(--text-secondary);
	margin-top: 6px;
}

.info-box {
	background: rgba(99, 102, 241, 0.05);
	border-left: 4px solid var(--primary);
	padding: 15px;
	border-radius: 8px;
	margin-bottom: 25px;
	font-size: 14px;
	color: var(--text-primary);
}

.info-box i {
	color: var(--primary);
	margin-right: 10px;
}

@media ( max-width : 768px) {
	.card {
		padding: 25px;
	}
	.form-row {
		grid-template-columns: 1fr;
	}
	.button-group {
		flex-direction: column;
	}
	.submit-btn, .reset-btn {
		width: 100%;
	}
	.card-header h2 {
		font-size: 24px;
	}
}

@media ( max-width : 480px) {
	body {
		padding: 15px 10px;
	}
	.card {
		padding: 20px;
	}
	.card-header h2 {
		font-size: 20px;
	}
}
</style>

</head>
<body>

	<div class="container">

		<div class="card">

			<div class="card-header">
				<i class="fa-solid fa-plus-circle"></i>
				<h2>Create New Task</h2>
			</div>

			<div class="info-box">
				<i class="fa-solid fa-circle-info"></i> Fill in all required fields
				to create a new task for an employee.
			</div>

			<form action="CreateTaskServlet" method="post"
				enctype="multipart/form-data">

				<div class="form-row">
					<div class="form-group">
						<label> <i class="fa-solid fa-tag"></i> <span
							class="label-text">Task ID <span class="required">*</span></span>
						</label> <input type="text" name="taskId" placeholder="e.g., TSK-001"
							required>
					</div>

					<div class="form-group">
						<label> <i class="fa-solid fa-list-check"></i> <span
							class="label-text">Task Name <span class="required">*</span></span>
						</label> <input type="text" name="taskName"
							placeholder="e.g., Data Analysis Report" required>
					</div>
				</div>

				<div class="form-group">
					<label> <i class="fa-solid fa-align-left"></i> <span
						class="label-text">Description <span class="required">*</span></span>
					</label>
					<textarea name="description" required
						placeholder="Provide detailed task description..."></textarea>
				</div>

				<div class="form-group">
					<label> <i class="fa-solid fa-paperclip"></i> <span
						class="label-text">Task Document</span>
					</label> <input type="file" name="taskFile"
						accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.jpg,.jpeg,.png,.zip">
					<p class="help-text">Supported: PDF, DOC, DOCX, PPT, PPTX, XLS,
						XLSX, JPG, PNG, ZIP</p>
				</div>

				<div class="form-row">

    <!-- Employee Dropdown -->
    <div class="form-group">
        <label>
            <i class="fa-solid fa-user"></i>
            <span class="label-text">
                Employee <span class="required">*</span>
            </span>
        </label>

        <select name="employeeId" required>

            <option value="">Select Employee</option>

            <%
            if (employees != null && !employees.isEmpty()) {
                for (Employee emp : employees) {
            %>

            <option value="<%=emp.getEmployee_id()%>">
                EMP-<%=emp.getEmployee_id()%> -
                <%=emp.getEmployee_name()%>
            </option>

            <%
                }
            } else {
            %>

            <option value="">No employees assigned to you</option>

            <%
            }
            %>

        </select>
    </div>

    <!-- Manager -->
    <div class="form-group">
        <label>
            <i class="fa-solid fa-briefcase"></i>
            <span class="label-text">Manager ID</span>
        </label>

        <input type="text"
               value="<%=managerIdDisplay%>"
               readonly>
    </div>

</div>

				<div class="form-row">
					<div class="form-group">
						<label> <i class="fa-solid fa-flag"></i> <span
							class="label-text">Priority <span class="required">*</span></span>
						</label> <select name="priority" required>
							<option value="HIGH">High</option>
							<option value="MEDIUM" selected>Medium</option>
							<option value="LOW">Low</option>
						</select>
					</div>

					<div class="form-group">
						<label> <i class="fa-solid fa-circle-check"></i> <span
							class="label-text">Status <span class="required">*</span></span>
						</label> <select name="status" required>
							<option value="PENDING" selected>Pending</option>
							<option value="IN_PROGRESS">In Progress</option>
							<option value="COMPLETED">Completed</option>
						</select>
					</div>
				</div>

				<div class="form-row">
					<div class="form-group">
						<label> <i class="fa-solid fa-calendar"></i> <span
							class="label-text">Assigned Date</span>
						</label> <input type="date" name="assignedDate" value="<%=today%>"
							readonly>
					</div>

					<div class="form-group">
						<label> <i class="fa-solid fa-hourglass-end"></i> <span
							class="label-text">Due Date <span class="required">*</span></span>
						</label> <input type="date" name="dueDate" min="<%=today%>" required>
					</div>
				</div>

				<div class="button-group">
					<button type="submit" class="submit-btn">
						<i class="fa-solid fa-paper-plane"></i> Create Task
					</button>
					<button type="reset" class="reset-btn">
						<i class="fa-solid fa-redo"></i> Clear Form
					</button>
				</div>

			</form>

		</div>
	</div>

</body>
</html>