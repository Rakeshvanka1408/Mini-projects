<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
<title>Create Task</title>
</head>
<body>

<h2>Create New Task</h2>

<form action="CreateTaskServlet" method="post">

    Task ID:
    <input type="text" name="taskId" required><br><br>

    Task Name:
    <input type="text" name="taskName" required><br><br>

    Description:
    <textarea name="description" rows="4" cols="40"></textarea>
    <br><br>

    Employee ID:
    <input type="number" name="employeeId" required><br><br>

   
    Priority:
    <select name="priority">
        <option value="HIGH">High</option>
        <option value="MEDIUM">Medium</option>
        <option value="LOW">Low</option>
    </select>
    <br><br>

    Due Date:
    <input type="date" name="dueDate" required><br><br>

    <input type="submit" value="Create Task">

</form>

</body>
</html>