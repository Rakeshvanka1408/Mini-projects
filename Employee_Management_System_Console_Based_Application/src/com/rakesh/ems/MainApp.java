package com
.rakesh.ems;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import com.rakesh.ems.model.Department;
import com.rakesh.ems.model.Employee;
import com.rakesh.ems.service.EmployeeService;
import com.rakesh.ems.service.EmployeeServiceImpl;
import com.rakesh.ems.threads.ReportThread;
import com.rakesh.ems.threads.SaveThread;
import com.rakesh.ems.util.FileUtil;

public class MainApp {
	private static EmployeeService service = new EmployeeServiceImpl();
	private static Scanner sc = new Scanner(System.in);

	public static void main(String[] args) throws Exception {

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
			System.out.println("9. SaveThread");
			System.out.println("10. GenerateReportThread");
			System.out.println("11. Exit");
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
			case 7:
				saveFile();
				break;
			case 8:
				readFile();
				break;
			case 9:
				saveThread();
				break;
			case 10:
				generateReportThread();
				break;
			case 11:
				b = false;
				System.err.println("application execution terminated ");
				break;

			}
		}
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

	public static void addEmployee() {
		System.out.println("enter the empId: ");
		int empId = sc.nextInt();
		sc.nextLine();
		System.out.println("enter the empName: ");
		String empName = sc.nextLine();
		System.out.println("enter the department(IT,HR,SALES,FINANCE): ");
		Department dName = Department.valueOf(sc.next().toUpperCase());
		System.out.println("enter the salary: ");
		double salary = sc.nextDouble();
		sc.nextLine();
		System.out.println("enter the email address: ");
		String email = sc.nextLine();
		System.out.println("enter the technology employee is working in: ");
		String tech = sc.nextLine();
		System.out.println("enter the employee type: ");
		String employeeType = sc.nextLine();
		System.out.println("enter the team size: ");
		int teamSize = sc.nextInt();
		Employee employee = new Employee(empId, empName, dName, email, salary,tech,teamSize,employeeType);
		service.addEmployee(employee);
	}

	public static void viewEmployees() {
		List<Employee> viewAllEmployees = service.viewAllEmployees();
		if (viewAllEmployees.isEmpty()) {
			System.out.println("No employee records found ");
			return;
		}
		int count = 1;
		for (Employee emps : viewAllEmployees) {

			System.out.print(count + "==>  ");
			System.out.print(emps.getEmpId() + " , ");
			System.out.print(emps.getEmpName() + " , ");
			System.out.print(emps.getDepartment().name() + " , ");
			System.out.print(emps.getEmail() + " , ");
			System.out.print(emps.getSalary());
			count++;
			System.out.println();
		}
	}

	public static void searchEmployee() {
		System.out.println("enter empId of the employee to search ");
		int empId = sc.nextInt();
		Employee employees = service.searchEmployees(empId);
		if (employees != null) {
			System.out.println("employee details with emp_id: " + empId);
			System.out.println("ID : " + employees.getEmpId());
			System.out.println("Name : " + employees.getEmpName());
			System.out.println("Department : " + employees.getDepartment());
			System.out.println("Email : " + employees.getEmail());
			System.out.println("Salary : " + employees.getSalary());
			System.out.println("Technology : " + employees.getTechnology());
			System.out.println("Team Size : " + employees.getTeamSize());
			System.out.println("Employee Type : " + employees.getEmployeeType());
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
		sc.nextLine();
		System.out.println("enter the email address: ");
		String email = sc.next();
		System.out.println("enter the technology employee is working in: ");
		String tech = sc.nextLine();
		System.out.println("enter the employee type: ");
		String employeeType = sc.nextLine();
		System.out.println("enter the team size: ");
		int teamSize = sc.nextInt();
		Employee employee = new Employee(empId, empName, dName, email, salary,tech,teamSize,employeeType);
		service.updateEmployee(employee);
	}

	public static void deleteEmployee() {
		System.out.println("enter the empid of employee you want to delete");
		int empId = sc.nextInt();
		service.deleteEmployee(empId);
	}

	public static void saveFile() throws IOException {
		List<Employee> allEmployees = service.viewAllEmployees();
		FileUtil.saveEmployees(allEmployees);

	}

	public static void saveThread() throws InterruptedException {

		List<Employee> viewAllEmployees = service.viewAllEmployees();
		Thread t = new Thread(new SaveThread(viewAllEmployees));
		t.start();
		t.join();
	}

	public static void generateReportThread() throws InterruptedException {
		List<Employee> viewAllEmployees = service.viewAllEmployees();
		Thread t2 = new Thread(new ReportThread(viewAllEmployees));
		t2.start();
		t2.join();
	}

	public static void readFile() throws Exception {
		ArrayList<String> employees = FileUtil.readEmployees();
		for (String emps : employees) {
			System.out.println(emps);
		}
	}

}
