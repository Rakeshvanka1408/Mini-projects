package com.rakesh.elams.dao;

import java.util.List;

import com.rakesh.elams.model.User;

public interface UserDao {

	boolean addUser(User user);

	User login(String email, String password);

	List<User> getAllUsers();

	boolean deleteUser(int id);

	boolean deleteUserByEmail(String email);

	boolean updateProfile(int userId, String name, String email);

	boolean createEmployeeAndUser(User user, String employeeName, long phone, String department, String designation,
			int managerId);

	boolean createUserAndEmployee(User user, String employeeName);

	boolean updateEmailByOldEmail(String oldEmail, String newEmail);

}
