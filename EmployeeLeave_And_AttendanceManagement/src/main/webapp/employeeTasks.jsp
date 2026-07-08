<%@page import="java.util.List"%>
<%@page import="com.rakesh.elams.model.Task"%>
<%
String role = (String)session.getAttribute("role");

if(role == null || !role.equals("EMPLOYEE")){
    response.sendRedirect("login.jsp");
    return;
}
%>
<%
List<Task> tasks =
        (List<Task>)request.getAttribute("tasks");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Tasks</title>
</head>
<body>

<h2>Assigned Tasks</h2>

<table border="1">

<tr>
    <th>Task ID</th>
    <th>Task Name</th>
    <th>Description</th>
    <th>Priority</th>
    <th>Status</th>
    <th>Due Date</th>
    <th>Update Status</th>
</tr>

<%
if(tasks != null){
for(Task task : tasks){
%>

<tr>

<td><%=task.getTaskId()%></td>
<td><%=task.getTaskName()%></td>
<td><%=task.getDescription()%></td>
<td><%=task.getPriority()%></td>
<td><%=task.getStatus()%></td>
<td><%=task.getDueDate()%></td>

<td>

<form action="UpdateTaskStatusServlet"
      method="post">

    <input type="hidden"
           name="taskId"
           value="<%=task.getTaskId()%>">

    <select name="status">

        <option value="PENDING">
            Pending
        </option>

        <option value="IN_PROGRESS">
            In Progress
        </option>

        <option value="COMPLETED">
            Completed
        </option>

    </select>

    <input type="submit"
           value="Update">

</form>

</td>

</tr>

<%
}
}
%>

</table>

</body>
</html>