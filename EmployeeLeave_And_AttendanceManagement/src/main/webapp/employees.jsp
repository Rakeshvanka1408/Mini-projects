<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rakesh.elams.model.Employee"%>

<html>
<head>
<title>Employees</title>
</head>

<body>

	<h2>Employee List</h2>

	<a href="addEmployee.jsp"> Add Employee </a>

	<br>
	<br>

	<table border="1">

		<tr>

			<th>ID</th>
			<th>Name</th>
			<th>Email</th>
			<th>Phone</th>
			<th>Department</th>
			<th>Designation</th>
			<th>Action</th>

		</tr>

		<%
		List<Employee> employees = (List<Employee>) request.getAttribute("employees");

		for (Employee emp : employees) {
		%>

		<tr>

			<td><%=emp.getEmployee_id()%></td>
			<td><%=emp.getEmployee_name()%></td>
			<td><%=emp.getEmail()%></td>
			<td><%=emp.getPhone()%></td>
			<td><%=emp.getDepartment()%></td>
			<td><%=emp.getDesignation()%></td>

			<td><a href="deleteEmployee?id=<%=emp.getEmployee_id()%>">
					Delete </a></td>

		</tr>

		<%
		}
		%>

	</table>

</body>
</html>