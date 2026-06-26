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
	public boolean markAttendance(Attendance attendance) {
		String sqll = "INSERT INTO attendance(attendance_id,employee_id,attendance_date,check_in,check_out,status) VALUES(?,?,?,?,?,?)";
		try {
			Connection conn = DbUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(sqll);
			ps.setInt(1, attendance.getAttendance_id());
			ps.setInt(2, attendance.getEmployee_id());
			ps.setDate(3, attendance.getAttendance_date());
			ps.setTime(4, attendance.getCheck_in_time());
			ps.setTime(5, attendance.getCheck_out_time());
			ps.setString(6, attendance.getStatus());
			int count = ps.executeUpdate();
			return count > 0;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	@Override
	public boolean updateAttendance(Attendance attendance) {
		String sql = "update attendance set attendance_id=?, employee_id=? , attendance_date=?, check_in=?,check_out=?,status=? where where attendance_id=?";
		try {
			Connection conn = DbUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, attendance.getAttendance_id());
			ps.setInt(2, attendance.getAttendance_id());
			ps.setDate(3, attendance.getAttendance_date());
			ps.setTime(4, attendance.getCheck_in_time());
			ps.setTime(5, attendance.getCheck_out_time());
			ps.setString(6, attendance.getStatus());
			int count = ps.executeUpdate();
			return count > 0;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	@Override
	public boolean deleteAttendance(int attendanceId) {
		String sql = "delete from attendance where attendance_id=?";
		try {
			Connection conn = DbUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, attendanceId);
			int executeUpdate = ps.executeUpdate();
			return executeUpdate > 0;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	@Override
	public Attendance getAttendanceById(int attendanceId) {
		Attendance attendance = null;
		String sql = "SELECT * FROM attendance WHERE attendance_id=?";

		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, attendanceId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				attendance = new Attendance(rs.getInt("attendance_id"), rs.getDate("attendance_date"),
						rs.getTime("check_in"), rs.getTime("check_out"), rs.getString("status"),
						rs.getInt("employee_id"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return attendance;

	}

	@Override
	public List<Attendance> getAttendanceByEmployee(int employeeId) {

		List<Attendance> attendanceList = new ArrayList<>();

		String sql = "SELECT * FROM attendance WHERE employee_id=? ORDER BY attendance_date DESC";

		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, employeeId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Attendance attendance = new Attendance();

				attendance.setAttendance_id(rs.getInt("attendance_id"));

				attendance.setEmployee_id(rs.getInt("employee_id"));

				attendance.setAttendance_date(rs.getDate("attendance_date"));

				attendance.setCheck_in_time(rs.getTime("check_in"));

				attendance.setCheck_in_time(rs.getTime("check_out"));

				attendance.setStatus(rs.getString("status"));

				attendanceList.add(attendance);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return attendanceList;
	}

	@Override
	public List<Attendance> getAttendanceByDate(Date attendanceDate) {

		List<Attendance> attendanceList = new ArrayList<>();

		String sql = "SELECT * FROM attendance WHERE attendance_date=?";

		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setDate(1, attendanceDate);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Attendance attendance = new Attendance();

				attendance.setAttendance_id(rs.getInt("attendance_id"));

				attendance.setEmployee_id(rs.getInt("employee_id"));

				attendance.setAttendance_date(rs.getDate("attendance_date"));

				attendance.setCheck_in_time(rs.getTime("check_in"));

				attendance.setCheck_in_time(rs.getTime("check_out"));

				attendance.setStatus(rs.getString("status"));

				attendanceList.add(attendance);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return attendanceList;
	}

	@Override
	public List<Attendance> getAllAttendance() {

		List<Attendance> attendanceList = new ArrayList<>();

		String sql = "SELECT * FROM attendance ORDER BY attendance_date DESC";

		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Attendance attendance = new Attendance();

				attendance.setAttendance_id(rs.getInt("attendance_id"));

				attendance.setEmployee_id(rs.getInt("employee_id"));

				attendance.setAttendance_date(rs.getDate("attendance_date"));

				attendance.setCheck_in_time(rs.getTime("check_in"));

				attendance.setCheck_in_time(rs.getTime("check_out"));

				attendance.setStatus(rs.getString("status"));

				attendanceList.add(attendance);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return attendanceList;
	}

	@Override
	public int getPresentCount(Date date) {
		return getCount(date, "present");

	}

	@Override
	public int getAbsentCount(Date date) {
		return getCount(date,"absent");
	}

	@Override
	public int getHalfDayCount(Date date) {
		return getCount(date,"halfday");

	}

	private int getCount(Date date, String status) {

		int count = 0;

		String sql = "SELECT COUNT(*) FROM attendance WHERE attendance_date=? AND status=?";

		try (Connection con = DbUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setDate(1, date);
			ps.setString(2, status);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

}
