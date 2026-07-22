<%@page import="com.rakesh.elams.dao.AttendanceDaoImpl"%>
<%@page import="com.rakesh.elams.model.Attendance"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");

if (role == null ||
   (!role.equalsIgnoreCase("EMPLOYEE")
    && !role.equalsIgnoreCase("ADMIN")
    && !role.equalsIgnoreCase("MANAGER"))) {

    response.sendRedirect("login.jsp");
    return;
}

Integer employeeId = (Integer) session.getAttribute("employeeId");

AttendanceDaoImpl attendanceDao = new AttendanceDaoImpl();

Attendance todayAttendance = null;

if(employeeId != null){
	todayAttendance = attendanceDao.getTodayAttendance(employeeId);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Attendance - ELAMS</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

*{
	margin:0;
	padding:0;
	box-sizing:border-box;
	font-family:'Segoe UI',sans-serif;
}

body{
	background:#f4f6f9;
	padding:40px;
}

.container{
	max-width:700px;
	margin:auto;
}

.card{
	background:white;
	border-radius:20px;
	padding:40px;
	box-shadow:0 8px 25px rgba(0,0,0,0.08);
	text-align:center;
}

.title{
	font-size:32px;
	font-weight:700;
	margin-bottom:10px;
	color:#333;
}

.subtitle{
	color:#777;
	margin-bottom:30px;
}

.clock{
	font-size:42px;
	font-weight:bold;
	color:#4f46e5;
	margin:20px 0;
}

.date{
	font-size:18px;
	color:#666;
	margin-bottom:30px;
}

.info{
	background:#f8fafc;
	padding:20px;
	border-radius:15px;
	margin-bottom:25px;
	text-align:left;
}

.info p{
	margin:12px 0;
	font-size:17px;
}

.status{
	display:inline-block;
	padding:8px 18px;
	border-radius:20px;
	font-weight:bold;
	color:white;
}

.present{
	background:#10b981;
}

.late{
	background:#f59e0b;
}

.completed{
	background:#3b82f6;
}

.btn{
	padding:15px 30px;
	border:none;
	border-radius:12px;
	font-size:16px;
	font-weight:600;
	cursor:pointer;
	color:white;
}

.checkin{
	background:#10b981;
}

.checkout{
	background:#ef4444;
}

.checkin:hover,
.checkout:hover{
	opacity:0.9;
}

.success-box{
	background:#d1fae5;
	color:#065f46;
	padding:15px;
	border-radius:12px;
	margin-top:20px;
	font-weight:600;
}

</style>
</head>

<body>

<div class="container">

	<div class="card">

		<div class="title">
			<i class="fa-solid fa-calendar-check"></i>
			Attendance
		</div>

		<div class="subtitle">
			Employee Leave And Attendance Management System
		</div>

		<div class="clock" id="clock"></div>

		<div class="date" id="todayDate"></div>

		<%
		if(todayAttendance == null){
		%>

			<div class="info">
				<p><strong>Status :</strong> Not Checked In</p>
			</div>

			<form action="markAttendance" method="post">

				<button class="btn checkin"
						type="submit"
						name="action"
						value="checkin">

					<i class="fa-solid fa-right-to-bracket"></i>
					Check In

				</button>

			</form>

		<%
		}
		else if(todayAttendance.getCheck_out_time() == null){
		%>

			<div class="info">

				<p>
					<strong>Check In Time :</strong>
					<%=todayAttendance.getCheck_in_time()%>
				</p>

				<p>
					<strong>Status :</strong>

					<span class="status
					<%= "LATE".equalsIgnoreCase(todayAttendance.getStatus())
							? "late"
							: "present"%>">

						<%=todayAttendance.getStatus()%>

					</span>
				</p>

			</div>

			<form action="markAttendance" method="post">

				<button class="btn checkout"
						type="submit"
						name="action"
						value="checkout">

					<i class="fa-solid fa-right-from-bracket"></i>
					Check Out

				</button>

			</form>

		<%
		}
		else{
		%>

			<div class="info">

				<p>
					<strong>Check In Time :</strong>
					<%=todayAttendance.getCheck_in_time()%>
				</p>

				<p>
					<strong>Check Out Time :</strong>
					<%=todayAttendance.getCheck_out_time()%>
				</p>

				<p>
					<strong>Status :</strong>

					<span class="status completed">
						Completed
					</span>
				</p>

			</div>

			<div class="success-box">
				Attendance completed for today.
			</div>

		<%
		}
		%>

	</div>

</div>

<script>

function updateClock(){

	const now = new Date();

	document.getElementById("clock").innerHTML =
		now.toLocaleTimeString('en-IN');

	document.getElementById("todayDate").innerHTML =
		now.toDateString();
}

updateClock();

setInterval(updateClock,1000);

</script>

</body>
</html>