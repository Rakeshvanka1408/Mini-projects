package com.rakesh.elams.dao;

import java.util.List;

import com.rakesh.elams.model.Leave;

public interface LeaveDao {
	boolean applyLeave(Leave leave);

	boolean updateLeaveStatus(
	        int leaveId,
	        String status);

	boolean cancelLeave(int leaveId);

	Leave getLeaveById(int leaveId);

	List<Leave> getLeavesByEmployee(
	        int employeeId);

	List<Leave> getPendingLeaves();

	List<Leave> getApprovedLeaves();

	List<Leave> getRejectedLeaves();

	List<Leave> getAllLeaves();
}
