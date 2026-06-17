package com.rakesh.ems.service;

import java.util.List;

import com.rakesh.ems.model.Employee;

public interface EmployeeService {
	

    void addEmployee(Employee employee);

    Employee searchEmployees(int empId);

    List<Employee> viewAllEmployees();

    void updateEmployee(Employee employee);

    void deleteEmployee(int empId);

    boolean employeeExists(int empId);
    
    void generateDashboard();
    
    
}
