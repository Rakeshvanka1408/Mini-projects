<%@page import="com.rakesh.elams.dao.TaskDaoImpl"%>
<%@page import="com.rakesh.elams.dao.TaskDao"%>
<%@page import="com.rakesh.elams.model.Task"%>
<%
String role = (String)session.getAttribute("role");

if(role == null || !role.equals("MANAGER")){
    response.sendRedirect("login.jsp");
    return;
}
%>
<%
String taskId = request.getParameter("taskId");

TaskDao dao = new TaskDaoImpl();

Task task = dao.getTaskById(taskId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Task</title>
</head>
<body>

<h2>Edit Task</h2>

<form action="UpdateTaskServlet"
      method="post">

<input type="hidden"
       name="taskId"
       value="<%=task.getTaskId()%>">

Task Name:
<input type="text"
       name="taskName"
       value="<%=task.getTaskName()%>">
<br><br>

Description:
<textarea name="description">
<%=task.getDescription()%>
</textarea>
<br><br>

Priority:
<select name="priority">

<option value="HIGH"
<%=task.getPriority().toString().equals("HIGH") ?
"selected" : ""%>>
High
</option>

<option value="MEDIUM"
<%=task.getPriority().toString().equals("MEDIUM") ?
"selected" : ""%>>
Medium
</option>

<option value="LOW"
<%=task.getPriority().toString().equals("LOW") ?
"selected" : ""%>>
Low
</option>

</select>

<br><br>

Due Date:
<input type="date"
       name="dueDate"
       value="<%=task.getDueDate()%>">

<br><br>

<input type="submit"
       value="Update Task">

</form>

</body>
</html>