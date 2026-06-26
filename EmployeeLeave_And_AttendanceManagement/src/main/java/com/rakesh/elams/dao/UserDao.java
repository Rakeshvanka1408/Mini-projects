package com.rakesh.elams.dao;

import java.util.List;

import com.rakesh.elams.model.User;

public interface UserDao {
	public void addUser(User user);
	public User login(String email, String password);
	public List<User> getAllUsers();
	public boolean deleteUser(int id);
}
