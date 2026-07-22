package com.rakesh.elams.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.Attendance;
import com.rakesh.elams.util.DbUtil;

public class AttendanceDaoImpl implements AttendanceDao {

	@Override
	public boolean checkIn(Attendance attendance) {

		String sql = "INSERT INTO attendance " + "(employee_id, attendance_date, check_in, status) "
				+ "VALUES (?, CURDATE(), CURTIME(), ?)";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, attendance.getEmployee_id());
			ps.setString(2, attendance.getStatus());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public boolean checkOut(int employeeId) {

		String sql = "UPDATE attendance " + "SET check_out = CURTIME() " + "WHERE employee_id=? "
				+ "AND attendance_date=CURDATE()";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, employeeId);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public Attendance getTodayAttendance(int employeeId) {

		Attendance attendance = null;

		String sql = "SELECT * FROM attendance " + "WHERE employee_id=? " + "AND attendance_date=CURDATE()";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, employeeId);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {

				attendance = new Attendance();

				attendance.setAttendance_id(rs.getInt("attendance_id"));

				attendance.setEmployee_id(rs.getInt("employee_id"));

				attendance.setAttendance_date(rs.getDate("attendance_date"));

				attendance.setCheck_in_time(rs.getTime("check_in"));

				attendance.setCheck_out_time(rs.getTime("check_out"));

				attendance.setStatus(rs.getString("status"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return attendance;
	}

	@Override
	public List<Attendance> getAttendanceByEmployee(int employeeId) {

		List<Attendance> list = new ArrayList<>();

		String sql = "SELECT * FROM attendance " + "WHERE employee_id=? " + "ORDER BY attendance_date DESC";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, employeeId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Attendance attendance = new Attendance();

				attendance.setAttendance_id(rs.getInt("attendance_id"));

				attendance.setEmployee_id(rs.getInt("employee_id"));

				attendance.setAttendance_date(rs.getDate("attendance_date"));

				attendance.setCheck_in_time(rs.getTime("check_in"));

				attendance.setCheck_out_time(rs.getTime("check_out"));
				attendance.setStatus(rs.getString("status"));
				list.add(attendance);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public boolean hasCheckedInToday(int employeeId) {

		String sql = "SELECT attendance_id " + "FROM attendance " + "WHERE employee_id=? "
				+ "AND attendance_date=CURDATE()";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, employeeId);

			ResultSet rs = ps.executeQuery();

			return rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public int getPresentCount(Date date) {

		String sql = "SELECT COUNT(*) FROM attendance " + "WHERE attendance_date=? AND status='PRESENT'";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setDate(1, date);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
	@Override
	public int getAbsentCount(Date date) {

		String sql = "SELECT COUNT(*) FROM attendance " + "WHERE attendance_date=? AND status='ABSENT'";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setDate(1, date);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public int getHalfDayCount(Date date) {

		String sql = "SELECT COUNT(*) FROM attendance " + "WHERE attendance_date=? AND status='HALF_DAY'";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setDate(1, date);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
	@Override
	public List<Attendance> getAttendanceByManager(int managerId) {

	    List<Attendance> list = new ArrayList<>();

	    String sql =
	            "SELECT a.*, e.name AS employee_name " +
	            "FROM attendance a " +
	            "INNER JOIN employees e " +
	            "ON a.employee_id = e.employee_id " +
	            "WHERE e.manager_id = ? " +
	            "ORDER BY a.attendance_date DESC, e.name ASC";

	    try (
	        Connection conn = DbUtil.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql)
	    ) {

	        ps.setInt(1, managerId);

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {

	            Attendance attendance = new Attendance();

	            attendance.setAttendance_id(
	                    rs.getInt("attendance_id"));

	            attendance.setEmployee_id(
	                    rs.getInt("employee_id"));

	            attendance.setAttendance_date(
	                    rs.getDate("attendance_date"));

	            attendance.setCheck_in_time(
	                    rs.getTime("check_in"));

	            attendance.setCheck_out_time(
	                    rs.getTime("check_out"));

	            attendance.setStatus(
	                    rs.getString("status"));

	            // Set employee name
	            attendance.setEmployeeName(
	                    rs.getString("employee_name"));

	            list.add(attendance);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	@Override
	public int getPresentCountByManager(Date date, int managerId) {

	    String sql =
	            "SELECT COUNT(*) " +
	            "FROM attendance a " +
	            "INNER JOIN employees e " +
	            "ON a.employee_id = e.employee_id " +
	            "WHERE a.attendance_date = ? " +
	            "AND a.status = 'PRESENT' " +
	            "AND e.manager_id = ?";

	    try (
	        Connection conn = DbUtil.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql)
	    ) {

	        ps.setDate(1, date);
	        ps.setInt(2, managerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}
	@Override
	public int getAbsentCountByManager(Date date, int managerId) {

	    String sql =
	            "SELECT COUNT(*) " +
	            "FROM attendance a " +
	            "INNER JOIN employees e " +
	            "ON a.employee_id = e.employee_id " +
	            "WHERE a.attendance_date = ? " +
	            "AND a.status = 'ABSENT' " +
	            "AND e.manager_id = ?";

	    try (
	        Connection conn = DbUtil.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql)
	    ) {

	        ps.setDate(1, date);
	        ps.setInt(2, managerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}
	@Override
	public int getHalfDayCountByManager(Date date, int managerId) {

	    String sql =
	            "SELECT COUNT(*) " +
	            "FROM attendance a " +
	            "INNER JOIN employees e " +
	            "ON a.employee_id = e.employee_id " +
	            "WHERE a.attendance_date = ? " +
	            "AND a.status IN ('HALF_DAY', 'Half Day') " +
	            "AND e.manager_id = ?";

	    try (
	        Connection conn = DbUtil.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql)
	    ) {

	        ps.setDate(1, date);
	        ps.setInt(2, managerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}
}