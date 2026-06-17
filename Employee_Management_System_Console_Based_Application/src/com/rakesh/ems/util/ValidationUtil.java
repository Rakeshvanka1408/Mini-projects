package com.rakesh.ems.util;

public class ValidationUtil {

	public static boolean isSalaryValid(double salary) {
		return salary>=10000;
	}
	public static boolean isEmailValid(String email) {
		return email != null
                && email.matches(
                "^[A-Za-z0-9+_.-]+@(.+)$");
	}
}
