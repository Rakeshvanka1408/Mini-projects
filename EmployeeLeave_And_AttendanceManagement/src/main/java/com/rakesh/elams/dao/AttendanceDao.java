package com.rakesh.elams.dao;

import java.sql.Date;
import java.util.List;

import com.rakesh.elams.model.Attendance;

public interface AttendanceDao {

    public boolean markAttendance(Attendance attendance) ;

    public boolean updateAttendance(Attendance attendance) ;

    public boolean deleteAttendance(int attendanceId) ;

    public Attendance getAttendanceById(int attendanceId);

    public List<Attendance> getAttendanceByEmployee(int employeeId) ;

    public List<Attendance> getAttendanceByDate(Date attendanceDate);

    public List<Attendance> getAllAttendance();

    public int getPresentCount(Date date) ;

    public int getAbsentCount(Date date) ;

    public int getHalfDayCount(Date date) ;
}
