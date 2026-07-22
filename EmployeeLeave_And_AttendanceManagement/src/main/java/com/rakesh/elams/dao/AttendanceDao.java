package com.rakesh.elams.dao;

import java.sql.Date;
import java.util.List;

import com.rakesh.elams.model.Attendance;

public interface AttendanceDao {

    boolean checkIn(Attendance attendance);

    boolean checkOut(int employeeId);

    Attendance getTodayAttendance(int employeeId);

    List<Attendance> getAttendanceByEmployee(int employeeId);

    boolean hasCheckedInToday(int employeeId);

    // Existing methods - DO NOT REMOVE
    int getPresentCount(Date date);

    int getAbsentCount(Date date);

    int getHalfDayCount(Date date);

    // New manager-specific methods
    List<Attendance> getAttendanceByManager(int managerId);

    int getPresentCountByManager(Date date, int managerId);

    int getAbsentCountByManager(Date date, int managerId);

    int getHalfDayCountByManager(Date date, int managerId);
}