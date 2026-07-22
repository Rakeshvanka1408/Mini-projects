package com.rakesh.elams.model;

import java.sql.Date;

public class Task {

	private String taskId;
	private String taskName;
	private String description;
	private int employeeId;
	private int managerId;
	private Priority priority;
	private Status status;
	private Date assignedDate;
	private Date dueDate;
	private Date completionDate;
	private String documentPath;

	
	public Task() {
	}

	public enum Status {

		PENDING, IN_PROGRESS, COMPLETED

	}

	public enum Priority {

		HIGH, MEDIUM, LOW

	}

	public Task(String taskId, String taskName, String description, int employeeId, int managerId,
			Priority priority, Status status, Date assignedDate, Date dueDate, Date completionDate) {

		this.taskId = taskId;
		this.taskName = taskName;
		this.description = description;
		this.employeeId = employeeId;
		this.managerId = managerId;
		this.priority = priority;
		this.status = status;
		this.assignedDate = assignedDate;
		this.dueDate = dueDate;
		this.completionDate = completionDate;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public int getManagerId() {
		return managerId;
	}

	public void setManagerId(int managerId) {
		this.managerId = managerId;
	}

	public Priority getPriority() {
		return priority;
	}

	public void setPriority(Priority priority) {
		this.priority = priority;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public Date getAssignedDate() {
		return assignedDate;
	}

	public void setAssignedDate(Date assignedDate) {
		this.assignedDate = assignedDate;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	public Date getCompletionDate() {
		return completionDate;
	}

	public void setCompletionDate(Date completionDate) {
		this.completionDate = completionDate;
	}
	public String getDocumentPath() {
	    return documentPath;
	}

	public void setDocumentPath(String documentPath) {
	    this.documentPath = documentPath;
	}

}