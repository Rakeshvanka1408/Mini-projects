<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ELAMS Login</title>

<style>
body {
	font-family: Arial;
	background: #f4f4f4;
}

.container {
	width: 350px;
	margin: 100px auto;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px gray;
}

input {
	width: 100%;
	padding: 10px;
	margin: 8px 0;
}

button {
	width: 100%;
	padding: 10px;
	background: #007bff;
	color: white;
	border: none;
}

.error {
	color: red;
	text-align: center;
}
</style>

</head>

<body>

	<div class="container">

		<h2 align="center">Employee Leave & Attendance Management System
		</h2>

		<form action="login" method="post">

			<label>Email</label> <input type="email" name="email" required>

			<label>Password</label> <input type="password" name="password"
				required>

			<button type="submit">Login</button>

		</form>

		<%
		String error = (String) request.getAttribute("errorMessage");

		if (error != null) {
		%>

		<p class="error">
			<%=error%>
		</p>

		<%
		}
		%>

	</div>

</body>
</html>