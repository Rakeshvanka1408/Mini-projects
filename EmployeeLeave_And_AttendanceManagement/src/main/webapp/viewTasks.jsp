<%@page import="java.util.List"%>
<%@page import="com.rakesh.elams.model.Task"%>
<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("MANAGER")) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<%
List<Task> tasks = (List<Task>) request.getAttribute("tasks");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Tasks</title>
</head>
<body>

	<h2>All Tasks</h2>

	<table border="1">

		<tr>
			<th>Task ID</th>
			<th>Task Name</th>
			<th>Employee ID</th>
			<th>Priority</th>
			<th>Status</th>
			<th>Due Date</th>
			<th>Actions</th>
		</tr>

		<%
		if (tasks != null) {
			for (Task task : tasks) {
		%>

		<tr>
			<td><%=task.getTaskId()%></td>
			<td><%=task.getTaskName()%></td>
			<td><%=task.getEmployeeId()%></td>
			<td><%=task.getPriority()%></td>
			<td><%=task.getStatus()%></td>
			<td><%=task.getDueDate()%></td>

			<td><a href="editTask.jsp?taskId=<%=task.getTaskId()%>">
					Edit </a> | <a href="DeleteTaskServlet?taskId=<%=task.getTaskId()%>"
				onclick="return confirm('Delete Task?')"> Delete </a></td>
		</tr>

		<%
		}
		}
		%>

	</table>
	<h2>Search Tasks</h2>

	<form action="SearchTaskServlet" method="get">

		Task ID: <input type="text" name="taskId"> Employee ID: <input
			type="number" name="employeeId"> Status: <select
			name="status">
			<option value="">All</option>
			<option value="PENDING">Pending</option>
			<option value="IN_PROGRESS">In Progress</option>
			<option value="COMPLETED">Completed</option>
		</select> Priority: <select name="priority">
			<option value="">All</option>
			<option value="HIGH">High</option>
			<option value="MEDIUM">Medium</option>
			<option value="LOW">Low</option>
		</select> <input type="submit" value="Search"> <a
			href="ViewTasksServlet"> Reset </a>

	</form>

	<hr>
	<form action="SearchTaskServlet" method="get">

		Task ID: <input type="text" name="taskId"> Employee ID: <input
			type="text" name="employeeId"> Status: <select name="status">
			<option value="">Select</option>
			<option value="PENDING">Pending</option>
			<option value="IN_PROGRESS">In Progress</option>
			<option value="COMPLETED">Completed</option>
		</select> <input type="submit" value="Search">

	</form>
</body>
</html>