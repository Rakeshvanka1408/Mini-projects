package com.rakesh.ems.threads;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.ems.model.Employee;

public class ReportThread implements Runnable {
	private List<Employee> employees = new ArrayList<>();

	public ReportThread(List<Employee> employees) {
		this.employees = employees;
	}

	@Override
	public void run() {

		try (BufferedWriter bw = new BufferedWriter(new FileWriter("employee_report.txt"))) {

			bw.write("======== employee reports =========");
			bw.newLine();
			for (Employee emps : employees) {
				bw.write(emps.toString());
				bw.newLine();
			}
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
