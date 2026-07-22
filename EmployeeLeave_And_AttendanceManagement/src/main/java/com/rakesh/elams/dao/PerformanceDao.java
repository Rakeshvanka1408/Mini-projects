
package com.rakesh.elams.dao;

import java.util.List;

import com.rakesh.elams.model.EmployeePerformance;

public interface PerformanceDao {

    List<EmployeePerformance> getManagerEmployeePerformance(int managerId);

}
