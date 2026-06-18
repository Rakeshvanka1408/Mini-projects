package com.rakesh.ems.threads;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.ems.model.Employee;
import com.rakesh.ems.util.FileUtil;

public class SaveThread implements Runnable {
	private List<Employee> employees = new ArrayList<>();
	public SaveThread(List<Employee> employees){
		this.employees = employees;
	}
	@Override
	public void run() {
		try {
			System.out.println("saving the data....");
			Thread.sleep(3000);
			FileUtil.saveEmployees(employees);
			System.out.println("data saved successfully");

		} catch (IOException e) {
			System.out.println("failed to save the data");
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
}
