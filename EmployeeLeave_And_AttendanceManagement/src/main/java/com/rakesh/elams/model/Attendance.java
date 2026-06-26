package com.rakesh.elams.model;

import java.sql.Date;
import java.sql.Time;

public class Attendance {
		private int attendance_id;
		private Date attendance_date;
		private Time check_in_time;
		private Time check_out_time;
		private String status;
		private int employee_id;
		public Attendance() {
			
		}
		public Attendance(int attendance_id, Date attendance_date, Time check_in_time, Time check_out_time,
				String status,int employee_id) {	
			super();
			this.attendance_id = attendance_id;
			this.attendance_date = attendance_date;
			this.check_in_time = check_in_time;
			this.check_out_time = check_out_time;
			this.status = status;
			this.employee_id = employee_id;
		}
		
		public int getEmployee_id() {
			return employee_id;
		}

		public void setEmployee_id(int employee_id) {
			this.employee_id = employee_id;
		}

		public int getAttendance_id() {
			
			return attendance_id;
		}
		public void setAttendance_id(int attendance_id) {
			this.attendance_id = attendance_id;
		}
		public Date getAttendance_date() {
			return attendance_date;
		}
		public void setAttendance_date(Date attendance_date) {
			this.attendance_date = attendance_date;
		}
		public Time getCheck_in_time() {
			return check_in_time;
		}
		public void setCheck_in_time(Time check_in_time) {
			this.check_in_time = check_in_time;
		}
		public Time getCheck_out_time() {
			return check_out_time;
		}
		public void setCheck_out_time(Time check_out_time) {
			this.check_out_time = check_out_time;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}

		@Override
		public String toString() {
			return "Attendance [attendance_id=" + attendance_id + ", attendance_date=" + attendance_date
					+ ", check_in_time=" + check_in_time + ", check_out_time=" + check_out_time + ", status=" + status
					+ ", employee_id=" + employee_id + "]";
		}
		
		
		
}
