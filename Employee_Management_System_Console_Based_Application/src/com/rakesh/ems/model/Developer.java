package com.rakesh.ems.model;

public class Developer extends Employee {

	private String technology;

	public Developer(int empId, String empName, Department department, double salary, String email, String technology) {

		super(empId, empName, department, email, salary);

		this.technology = technology;
	}
	public String getTechnology() {
		return technology;
	}
	public void displayDevDetails() {
		super.display();
		System.out.println("Technology: "+ technology);
	}
}