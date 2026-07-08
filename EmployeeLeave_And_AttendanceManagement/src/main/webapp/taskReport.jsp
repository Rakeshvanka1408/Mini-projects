<%
String role = (String)session.getAttribute("role");

if(role == null || !role.equals("MANAGER")){
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Report</title>
</head>
<body>

<h2>Task Report</h2>

<table border="1">

<tr>
    <th>Total Tasks</th>
    <td><%=request.getAttribute("totalTasks")%></td>
</tr>

<tr>
    <th>Completed Tasks</th>
    <td><%=request.getAttribute("completedTasks")%></td>
</tr>

<tr>
    <th>Pending Tasks</th>
    <td><%=request.getAttribute("pendingTasks")%></td>
</tr>

<tr>
    <th>In Progress Tasks</th>
    <td><%=request.getAttribute("inProgressTasks")%></td>
</tr>

<tr>
    <th>Overdue Tasks</th>
    <td><%=request.getAttribute("overdueTasks")%></td>
</tr>

</table>

</body>
</html>