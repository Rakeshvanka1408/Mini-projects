package com.rakesh.elams.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.Employee;
import com.rakesh.elams.util.DbUtil;

public class EmployeeDaoImpl implements EmployeeDao {
	public void addEmployee(Employee employee) {

		String sql = "INSERT INTO employees(employee_id,employee_name,email,phone,department,designation) VALUES(?,?,?,?,?,?)";

		try {
			Connection connection = DbUtil.getConnection();
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, employee.getEmployee_id());
			ps.setString(2, employee.getEmployee_name());
			ps.setString(3, employee.getEmail());
			ps.setLong(4, employee.getPhone());
			ps.setString(5, employee.getDepartment());
			;
			ps.setString(6, employee.getDesignation());
			int count = ps.executeUpdate();
			if (count > 0) {
				System.out.println(count + ":user added sucessfully");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public Employee getEmployeeById(int id) {

		Employee emp = null;

		String sql = "SELECT * FROM employees WHERE employee_id=?";

		try (Connection connection = DbUtil.getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				emp = new Employee(rs.getInt("employee_id"), rs.getString("employee_name"), rs.getString("email"),
						rs.getLong("phone"), rs.getString("department"), rs.getString("designation"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return emp;
	}

	public List<Employee> getAllEmployees() {
		ArrayList<Employee> list = new ArrayList<>();
		Employee emp = null;
		String sql = "select * from employees";
		;
		try {
			Connection connection = DbUtil.getConnection();
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				emp = new Employee(rs.getInt("employee_id"), rs.getString("employee_name"), rs.getString("email"),
						rs.getLong("phone"), rs.getString("department"), rs.getString("designation"));
				list.add(emp);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;

	}

	public boolean updateEmployee(Employee employee) {

		String sql = "UPDATE employees SET employee_name=?, email=?, phone=?, department=?, designation=? WHERE employee_id=?";

		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, employee.getEmployee_name());
			ps.setString(2, employee.getEmail());
			ps.setLong(3, employee.getPhone());
			ps.setString(4, employee.getDepartment());
			ps.setString(5, employee.getDesignation());
			ps.setInt(6, employee.getEmployee_id());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public boolean deleteEmployee(int id) {

		try (Connection con = DbUtil.getConnection();
				PreparedStatement ps = con.prepareStatement("DELETE FROM employees WHERE employee_id=?")) {

			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
}
