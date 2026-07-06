package com.rakesh.elams.util;


import java.security.MessageDigest;

public class PasswordUtil {
	
	public static String hashPassword(String password){

		try{

		MessageDigest md = MessageDigest.getInstance("SHA-256");
		// converted into byte becuse hasing working only byte 
		byte [] bytes = md.digest(password.getBytes());
		
		StringBuilder sb = new StringBuilder();
		
		  for(byte b:bytes) {
			  //Each byte is converted into two hexadecimal characters using String.format()
			   sb.append(String.format("%02x", b));
			   
		  
		  }
		  
		  return sb.toString(); 
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
     
		
	   }
	
	}