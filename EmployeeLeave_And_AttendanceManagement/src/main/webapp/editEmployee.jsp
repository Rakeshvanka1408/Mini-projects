<%@ page language="java" %>
<%@ page import="com.rakesh.elams.model.Employee"%>

<%
Employee employee =
(Employee)request.getAttribute(
        "employee");
%>

<html>
<head>
<title>Edit Employee</title>
</head>

<body>

<h2>Edit Employee</h2>

<form action="updateEmployee"
      method="post">

<input type="hidden"
       name="id"
       value="<%=employee.getEmployee_id()%>">

Name :
<input type="text"
       name="name"
       value="<%=employee.getEmployee_name()%>">

<br><br>

Email :
<input type="email"
       name="email"
       value="<%=employee.getEmail()%>">

<br><br>

Phone :
<input type="text"
       name="phone"
       value="<%=employee.getPhone()%>">

<br><br>

Department :
<input type="text"
       name="department"
       value="<%=employee.getDepartment()%>">

<br><br>

Designation :
<input type="text"
       name="designation"
       value="<%=employee.getDesignation()%>">

<br><br>

<input type="submit"
       value="Update">

</form>

</body>
</html>