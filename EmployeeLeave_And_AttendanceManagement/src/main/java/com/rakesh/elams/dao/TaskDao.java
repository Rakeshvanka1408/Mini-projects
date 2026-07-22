package com.rakesh.elams.dao;

import java.util.List;
import com.rakesh.elams.model.Task;

public interface TaskDao {

	boolean createTask(Task task);

	boolean updateTask(Task task);

	boolean deleteTask(String taskId);

	Task getTaskById(String taskId);

	List<Task> getAllTasks();

	List<Task> getTasksByEmployee(int employeeId);

	List<Task> getTasksByStatus(String status);

	List<Task> searchTasks(int managerId, String taskId, Integer employeeId, String status, String priority);
	boolean updateTaskStatus(String taskId, String status);

	List<Task> getTasksByManager(int managerId);
	

	int getTotalTasks(int managerId);

	int getCompletedTasks(int managerId);

	int getPendingTasks(int managerId);

	int getInProgressTasks(int managerId);

	int getOverdueTasks(int managerId);

}