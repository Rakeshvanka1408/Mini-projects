<%@ page import="java.util.List"%>
<%@ page import="com.rakesh.elams.model.Employee"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("MANAGER")) {
	response.sendRedirect("login.jsp");
	return;
}

List<Employee> employees = (List<Employee>) request.getAttribute("employees");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employees List</title>
</head>
<body>

	<h2>Employees List</h2>

	<table border="1">
		<tr>
			<th>Employee ID</th>
			<th>Name</th>
			<th>Email</th>
			<th>Phone</th>
			<th>Department</th>
			<th>Designation</th>
		</tr>

		<%
		for (Employee emp : employees) {
		%>

		<tr>
			<td><%=emp.getEmployee_id()%></td>
			<td><%=emp.getEmployee_name()%></td>
			<td><%=emp.getEmail()%></td>
			<td><%=emp.getPhone()%></td>
			<td><%=emp.getDepartment()%></td>
			<td><%=emp.getDesignation()%></td>
		</tr>

		<%
		}
		%>

	</table>

</body>
</html>