package com.rakesh.elams.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rakesh.elams.model.User;
import com.rakesh.elams.util.DbUtil;

public class UserDaoImpl implements UserDao {

	public void addUser(User user) {
		String sql = "insert into User(id,email,password,role) values(?,?,?,?)";
		
		try{Connection connection = DbUtil.getConnection();
		PreparedStatement ps = connection.prepareStatement(sql);
			
		ps.setInt(1, user.getId());
		ps.setString(2, user.getEmail());
		ps.setString(3, user.getPwd());
		ps.setString(4, user.getRole());
		
		int count = ps.executeUpdate();
		if(count >0) {
			System.out.println(count+ ":user added sucessfully");
		}
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
	}
	public User login(String email, String password) {
		
		User user = null;
	String 	 sql = "select * from user where email=? and password=?";
		 try {
			 Connection connection = DbUtil.getConnection();
			 PreparedStatement ps = connection.prepareStatement(sql);
			 
			 ps.setString(1,email );
			 ps.setString(2,password);
			 
			 ResultSet rs = ps.executeQuery();
			 while(rs.next()) {
				 user = new User();
				 user.setId(rs.getInt("id"));
				 user.setEmail(rs.getString("email"));
				 user.setPwd(rs.getString("password"));
				 user.setRole(rs.getString("role"));
			 }
		 }
		 catch(Exception e ) {
				System.out.println(e.getMessage());
			}
		return user;
		
	}
	public List<User> getAllUsers(){
		ArrayList<User> users = new ArrayList<>();
		String sql = "select * from user";
		try{
			Connection connection = DbUtil.getConnection();
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				User user = new User(rs.getInt("id"),rs.getString("email"),rs.getString("password"),rs.getString("role"));
				
			users.add(user);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return users;
		
	}
	public boolean deleteUser(int id) {
		
		String sql = "delete from user where id=?";
		try{
			Connection connection = DbUtil.getConnection();
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			int count = ps.executeUpdate();
			if(count > 0 ) {
				 System.out.println(count+" : records deleted successfully");
				 return true;
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}
}
