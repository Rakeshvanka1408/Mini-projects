package com.rakesh.ems.dao;

import java.util.List;
import com.rakesh.ems.model.Employee;

public interface EmployeeDAO {

    void addEmployee(Employee employee);

    Employee getEmployeeById(int empId);

    List<Employee> getAllEmployees();

    void updateEmployee(Employee employee);

    void deleteEmployee(int empId);

    boolean employeeExists(int empId);
}