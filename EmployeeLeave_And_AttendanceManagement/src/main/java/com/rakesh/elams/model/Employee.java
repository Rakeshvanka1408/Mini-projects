package com.rakesh.elams.model;

public class Employee {
	private int employee_id;
	private String employee_name;
	private String email;
	private long phone;
	private String department;
	private String designation;
	public Employee(int employee_id, String employee_name, String email, long phone, String department,
			String designation) {
		super();
		this.employee_id = employee_id;
		this.employee_name = employee_name;
		this.email = email;
		this.phone = phone;
		this.department = department;
		this.designation = designation;
	}
	public Employee() {
		// TODO Auto-generated constructor stub
	}
	public int getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(int employee_id) {
		this.employee_id = employee_id;
	}
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public long getPhone() {
		return phone;
	}
	public void setPhone(long phone) {
		this.phone = phone;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	@Override
	public String toString() {
		return "Employee [employee_id=" + employee_id + ", employee_name=" + employee_name + ", email=" + email
				+ ", phone=" + phone + ", department=" + department + ", designation=" + designation + "]";
	}
	
}
