package com.rakesh.elams.controller;

import java.io.IOException;

import com.rakesh.elams.dao.UserDao;
import com.rakesh.elams.dao.UserDaoImpl;
import com.rakesh.elams.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserDao userDao;

	@Override
	public void init() throws ServletException {

		userDao = new UserDaoImpl();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// Check whether user is logged in
		if (session == null) {

			response.sendRedirect("login.jsp");
			return;
		}

		// Check manager role
		String role = (String) session.getAttribute("role");

		if (role == null || !role.equalsIgnoreCase("MANAGER")) {

			response.sendRedirect("login.jsp");
			return;
		}

		// Get logged-in User object
		User user = (User) session.getAttribute("user");

		if (user == null) {

			response.sendRedirect("login.jsp");
			return;
		}

		// Get user ID
		int userId = user.getId();

		// Get updated values from profile.jsp
		String name = request.getParameter("name");
		String email = request.getParameter("email");

		// Remove unnecessary spaces
		if (name != null) {
			name = name.trim();
		}

		if (email != null) {
			email = email.trim();
		}

		// Validate input
		if (name == null || name.isEmpty() || email == null || email.isEmpty()) {

			session.setAttribute("profileError", "Name and email are required.");

			response.sendRedirect("profile.jsp");
			return;
		}

		// Update database
		boolean updated = userDao.updateProfile(userId, name, email);

		if (updated) {

			// Update User object
			user.setName(name);
			user.setEmail(email);

			// Update session User object
			session.setAttribute("user", user);

			// Update manager name session
			session.setAttribute("managerName", name);

			// Update username session
			session.setAttribute("username", email);

			// Success message
			session.setAttribute("profileSuccess", "Profile updated successfully.");

		} else {

			// Error message
			session.setAttribute("profileError", "Unable to update profile. Please try again.");
		}

		// Return to profile page
		response.sendRedirect("profile.jsp");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.sendRedirect("profile.jsp");
	}

}
