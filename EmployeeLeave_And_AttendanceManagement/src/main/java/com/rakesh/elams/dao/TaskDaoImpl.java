package com.rakesh.elams.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.Task;
import com.rakesh.elams.model.Task.Priority;
import com.rakesh.elams.model.Task.Status;
import com.rakesh.elams.util.DbUtil;

public class TaskDaoImpl implements TaskDao {

	private Connection conn;

	public TaskDaoImpl() {
		try {
			conn = DbUtil.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean createTask(Task task) {

		String sql = "INSERT INTO tasks " + "(task_id, task_name, description, employee_id, manager_id, "
				+ "priority, status, assigned_date, due_date, completion_date,document_path) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, task.getTaskId());
			ps.setString(2, task.getTaskName());
			ps.setString(3, task.getDescription());
			ps.setInt(4, task.getEmployeeId());
			ps.setInt(5, task.getManagerId());
			ps.setString(6, task.getPriority().name());
			ps.setString(7, task.getStatus().name());
			ps.setDate(8, task.getAssignedDate());
			ps.setDate(9, task.getDueDate());
			ps.setDate(10, task.getCompletionDate());
			ps.setString(11, task.getDocumentPath());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public Task getTaskById(String taskId) {

		String sql = "SELECT * FROM tasks WHERE task_id=?";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, taskId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return extractTask(rs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	@Override
	public List<Task> getAllTasks() {

		List<Task> list = new ArrayList<>();

		try {

			Statement st = conn.createStatement();

			ResultSet rs = st.executeQuery("SELECT * FROM tasks");

			while (rs.next()) {
				list.add(extractTask(rs));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Task> getTasksByEmployee(int employeeId) {

		List<Task> list = new ArrayList<>();

		try {

			PreparedStatement ps = conn.prepareStatement("SELECT * FROM tasks WHERE employee_id=?");

			ps.setInt(1, employeeId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(extractTask(rs));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Task> getTasksByStatus(String status) {

		List<Task> list = new ArrayList<>();

		try {

			PreparedStatement ps = conn.prepareStatement("SELECT * FROM tasks WHERE status=?");

			ps.setString(1, status);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(extractTask(rs));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public boolean updateTask(Task task) {

		String sql = "UPDATE tasks SET task_name=?,description=?,priority=?,due_date=? WHERE task_id=?";

		try {

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, task.getTaskName());
			ps.setString(2, task.getDescription());
			ps.setString(3, task.getPriority().name());
			ps.setDate(4, task.getDueDate());
			ps.setString(5, task.getTaskId());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public boolean updateTaskStatus(String taskId, String status) {

		String sql = "UPDATE tasks " + "SET status=?, " + "completion_date = CASE "
				+ "WHEN ?='COMPLETED' THEN CURDATE() " + "ELSE completion_date " + "END " + "WHERE task_id=?";
		try {

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, status);
			ps.setString(2, status);
			ps.setString(3, taskId);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public boolean deleteTask(String taskId) {

		try {

			PreparedStatement ps = conn.prepareStatement("DELETE FROM tasks WHERE task_id=?");

			ps.setString(1, taskId);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	private Task extractTask(ResultSet rs) throws SQLException {

		Task task = new Task();

		task.setTaskId(rs.getString("task_id"));
		task.setTaskName(rs.getString("task_name"));
		task.setDescription(rs.getString("description"));
		task.setEmployeeId(rs.getInt("employee_id"));
		task.setManagerId(rs.getInt("manager_id"));
		task.setPriority(Priority.valueOf(rs.getString("priority")));

		task.setStatus(Status.valueOf(rs.getString("status")));

		task.setAssignedDate(rs.getDate("assigned_date"));

		task.setDueDate(rs.getDate("due_date"));

		task.setCompletionDate(rs.getDate("completion_date"));

		task.setDocumentPath(rs.getString("document_path"));

		return task;
	}

	@Override
	public int getTotalTasks(int managerId) {

	    String sql =
	            "SELECT COUNT(*) FROM tasks WHERE manager_id=?";

	    try (
	        PreparedStatement ps =
	            conn.prepareStatement(sql)) {

	        ps.setInt(1, managerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}

	@Override
	public List<Task> getTasksByManager(int managerId) {

	    List<Task> tasks = new ArrayList<>();

	    String sql =
	            "SELECT * FROM tasks WHERE manager_id=?";

	    try (PreparedStatement ps =
	            conn.prepareStatement(sql)) {

	        ps.setInt(1, managerId);

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            tasks.add(extractTask(rs));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return tasks;
	}

	@Override
	public int getCompletedTasks(int managerId) {

	    String sql =
	        "SELECT COUNT(*) FROM tasks " +
	        "WHERE manager_id=? AND status='COMPLETED'";

	    try (
	        PreparedStatement ps =
	            conn.prepareStatement(sql)) {

	        ps.setInt(1, managerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}

	@Override
	public int getPendingTasks(int managerId) {

	    String sql =
	        "SELECT COUNT(*) FROM tasks " +
	        "WHERE manager_id=? AND status='PENDING'";

	    try (
	        PreparedStatement ps =
	            conn.prepareStatement(sql)) {

	        ps.setInt(1, managerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}

	@Override
	public int getInProgressTasks(int managerId) {

	    String sql =
	        "SELECT COUNT(*) FROM tasks " +
	        "WHERE manager_id=? AND status='IN_PROGRESS'";

	    try (
	        PreparedStatement ps =
	            conn.prepareStatement(sql)) {

	        ps.setInt(1, managerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}

	@Override
	public int getOverdueTasks(int managerId) {

	    String sql =
	        "SELECT COUNT(*) FROM tasks " +
	        "WHERE manager_id=? " +
	        "AND due_date < CURDATE() " +
	        "AND status!='COMPLETED'";

	    try (
	        PreparedStatement ps =
	            conn.prepareStatement(sql)) {

	        ps.setInt(1, managerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}

	/**
	 * Bug fix: this previously had NO managerId filter at all — its base
	 * query was "SELECT * FROM tasks WHERE 1=1", meaning ANY manager who
	 * used the search box could pull back tasks belonging to every other
	 * manager in the system. It's now scoped with "WHERE manager_id=?"
	 * just like getTasksByManager().
	 */
	@Override
	public List<Task> searchTasks(int managerId, String taskId, Integer employeeId, String status, String priority) {

		List<Task> tasks = new ArrayList<>();

		StringBuilder sql = new StringBuilder("SELECT * FROM tasks WHERE manager_id=? ");

		List<Object> params = new ArrayList<>();
		params.add(managerId);

		if (taskId != null && !taskId.isEmpty()) {
			sql.append("AND task_id=? ");
			params.add(taskId);
		}

		if (employeeId != null) {
			sql.append("AND employee_id=? ");
			params.add(employeeId);
		}

		if (status != null && !status.isEmpty()) {
			sql.append("AND status=? ");
			params.add(status);
		}

		if (priority != null && !priority.isEmpty()) {
			sql.append("AND priority=? ");
			params.add(priority);
		}

		try {

			PreparedStatement ps = conn.prepareStatement(sql.toString());

			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				tasks.add(extractTask(rs));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return tasks;
	}
}