package com.rakesh.elams.util;

public class ValidationUtil {

    public static boolean isValidEmail(String email) {

        return email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    public static boolean isValidPhone(String phone) {

        return phone.matches("\\d{10}");
    }

}