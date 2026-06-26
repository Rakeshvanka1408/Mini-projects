<%@ page language="java"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Mark Attendance</title>
</head>

<body>

	<h2>Mark Attendance</h2>

	<form action="markAttendance" method="post">

		Employee ID : <input type="number" name="employeeId" required>

		<br>
		<br> Date : <input type="date" name="attendanceDate" required>

		<br>
		<br> Check In : <input type="time" name="checkIn" required>

		<br>
		<br> Check Out : <input type="time" name="checkOut" required>

		<br>
		<br> Status : <select name="status">

			<option value="Present">Present</option>

			<option value="Absent">Absent</option>

			<option value="Half Day">Half Day</option>

		</select> <br>
		<br> <input type="submit" value="Mark Attendance">

	</form>

</body>
</html>