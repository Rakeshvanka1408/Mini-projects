package com.rakesh.ems.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.ems.model.Department;
import com.rakesh.ems.model.Employee;
import com.rakesh.ems.util.DBUtil;

public class EmployeeDAOImpl implements EmployeeDAO {

	@Override
	public void addEmployee(Employee employee) {

		String sql = "INSERT INTO employee_data " + "(emp_id, emp_name, department, salary, email) "
				+ "VALUES (?, ?, ?, ?, ?)";

		try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, employee.getEmpId());
			ps.setString(2, employee.getEmpName());
			ps.setString(3, employee.getDepartment().name());
			ps.setDouble(4, employee.getSalary());
			ps.setString(5, employee.getEmail());

			int rows = ps.executeUpdate();

			if (rows > 0) {
				System.out.println("Employee Added Successfully");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Employee getEmployeeById(int empId) {

		Employee employee = null;

		String sql = "SELECT * FROM employee_data " + "WHERE emp_id = ?";

		try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, empId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				employee = new Employee(rs.getInt("emp_id"), rs.getString("emp_name"),
						Department.valueOf(rs.getString("department")), rs.getString("email"), rs.getDouble("salary"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return employee;
	}

	@Override
	public List<Employee> getAllEmployees() {

		List<Employee> employees = new ArrayList<>();

		String sql = "SELECT * FROM employee_data";

		try (Connection con = DBUtil.getConnection();
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery(sql)) {

			while (rs.next()) {

				Employee employee = new Employee(rs.getInt("emp_id"), rs.getString("emp_name"),
						Department.valueOf(rs.getString("department")), rs.getString("email"), rs.getDouble("salary"));

				employees.add(employee);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return employees;
	}

	@Override
	public void updateEmployee(Employee employee) {

		String sql = "UPDATE employee_data " + "SET emp_name=?, department=?, " + "salary=?, email=? "
				+ "WHERE emp_id=?";

		try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, employee.getEmpName());

			ps.setString(2, employee.getDepartment().name());

			ps.setDouble(3, employee.getSalary());

			ps.setString(4, employee.getEmail());

			ps.setInt(5, employee.getEmpId());

			int rows = ps.executeUpdate();

			if (rows > 0) {
				System.out.println("Employee Updated Successfully");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteEmployee(int empId) {

		String sql = "DELETE FROM employee_data " + "WHERE emp_id=?";

		try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, empId);

			int rows = ps.executeUpdate();

			if (rows > 0) {
				System.out.println("Employee Deleted Successfully");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean employeeExists(int empId) {

		String sql = "SELECT emp_id " + "FROM employee_data " + "WHERE emp_id=?";

		try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, empId);

			ResultSet rs = ps.executeQuery();

			return rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
}