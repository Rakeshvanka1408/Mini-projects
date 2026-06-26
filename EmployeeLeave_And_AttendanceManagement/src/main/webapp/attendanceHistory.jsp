<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rakesh.elams.model.Attendance"%>

<html>

<head>
<title>Attendance History</title>
</head>

<body>

	<h2>Attendance History</h2>

	<table border="1">

		<tr>

			<th>ID</th>
			<th>Employee ID</th>
			<th>Date</th>
			<th>Check In</th>
			<th>Check Out</th>
			<th>Status</th>

		</tr>

		<%
		List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");

		if (attendanceList != null) {

			for (Attendance attendance : attendanceList) {
		%>

		<tr>

			<td><%=attendance.getAttendance_id()%></td>

			<td><%=attendance.getEmployee_id()%></td>

			<td><%=attendance.getAttendance_date()%></td>

			<td><%=attendance.getCheck_in_time()%></td>

			<td><%=attendance.getCheck_out_time()%></td>

			<td><%=attendance.getStatus()%></td>

		</tr>

		<%
		}
		}
		%>

	</table>

	<hr>

	<h3>Daily Attendance Report</h3>

	Present :
	<%=request.getAttribute("present") != null ? request.getAttribute("present") : 0%>

	<br> Absent :
	<%=request.getAttribute("absent") != null ? request.getAttribute("absent") : 0%>

	<br> Half Day :
	<%=request.getAttribute("halfDay") != null ? request.getAttribute("halfDay") : 0%>

</body>
</html>