package com.rakesh.ems.service;

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
			if (!dao.employeeExists(employee.getEmpId())) {
				throw new EmployeeNotFoundException("There is no emplolyee with the give details to update");
			}
			dao.updateEmployee(employee);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

	}

	@Override
	public void deleteEmployee(int empId) {
		try {
			if(!dao.employeeExists(empId) ){
				throw new EmployeeNotFoundException("There is no emplolyee with the give details to update");
			}
			dao.deleteEmployee(empId);
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}

	}

	@Override
	public boolean employeeExists(int empId) {
		try {
			if (!dao.employeeExists(empId)) {
				throw new EmployeeNotFoundException("There is no emplolyee with the give details to update");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return true;
	}

	@Override
	public void generateDashboard() {
		List<Employee> allEmployees = dao.getAllEmployees();
		int totalEmployees = allEmployees.size();
		double highestSal = allEmployees.stream().mapToDouble(Employee::getSalary).max().orElse(0);
		double lowestSal = allEmployees.stream().mapToDouble(Employee::getSalary).min().orElse(0);
		double avgSal = allEmployees.stream().mapToDouble(Employee::getSalary).average().orElse(lowestSal);
		System.out.println("-----------------------------------");
		System.out.println("Employee Dashboard");
		System.out.println("totla employees: "+ totalEmployees);
		System.out.println("highest salary: "+ highestSal);
		System.out.println("lowestSal: "+ lowestSal);
		System.out.println("average salary: "+avgSal);
		System.out.println("-----------------------------------");

	}

}
