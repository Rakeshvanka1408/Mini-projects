package com.rakesh.elams.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.Employee;
import com.rakesh.elams.util.DbUtil;

public class EmployeeDaoImpl implements EmployeeDao {

	// =========================================================
	// ADD EMPLOYEE
	// =========================================================

	@Override
	public void addEmployee(Employee employee) {

		String sql = "INSERT INTO employees " + "(employee_name, email, phone, department, designation, manager_id) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";

		try (Connection connection = DbUtil.getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, employee.getEmployee_name());

			ps.setString(2, employee.getEmail());

			ps.setLong(3, employee.getPhone());

			ps.setString(4, employee.getDepartment());

			ps.setString(5, employee.getDesignation());

			// Manager ID
			if (employee.getManagerId() != null) {

				ps.setInt(6, employee.getManagerId());

			} else {

				ps.setNull(6, java.sql.Types.INTEGER);
			}

			int count = ps.executeUpdate();

			if (count > 0) {

				System.out.println("Employee added successfully");
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	// =========================================================
	// GET EMPLOYEE BY ID
	// =========================================================
	@Override
	public Employee getEmployeeById(int id) {

	    Employee emp = null;

	    String sql = "SELECT * FROM employees WHERE employee_id=?";

	    try (
	        Connection connection = DbUtil.getConnection();
	        PreparedStatement ps = connection.prepareStatement(sql)
	    ) {

	        ps.setInt(1, id);

	        try (ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {

	                emp = new Employee(
	                    rs.getInt("employee_id"),
	                    rs.getString("employee_name"),
	                    rs.getString("email"),
	                    rs.getLong("phone"),
	                    rs.getString("department"),
	                    rs.getString("designation")
	                );

	                // Get Manager ID
	                emp.setManagerId(
	                    rs.getInt("manager_id")
	                );
	            }
	        }

	    } catch (Exception e) {

	        e.printStackTrace();
	    }

	    return emp;
	}
	// =========================================================
	// GET EMPLOYEES BY MANAGER
	// =========================================================

	@Override
	public List<Employee> getEmployeesByManager(int managerId) {

		List<Employee> employees = new ArrayList<>();

		String sql = "SELECT e.*, " + "m.employee_name AS manager_name " + "FROM employees e "
				+ "LEFT JOIN employees m " + "ON e.manager_id = m.employee_id " + "WHERE e.manager_id = ?";

		try (Connection conn = DbUtil.getConnection();

				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, managerId);

			try (ResultSet rs = ps.executeQuery()) {

				while (rs.next()) {

					Employee emp = new Employee();

					emp.setEmployee_id(rs.getInt("employee_id"));

					emp.setEmployee_name(rs.getString("employee_name"));

					emp.setEmail(rs.getString("email"));

					String phone = rs.getString("phone");

					if (phone != null && !phone.trim().isEmpty()) {

						emp.setPhone(Long.parseLong(phone));
					}

					emp.setDepartment(rs.getString("department"));

					emp.setDesignation(rs.getString("designation"));

					// Manager ID
					emp.setManagerId(rs.getInt("manager_id"));

					// Manager Name
					emp.setManagerName(rs.getString("manager_name"));

					employees.add(emp);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return employees;
	}

	// =========================================================
	// GET ALL EMPLOYEES
	// =========================================================

	@Override
	public List<Employee> getAllEmployees() {

		List<Employee> list = new ArrayList<>();

		String sql = "SELECT e.*, " + "m.employee_name AS manager_name " + "FROM employees e "
				+ "LEFT JOIN employees m " + "ON e.manager_id = m.employee_id " + "ORDER BY e.employee_id";

		try (Connection connection = DbUtil.getConnection();

				PreparedStatement ps = connection.prepareStatement(sql);

				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {

				Employee emp = new Employee();

				emp.setEmployee_id(rs.getInt("employee_id"));

				emp.setEmployee_name(rs.getString("employee_name"));

				emp.setEmail(rs.getString("email"));

				String phone = rs.getString("phone");

				if (phone != null && !phone.trim().isEmpty()) {

					emp.setPhone(Long.parseLong(phone));
				}

				emp.setDepartment(rs.getString("department"));

				emp.setDesignation(rs.getString("designation"));

				// Manager ID
				int managerId = rs.getInt("manager_id");

				if (!rs.wasNull()) {

					emp.setManagerId(managerId);
				}

				// Manager Name
				emp.setManagerName(rs.getString("manager_name"));

				list.add(emp);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return list;
	}

	// =========================================================
	// UPDATE EMPLOYEE
	// =========================================================

	@Override
	public boolean updateEmployee(Employee employee) {

	    String sql =
	        "UPDATE employees SET " +
	        "employee_name=?, " +
	        "email=?, " +
	        "phone=?, " +
	        "department=?, " +
	        "designation=?, " +
	        "manager_id=? " +
	        "WHERE employee_id=?";

	    try (
	        Connection con = DbUtil.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql)
	    ) {

	        ps.setString(
	            1,
	            employee.getEmployee_name()
	        );

	        ps.setString(
	            2,
	            employee.getEmail()
	        );

	        ps.setLong(
	            3,
	            employee.getPhone()
	        );

	        ps.setString(
	            4,
	            employee.getDepartment()
	        );

	        ps.setString(
	            5,
	            employee.getDesignation()
	        );

	        // Manager ID
	        if (employee.getManagerId() != null) {

	            ps.setInt(
	                6,
	                employee.getManagerId()
	            );

	        } else {

	            ps.setNull(
	                6,
	                java.sql.Types.INTEGER
	            );
	        }

	        // Employee ID
	        ps.setInt(
	            7,
	            employee.getEmployee_id()
	        );

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {

	        e.printStackTrace();
	    }

	    return false;
	}

	// =========================================================
	// DELETE EMPLOYEE
	// =========================================================

	@Override
	public boolean deleteEmployee(int id) {

		String sql = "DELETE FROM employees " + "WHERE employee_id=?";

		try (Connection con = DbUtil.getConnection();

				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {

			e.printStackTrace();
		}

		return false;
	}

	// =========================================================
	// GET ALL MANAGERS
	// =========================================================

	@Override
	public List<Employee> getAllManagers() {

		List<Employee> managers = new ArrayList<>();

		String sql = "SELECT e.employee_id, " + "e.employee_name, " + "e.email " + "FROM employees e " + "JOIN user u "
				+ "ON e.email = u.email " + "WHERE UPPER(u.role) = 'MANAGER' " + "ORDER BY e.employee_name";

		try (Connection connection = DbUtil.getConnection();

				PreparedStatement ps = connection.prepareStatement(sql);

				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {

				Employee employee = new Employee();

				employee.setEmployee_id(rs.getInt("employee_id"));

				employee.setEmployee_name(rs.getString("employee_name"));

				employee.setEmail(rs.getString("email"));

				managers.add(employee);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return managers;
	}
}