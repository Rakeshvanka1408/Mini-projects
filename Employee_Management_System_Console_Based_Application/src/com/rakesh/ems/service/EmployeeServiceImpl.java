package com.rakesh.ems.service;

import java.util.ArrayList;
import java.util.List;

import com.rakesh.ems.dao.EmployeeDAO;
import com.rakesh.ems.dao.EmployeeDAOImpl;
import com.rakesh.ems.exceptions.DuplicateEmployeeException;
import com.rakesh.ems.exceptions.EmployeeNotFoundException;
import com.rakesh.ems.exceptions.InvalidSalaryException;
import com.rakesh.ems.model.Employee;
import com.rakesh.ems.util.ValidationUtil;

public class EmployeeServiceImpl implements EmployeeService {

	private EmployeeDAO dao = new EmployeeDAOImpl();

	@Override
	public void addEmployee(Employee employee) {

		try {
			if (!ValidationUtil.isSalaryValid(employee.getSalary())) {
				throw new InvalidSalaryException("salary must be greater than 10k");
			}
			if (!ValidationUtil.isEmailValid(employee.getEmail())) {
				throw new Exception("Emial address is invalid ");
			}
			if (dao.employeeExists(employee.getEmpId())) {
				throw new DuplicateEmployeeException("Employee alredy exists in the database");
			}
			dao.addEmployee(employee);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Employee searchEmployees(int empId) {

		Employee employeeById = dao.getEmployeeById(empId);
		try {
			if (employeeById == null) {
				throw new EmployeeNotFoundException("employee not found");
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return employeeById;
	}

	@Override
	public List<Employee> viewAllEmployees() {
		
		List<Employee> allEmployees = dao.getAllEmployees();

		return allEmployees;
	}

	@Override
	public void updateEmployee(Employee employee) {
		try {
			if(dao.employeeExists(employee.getEmpId())) {
				
			}
		}
		catch(Exception e) {
			
		}

	}

	@Override
	public void deleteEmployee(int empId) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean employeeExists(int empId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void generateDashboard() {
		// TODO Auto-generated method stub

	}

}
