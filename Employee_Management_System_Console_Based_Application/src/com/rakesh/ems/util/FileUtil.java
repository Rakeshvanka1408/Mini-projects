package com.rakesh.ems.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.ems.model.Employee;

public class FileUtil {
	
	static File f = new File("Employees.txt");
		public static void saveEmployees(List<Employee> employees) throws IOException {
			if(!f.exists()) {
				f.createNewFile();
			}
			System.out.println(f.getAbsolutePath());
		BufferedWriter br = new BufferedWriter(new FileWriter(f));
		if(employees.isEmpty()) {
			System.out.println("no data found to write into the file");
			return;
		}
		for(Employee emp : employees) {
			br.write(emp.toString());
			br.newLine();
		}
		br.close();
		System.out.println("successfully data saved into file");
		
	}
	public static ArrayList<String> readEmployees() throws Exception{
		ArrayList<String> list = new ArrayList<>();
		
		BufferedReader br = new BufferedReader(new FileReader(f));
		
		String line ;
		while((line = br.readLine())!=null) {
			list.add(line);
		}
		br.close();
		return list;
		
	}

}
