package com.rakesh.ems;

import java.util.List;
import java.util.Scanner;

import com.rakesh.ems.model.Department;
import com.rakesh.ems.model.Employee;
import com.rakesh.ems.service.EmployeeService;
import com.rakesh.ems.service.EmployeeServiceImpl;

public class MainApp {
	private static EmployeeService service = new EmployeeServiceImpl();
	private static Scanner sc = new Scanner(System.in);

	public static void main(String[] args) {

		boolean login = login();
		if (!login) {
			System.err.println("invalid login credentials please re-enter correctly");
			return;
		}
		System.out.println("Available Departments:");
		for (Department d : Department.values()) {
		    System.out.println(d);
		}
		System.out.println();
		boolean b = true;
		while (b) {
			System.out.println("========= EMPLOYEE MANAGEMENT SYSTEM ==========");
			System.out.println("1. Add Employee");
			System.out.println("2. View Employees");
			System.out.println("3. Search Employee");
			System.out.println("4. Update Employee");
			System.out.println("5. Delete Employee");
			System.out.println("6. Dashboard");
			System.out.println("7. Save Employees To File");
			System.out.println("8. Read Employees From File");
			System.out.println("9. Exit");
			System.out.print("Enter Choice : ");
			int choice = sc.nextInt();

			switch (choice) {
			case 1:
				addEmployee();
				break;
			case 2:
				viewEmployees();
				break;
			case 3:
				searchEmployee();
				break;
			case 4:
				updateEmployee();
				break;
			case 5:
				deleteEmployee();
				break;
			case 6:
				service.generateDashboard();
				break;
			case 9:
				b = false;
				System.out.println("application execution terminated ");
				break;

			}
		}
	}

	public static void addEmployee() {
		System.out.println("enter the empId: ");
		int empId = sc.nextInt();
		sc.nextLine();
		System.out.println("enter the empName: ");
		String empName = sc.nextLine();
		System.out.println("enter the department(IT,HR,SALES,FINANCE): ");
		Department dName = Department.valueOf(sc.nextLine().toUpperCase());
		System.out.println("enter the salary: ");
		double salary = sc.nextDouble();
		sc.nextLine();
		System.out.println("enter the email address: ");
		String email = sc.nextLine();

		Employee employee = new Employee(empId, empName, dName, email, salary);
		service.addEmployee(employee);
	}

	public static void viewEmployees() {
		List<Employee> viewAllEmployees = service.viewAllEmployees();
		while (!viewAllEmployees.isEmpty()) {
			for (Employee emps : viewAllEmployees) {
				System.out.println(emps.getEmpId());
				System.out.println(emps.getEmpName());
				System.out.println(emps.getDepartment().name());
				System.out.println(emps.getEmail());
				System.out.println(emps.getSalary());

			}
		}
	}

	public static void searchEmployee() {
		System.out.println("enter empId of the employee to search ");
		int empId = sc.nextInt();
		Employee employees = service.searchEmployees(empId);
		if(employees !=null) {
			System.out.println(employees);
		}

	}

	public static void updateEmployee() {

		System.out.println("enter the empId: ");
		int empId = sc.nextInt();
		sc.nextLine();
		System.out.println("enter the empName: ");
		String empName = sc.nextLine();
		System.out.println("enter the department(IT,HR, SALES,FINANCE): ");
		Department dName = Department.valueOf(sc.next().toUpperCase());
		System.out.println("enter the salary: ");
		double salary = sc.nextDouble();
		System.out.println("enter the email address: ");
		String email = sc.next();

		Employee employee = new Employee(empId, empName, dName, email, salary);
		service.updateEmployee(employee);
	}

	public static void deleteEmployee() {
		System.out.println("enter the empid of employee you want to delete");
		int empId = sc.nextInt();
		service.deleteEmployee(empId);
	}

	private static boolean login() {
		System.out.println("=============USER LOGIN =========");
		System.out.println("enter the user name");
		String userName = sc.nextLine();
		System.out.println("enter the password");
		String pwd = sc.nextLine();

		if (userName.equals("rakesh") && pwd.equals("rakesh@123")) {
			return true;
		}
		return false;
	}
}
