<%@ page language="java"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>
.card {
	border: 1px solid black;
	width: 250px;
	padding: 20px;
	margin: 10px;
	display: inline-block;
	text-align: center;
}
</style>

</head>

<body>

	<h1>Admin Dashboard</h1>

	<div class="card">

		<h3>Total Employees</h3>

		<h2>
			<%=request.getAttribute("employeeCount")%>
		</h2>

	</div>

	<div class="card">

		<h3>Present Today</h3>

		<h2>
			<%=request.getAttribute("presentCount")%>
		</h2>

	</div>

	<div class="card">

		<h3>Absent Today</h3>

		<h2>
			<%=request.getAttribute("absentCount")%>
		</h2>

	</div>

	<div class="card">

		<h3>Pending Leaves</h3>

		<h2>
			<%=request.getAttribute("pendingLeaves")%>
		</h2>

	</div>

	<hr>

	<a href="viewEmployeesServlet">Manage Employees</a>
	<br>
	<br>

	<a href="attendance.jsp"> Mark Attendance </a>

	<br>
	<br>

	<a href="leaveRequests"> Manage Leave Requests </a>

	<br>
	<br>

	<a href="logout"> Logout </a>

</body>
</html>