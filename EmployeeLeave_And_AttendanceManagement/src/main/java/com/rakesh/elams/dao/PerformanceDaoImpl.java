package com.rakesh.elams.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.EmployeePerformance;
import com.rakesh.elams.util.DbUtil;

public class PerformanceDaoImpl implements PerformanceDao {

    @Override
    public List<EmployeePerformance> getManagerEmployeePerformance(int managerId) {

        List<EmployeePerformance> performanceList =
                new ArrayList<>();

        String sql =
                "SELECT " +
                "    e.employee_id, " +
                "    e.employee_name, " +
                "    COUNT(t.task_id) AS total_tasks, " +
                "    SUM(CASE " +
                "        WHEN t.status = 'COMPLETED' THEN 1 " +
                "        ELSE 0 " +
                "    END) AS completed_tasks, " +
                "    SUM(CASE " +
                "        WHEN t.status = 'PENDING' THEN 1 " +
                "        ELSE 0 " +
                "    END) AS pending_tasks, " +
                "    SUM(CASE " +
                "        WHEN t.status = 'IN_PROGRESS' THEN 1 " +
                "        ELSE 0 " +
                "    END) AS in_progress_tasks " +
                "FROM employees e " +
                "LEFT JOIN tasks t " +
                "    ON e.employee_id = t.employee_id " +
                "    AND t.manager_id = ? " +
                "WHERE e.manager_id = ? " +
                "GROUP BY " +
                "    e.employee_id, " +
                "    e.employee_name " +
                "ORDER BY " +
                "    CASE " +
                "        WHEN COUNT(t.task_id) = 0 THEN 0 " +
                "        ELSE " +
                "            SUM(CASE " +
                "                WHEN t.status = 'COMPLETED' THEN 1 " +
                "                ELSE 0 " +
                "            END) * 100.0 / COUNT(t.task_id) " +
                "    END DESC";

        try (
                Connection con = DbUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            // First ? = task manager_id
            ps.setInt(1, managerId);

            // Second ? = employee manager_id
            ps.setInt(2, managerId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    // =========================================
                    // CREATE PERFORMANCE OBJECT
                    // =========================================

                    EmployeePerformance performance =
                            new EmployeePerformance();


                    // =========================================
                    // GET EMPLOYEE DETAILS
                    // =========================================

                    int employeeId =
                            rs.getInt("employee_id");

                    String employeeName =
                            rs.getString("employee_name");


                    // =========================================
                    // GET TASK COUNTS
                    // =========================================

                    int totalTasks =
                            rs.getInt("total_tasks");

                    int completedTasks =
                            rs.getInt("completed_tasks");

                    int pendingTasks =
                            rs.getInt("pending_tasks");

                    int inProgressTasks =
                            rs.getInt("in_progress_tasks");


                    // =========================================
                    // CALCULATE COMPLETION PERCENTAGE
                    // =========================================

                    double completionPercentage = 0.0;

                    if (totalTasks > 0) {

                        completionPercentage =
                                (completedTasks * 100.0)
                                / totalTasks;
                    }


                    // =========================================
                    // CALCULATE PERFORMANCE RATING
                    // =========================================

                    String rating;

                    if (completionPercentage >= 90) {

                        rating = "Excellent";

                    } else if (completionPercentage >= 75) {

                        rating = "Good";

                    } else if (completionPercentage >= 50) {

                        rating = "Average";

                    } else {

                        rating = "Needs Improvement";
                    }


                    // =========================================
                    // SET EMPLOYEE DETAILS
                    // =========================================

                    performance.setEmployeeId(
                            employeeId);

                    performance.setEmployeeName(
                            employeeName);


                    // =========================================
                    // SET TASK DETAILS
                    // =========================================

                    performance.setTotalTasks(
                            totalTasks);

                    performance.setCompletedTasks(
                            completedTasks);

                    performance.setPendingTasks(
                            pendingTasks);

                    performance.setInProgressTasks(
                            inProgressTasks);


                    // =========================================
                    // SET PERFORMANCE
                    // =========================================

                    performance.setCompletionPercentage(
                            completionPercentage);

                    /*
                     * For now, performance percentage is based
                     * on task completion percentage.
                     */
                    performance.setPerformancePercentage(
                            completionPercentage);


                    // =========================================
                    // SET RATING
                    // =========================================

                    performance.setRating(
                            rating);


                    // =========================================
                    // ADD EMPLOYEE PERFORMANCE TO LIST
                    // =========================================

                    performanceList.add(
                            performance);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "Error while fetching employee performance:"
            );

            e.printStackTrace();
        }

        return performanceList;
    }
}