package com.rakesh.elams.model;

public class User {
	private int id;
	private String email;
	private String pwd;
	private String role;
	private int employeeId;
	private String name;
	public User(int id, String email, String pwd, String role) {
		super();
		this.id = id;
		this.email = email;
		this.pwd = pwd;
		this.role = role;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public User() {
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	public int getEmployeeId() {
	    return employeeId;
	}

	public void setEmployeeId(int employeeId) {
	    this.employeeId = employeeId;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", email=" + email + ", pwd=" + pwd + ", role=" + role + "]";
	}
	
}
