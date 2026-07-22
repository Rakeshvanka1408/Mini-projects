package com.rakesh.elams.dao;

import java.util.List;

import com.rakesh.elams.model.Employee;

public interface EmployeeDao {
	public void addEmployee(Employee employee);
	public Employee getEmployeeById(int id );
	public List<Employee> getAllEmployees();
	 public boolean updateEmployee(Employee employee);
	 public boolean deleteEmployee(int id);
	 List<Employee> getEmployeesByManager(int managerId);
	 List<Employee> getAllManagers();
}
