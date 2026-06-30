package com.rakesh.elams.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.Leave;
import com.rakesh.elams.util.DbUtil;

public class LeaveDaoImpl implements LeaveDao {

	@Override
	public boolean applyLeave(Leave leave) {
		String sql = "INSERT INTO leaves(leave_id,employee_id,leave_type,start_date,end_date,reason,status) VALUES(?,?,?,?,?,?,?)";
		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, leave.getLeaveId());
			ps.setInt(2, leave.getEmployeeId());
			ps.setString(3, leave.getLeaveType());
			ps.setDate(4, leave.getStartDate());
			ps.setDate(5, leave.getEndDate());
			ps.setString(6, leave.getReason());
			ps.setString(7, leave.getStatus());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateLeaveStatus(int leaveId, String status) {
		String sql = "UPDATE leaves SET status=? WHERE leave_id=?";
		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, leaveId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean cancelLeave(int leaveId) {
		String sql = "DELETE FROM leaves WHERE leave_id=?";
		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, leaveId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Leave getLeaveById(int leaveId) {
		Leave leave = null;
		String sql = "SELECT * FROM leaves WHERE leave_id=?";
		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, leaveId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				leave = new Leave();
				leave.setLeaveId(rs.getInt("leave_id"));
				leave.setEmployeeId(rs.getInt("employee_id"));
				leave.setLeaveType(rs.getString("leave_type"));
				leave.setStartdate(rs.getDate("start_date"));
				leave.setEndDate(rs.getDate("end_date"));
				leave.setReason(rs.getString("reason"));
				leave.setStatus(rs.getString("status"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leave;
	}

	@Override
	public List<Leave> getLeavesByEmployee(int employeeId) {
		List<Leave> leaves = new ArrayList<>();
		String sql = "SELECT * FROM leaves WHERE employee_id=? ORDER BY start_date DESC";
		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, employeeId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Leave leave = new Leave();
				leave.setLeaveId(rs.getInt("leave_id"));
				leave.setEmployeeId(rs.getInt("employee_id"));
				leave.setLeaveType(rs.getString("leave_type"));
				leave.setStartdate(rs.getDate("start_date"));
				leave.setEndDate(rs.getDate("end_date"));
				leave.setReason(rs.getString("reason"));
				leave.setStatus(rs.getString("status"));
				leaves.add(leave);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaves;
	}

	@Override
	public List<Leave> getPendingLeaves() {
		return getLeavesByStatus("Pending");

	}

	@Override
	public List<Leave> getApprovedLeaves() {

		return getLeavesByStatus("Approved");
	}

	@Override
	public List<Leave> getRejectedLeaves() {
		return getLeavesByStatus("Rejected");

	}

	@Override
	public List<Leave> getAllLeaves() {
		List<Leave> leaves = new ArrayList<>();
		String sql = "SELECT * FROM leaves ORDER BY start_date DESC";
		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Leave leave = new Leave();
				leave.setLeaveId(rs.getInt("leave_id"));
				leave.setEmployeeId(rs.getInt("employee_id"));
				leave.setLeaveType(rs.getString("leave_type"));
				leave.setStartdate(rs.getDate("start_date"));
				leave.setEndDate(rs.getDate("end_date"));
				leave.setReason(rs.getString("reason"));
				leave.setStatus(rs.getString("status"));
				leaves.add(leave);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaves;
	}

	private List<Leave> getLeavesByStatus(String status) {
		List<Leave> leaves = new ArrayList<>();
		String sql = "SELECT * FROM leaves WHERE status=?";
		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, status);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Leave leave = new Leave();
				leave.setLeaveId(rs.getInt("leave_id"));
				leave.setEmployeeId(rs.getInt("employee_id"));
				leave.setLeaveType(rs.getString("leave_type"));
				leave.setStartdate(rs.getDate("start_date"));
				leave.setEndDate(rs.getDate("end_date"));
				leave.setReason(rs.getString("reason"));
				leave.setStatus(rs.getString("status"));
				leaves.add(leave);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaves;
	}

}
