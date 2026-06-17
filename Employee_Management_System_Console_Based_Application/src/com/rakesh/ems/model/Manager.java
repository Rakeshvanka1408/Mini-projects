package com.rakesh.ems.model;

public class Manager extends Employee {

	private int teamSize;

	public Manager(int empId, String empName, Department department, double salary, String email, int teamSize) {

		super(empId, empName, department, email, salary);

		this.teamSize = teamSize;
	}

	public int getTeamSize() {
		return teamSize;
	}

	public void displayManagerDetails() {
		super.display();
		System.out.println("team size is: " + teamSize);
	}
}