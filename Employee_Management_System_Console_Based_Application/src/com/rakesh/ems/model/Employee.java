package com.rakesh.ems.model;

public class Employee {
	private int empId;
    private String empName;
    private Department department;
    private double salary;
    private String email;

	public Employee(int empId, String empName, Department department ,String email,double salary){
		this.empId = empId; 
		this.empName = empName;
		this.salary= salary;
		this.email = email;
		this.department = department;
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
	}
	@Override
	public String toString() {
	    return empId + "," +
	           empName + "," +
	           department + "," +
	           email + "," +
	           salary;
	}
}
