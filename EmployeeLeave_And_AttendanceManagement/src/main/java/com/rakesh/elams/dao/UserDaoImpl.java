package com.rakesh.elams.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.User;
import com.rakesh.elams.util.DbUtil;
import com.rakesh.elams.util.PasswordUtil;

public class UserDaoImpl implements UserDao {

    @Override
    public boolean addUser(User user) {

        String sql = "INSERT INTO user(email,password,role) VALUES(?,?,?)";

        try {

            Connection connection = DbUtil.getConnection();

            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user.getEmail());
            
            String hashedPassword = PasswordUtil.hashPassword(user.getPwd());

            System.out.println("Original Password : " + user.getPwd());
            System.out.println("Hashed Password   : " + hashedPassword);

            ps.setString(2, hashedPassword);
            ps.setString(3, user.getRole());

            int count = ps.executeUpdate();

            return count > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }

    
    @Override
    public User login(String email, String password) {

        User user = null;

        String sql =
                "SELECT u.*, e.employee_id " +
                "FROM user u " +
                "LEFT JOIN employees e ON u.email = e.email " +
                "WHERE u.email=?";

        try {

            Connection connection = DbUtil.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String hashedPassword =
                        rs.getString("password");

                if (PasswordUtil.checkPassword(
                        password,
                        hashedPassword)) {

                    user = new User();

                    user.setId(rs.getInt("id"));
                    user.setEmail(rs.getString("email"));
                    user.setPwd(hashedPassword);
                    user.setRole(rs.getString("role"));

                    // Employee ID from employees table
                    user.setEmployeeId(
                            rs.getInt("employee_id"));
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return user;
    }
    @Override
    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        String sql = "SELECT * FROM user";

        try {

            Connection connection = DbUtil.getConnection();

            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPwd(rs.getString("password"));
                user.setRole(rs.getString("role"));

                users.add(user);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return users;
    }

    @Override
    public boolean deleteUser(int id) {

        String sql = "DELETE FROM user WHERE id=?";

        try {

            Connection connection = DbUtil.getConnection();

            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, id);

            int count = ps.executeUpdate();

            return count > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }

}