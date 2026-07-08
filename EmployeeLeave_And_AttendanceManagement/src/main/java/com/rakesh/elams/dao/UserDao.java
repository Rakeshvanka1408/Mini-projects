package com.rakesh.elams.dao;

import java.util.List;

import com.rakesh.elams.model.User;

public interface UserDao {

    boolean addUser(User user);

    User login(String email, String password);

    List<User> getAllUsers();

    boolean deleteUser(int id);

}