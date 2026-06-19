package com.rakesh.ems.model;

public class Employee {
	private int empId;
    private String empName;
    private Department department;
    private double salary;
    private String email;
    private String technology;
    private int teamSize;
    private String employeeType;

	public Employee(int empId, String empName, Department department ,String email,double salary,String technology,int teamSize, String employeeType){
		this.empId = empId; 
		this.empName = empName;
		this.salary= salary;
		this.email = email;
		this.department = department;
		this.teamSize = teamSize;
		this.technology = technology;
		this.employeeType = employeeType;
	}
	
	
	public String getTechnology() {
		return technology;
	}


	public void setTechnology(String technology) {
		this.technology = technology;
	}


	public int getTeamSize() {
		return teamSize;
	}


	public void setTeamSize(int teamSize) {
		this.teamSize = teamSize;
	}


	public String getEmployeeType() {
		return employeeType;
	}


	public void setEmployeeType(String employeeType) {
		this.employeeType = employeeType;
	}


	public void setEmpId(int empId) {
		this.empId = empId;
	}


	public void setEmpName(String empName) {
		this.empName = empName;
	}


	public void setDepartment(Department department) {
		this.department = department;
	}


	public void setSalary(double salary) {
		this.salary = salary;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public Department getDepartment() {
		return department;
	}
	public String getEmail() {
		return email;
	}
	public int getEmpId() {
		return empId;
	}
	public String getEmpName() {
		return empName;
	}
	public double getSalary() {
		return salary;
	}
	public void display() {
		System.out.println("employee id: "+ empId);
		System.out.println("employee name : "+ empName);
		System.out.println("employee salary: "+ salary);
		System.out.println("employee email address: "+email);
		System.out.println("deparment: "+department);
		System.out.println("technology: "+ technology);
		
	}
	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", department=" + department + ", salary=" + salary
				+ ", email=" + email + ", technology=" + technology + ", teamSize=" + teamSize + ", employeeType="
				+ employeeType + "]";
	}
	

}
