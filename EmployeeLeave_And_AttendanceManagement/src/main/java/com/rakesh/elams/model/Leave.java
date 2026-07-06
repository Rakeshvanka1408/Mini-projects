package com.rakesh.elams.model;

import java.sql.Date;

public class Leave {
	private int leave_id;
	private String leave_type;
	private Date Start_date;
	private Date end_date;
	private String reason;
	private String status;
	private int employee_id;
	private String employeeName;

	public Leave() {

	}

	public Leave(int leave_id, String leave_type, Date start_date, Date end_date, String reason, String status,
			int employee_id) {
		super();
		this.leave_id = leave_id;
		this.leave_type = leave_type;
		Start_date = start_date;
		this.end_date = end_date;
		this.reason = reason;
		this.status = status;
		this.employee_id = employee_id;
	}

	public int getEmployeeId() {
		return employee_id;
	}

	public void setEmployeeId(int employee_id) {
		this.employee_id = employee_id;
	}

	public int getLeaveId() {
		return leave_id;
	}

	public void setLeaveId(int leave_id) {
		this.leave_id = leave_id;
	}

	public String getLeaveType() {
		return leave_type;
	}

	public void setLeaveType(String leave_type) {
		this.leave_type = leave_type;
	}

	public Date getStartDate() {
		return Start_date;
	}

	public void setStartdate(Date start_date) {
		Start_date = start_date;
	}

	public Date getEndDate() {
		return end_date;
	}

	public void setEndDate(Date end_date) {
		this.end_date = end_date;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	@Override
	public String toString() {
		return "Leave [leave_id=" + leave_id + ", leave_type=" + leave_type + ", Start_date=" + Start_date
				+ ", end_date=" + end_date + ", reason=" + reason + ", status=" + status + ", employee_id="
				+ employee_id + "]";
	}

}
