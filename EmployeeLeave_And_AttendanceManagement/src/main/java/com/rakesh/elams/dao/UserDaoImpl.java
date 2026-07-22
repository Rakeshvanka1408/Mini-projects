package com.rakesh.elams.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.User;
import com.rakesh.elams.util.DbUtil;
import com.rakesh.elams.util.PasswordUtil;

public class UserDaoImpl implements UserDao {

	/*
	 * ============================================================ ADD USER ONLY
	 * ============================================================
	 *
	 * This method is kept for cases where only a user account needs to be created.
	 *
	 * For employees, use:
	 *
	 * createEmployeeAndUser()
	 *
	 * or
	 *
	 * createUserAndEmployee()
	 *
	 * ============================================================
	 */
	@Override
	public boolean addUser(User user) {

		String sql = "INSERT INTO user(email, password, role) VALUES (?, ?, ?)";

		try (Connection connection = DbUtil.getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, user.getEmail());

			String hashedPassword = PasswordUtil.hashPassword(user.getPwd());

			ps.setString(2, hashedPassword);
			ps.setString(3, user.getRole());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {

			e.printStackTrace();

		}

		return false;
	}

	/*
	 * ============================================================ ADMIN ADD
	 * EMPLOYEE ============================================================
	 *
	 * This method creates:
	 *
	 * 1. employees record 2. user login record
	 *
	 * Both operations happen inside ONE transaction.
	 *
	 * If either operation fails:
	 *
	 * ROLLBACK
	 *
	 * So we never get:
	 *
	 * employees record without user
	 *
	 * or
	 *
	 * user record without employees
	 *
	 * ============================================================
	 */
	@Override
	public boolean createEmployeeAndUser(
	        User user,
	        String employeeName,
	        long phone,
	        String department,
	        String designation,
	        int managerId) {

	    Connection connection = null;

	    String employeeSql =
	            "INSERT INTO employees "
	            + "(employee_name, email, phone, department, designation, manager_id) "
	            + "VALUES (?, ?, ?, ?, ?, ?)";

	    String userSql =
	            "INSERT INTO user "
	            + "(email, password, role) "
	            + "VALUES (?, ?, ?)";

	    try {

	        connection =
	                DbUtil.getConnection();

	        connection.setAutoCommit(false);


	        // =========================================
	        // STEP 1: INSERT EMPLOYEE
	        // =========================================

	        try (
	                PreparedStatement employeePs =
	                        connection.prepareStatement(employeeSql)
	        ) {

	            employeePs.setString(
	                    1,
	                    employeeName
	            );

	            employeePs.setString(
	                    2,
	                    user.getEmail()
	            );

	            employeePs.setLong(
	                    3,
	                    phone
	            );

	            employeePs.setString(
	                    4,
	                    department
	            );

	            employeePs.setString(
	                    5,
	                    designation
	            );

	            // IMPORTANT
	            employeePs.setInt(
	                    6,
	                    managerId
	            );

	            int employeeRows =
	                    employeePs.executeUpdate();

	            if (employeeRows == 0) {

	                connection.rollback();

	                return false;
	            }
	        }


	        // =========================================
	        // STEP 2: INSERT USER
	        // =========================================

	        try (
	                PreparedStatement userPs =
	                        connection.prepareStatement(userSql)
	        ) {

	            String hashedPassword =
	                    PasswordUtil.hashPassword(
	                            user.getPwd()
	                    );

	            userPs.setString(
	                    1,
	                    user.getEmail()
	            );

	            userPs.setString(
	                    2,
	                    hashedPassword
	            );

	            userPs.setString(
	                    3,
	                    user.getRole()
	            );

	            int userRows =
	                    userPs.executeUpdate();

	            if (userRows == 0) {

	                connection.rollback();

	                return false;
	            }
	        }


	        // =========================================
	        // STEP 3: COMMIT
	        // =========================================

	        connection.commit();

	        return true;


	    } catch (Exception e) {

	        e.printStackTrace();

	        if (connection != null) {

	            try {

	                connection.rollback();

	            } catch (Exception rollbackException) {

	                rollbackException.printStackTrace();
	            }
	        }

	        return false;


	    } finally {

	        if (connection != null) {

	            try {

	                connection.setAutoCommit(true);

	                connection.close();

	            } catch (Exception e) {

	                e.printStackTrace();
	            }
	        }
	    }
	}

	/*
	 * ============================================================ PUBLIC
	 * REGISTRATION ============================================================
	 *
	 * Creates:
	 *
	 * 1. employees record 2. user record
	 *
	 * Used by RegisterServlet.
	 *
	 * ============================================================
	 */
	@Override
	public boolean createUserAndEmployee(User user, String employeeName) {

		Connection connection = null;

		String employeeSql = "INSERT INTO employees " + "(employee_name, email) " + "VALUES (?, ?)";

		String userSql = "INSERT INTO user " + "(email, password, role) " + "VALUES (?, ?, ?)";

		try {

			connection = DbUtil.getConnection();

			// Start transaction
			connection.setAutoCommit(false);

			/*
			 * ===================================================== STEP 1: INSERT EMPLOYEE
			 * =====================================================
			 */

			try (PreparedStatement employeePs = connection.prepareStatement(employeeSql)) {

				employeePs.setString(1, employeeName);
				employeePs.setString(2, user.getEmail());

				int employeeRows = employeePs.executeUpdate();

				if (employeeRows == 0) {

					connection.rollback();

					return false;
				}
			}

			/*
			 * ===================================================== STEP 2: INSERT USER
			 * =====================================================
			 */

			try (PreparedStatement userPs = connection.prepareStatement(userSql)) {

				String hashedPassword = PasswordUtil.hashPassword(user.getPwd());

				userPs.setString(1, user.getEmail());
				userPs.setString(2, hashedPassword);
				userPs.setString(3, user.getRole());

				int userRows = userPs.executeUpdate();

				if (userRows == 0) {

					connection.rollback();

					return false;
				}
			}

			/*
			 * ===================================================== STEP 3: COMMIT
			 * =====================================================
			 */

			connection.commit();

			return true;

		} catch (Exception e) {

			e.printStackTrace();

			if (connection != null) {

				try {

					connection.rollback();

				} catch (Exception rollbackException) {

					rollbackException.printStackTrace();
				}
			}

			return false;

		} finally {

			if (connection != null) {

				try {

					connection.setAutoCommit(true);
					connection.close();

				} catch (Exception e) {

					e.printStackTrace();
				}
			}
		}
	}

	/*
	 * ============================================================ LOGIN
	 * ============================================================
	 *
	 * Login is linked using employee email.
	 *
	 * user.email ↓ employees.email ↓ employee_id
	 *
	 * This employee_id is then stored in session.
	 *
	 * ============================================================
	 */
	@Override
	public User login(String email, String password) {

		User user = null;

		String sql = "SELECT u.*, " + "e.employee_id, " + "e.employee_name AS employee_name " + "FROM user u "
				+ "LEFT JOIN employees e " + "ON u.email = e.email " + "WHERE u.email=?";

		try (Connection connection = DbUtil.getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, email);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				String hashedPassword = rs.getString("password");

				if (PasswordUtil.checkPassword(password, hashedPassword)) {

					user = new User();

					user.setId(rs.getInt("id"));

					user.setEmail(rs.getString("email"));

					user.setPwd(hashedPassword);

					user.setRole(rs.getString("role"));

					/*
					 * Employee ID from employees table
					 */
					user.setEmployeeId(rs.getInt("employee_id"));

					/*
					 * Employee name from employees table
					 */
					user.setName(rs.getString("employee_name"));
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return user;
	}

	/*
	 * ============================================================ GET ALL USERS
	 * ============================================================
	 */
	@Override
	public List<User> getAllUsers() {

		List<User> users = new ArrayList<>();

		String sql = "SELECT * FROM user";

		try (Connection connection = DbUtil.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {

				User user = new User();

				user.setId(rs.getInt("id"));

				user.setEmail(rs.getString("email"));

				user.setPwd(rs.getString("password"));

				user.setRole(rs.getString("role"));

				users.add(user);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return users;
	}

	/*
	 * ============================================================ DELETE USER BY
	 * ID ============================================================
	 */
	@Override
	public boolean deleteUser(int id) {

		String sql = "DELETE FROM user WHERE id=?";

		try (Connection connection = DbUtil.getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {

			e.printStackTrace();
		}

		return false;
	}

	/*
	 * ============================================================ DELETE USER BY
	 * EMAIL ============================================================
	 *
	 * Used when Admin deletes an employee.
	 *
	 * ============================================================
	 */
	@Override
	public boolean deleteUserByEmail(String email) {

		String sql = "DELETE FROM user WHERE email=?";

		try (Connection connection = DbUtil.getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, email);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {

			e.printStackTrace();
		}

		return false;
	}

	/*
	 * ============================================================ UPDATE PROFILE
	 * ============================================================
	 *
	 * Updates both:
	 *
	 * user employees
	 *
	 * inside one transaction.
	 *
	 * ============================================================
	 */
	@Override
	public boolean updateProfile(int userId, String name, String email) {

		String getEmailSql = "SELECT email FROM user WHERE id=?";

		String userSql = "UPDATE user SET email=? WHERE id=?";

		String employeeSql = "UPDATE employees " + "SET employee_name=?, email=? " + "WHERE email=?";

		Connection con = null;

		try {

			con = DbUtil.getConnection();

			con.setAutoCommit(false);

			String oldEmail = null;

			/*
			 * Get old email
			 */
			try (PreparedStatement ps = con.prepareStatement(getEmailSql)) {

				ps.setInt(1, userId);

				try (ResultSet rs = ps.executeQuery()) {

					if (rs.next()) {

						oldEmail = rs.getString("email");
					}
				}
			}

			if (oldEmail == null) {

				con.rollback();

				return false;
			}

			/*
			 * Update user
			 */
			try (PreparedStatement ps = con.prepareStatement(userSql)) {

				ps.setString(1, email);
				ps.setInt(2, userId);

				int rows = ps.executeUpdate();

				if (rows == 0) {

					con.rollback();

					return false;
				}
			}

			/*
			 * Update employee
			 */
			try (PreparedStatement ps = con.prepareStatement(employeeSql)) {

				ps.setString(1, name);
				ps.setString(2, email);
				ps.setString(3, oldEmail);

				ps.executeUpdate();
			}

			/*
			 * Commit
			 */
			con.commit();

			return true;

		} catch (Exception e) {

			e.printStackTrace();

			if (con != null) {

				try {

					con.rollback();

				} catch (Exception rollbackException) {

					rollbackException.printStackTrace();
				}
			}

			return false;

		} finally {

			if (con != null) {

				try {

					con.setAutoCommit(true);
					con.close();

				} catch (Exception e) {

					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public boolean updateEmailByOldEmail(String oldEmail, String newEmail) {

		String sql = "UPDATE user SET email=? WHERE email=?";

		try (Connection connection = DbUtil.getConnection();

				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, newEmail);
			ps.setString(2, oldEmail);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {

			e.printStackTrace();
		}

		return false;

	}

}
