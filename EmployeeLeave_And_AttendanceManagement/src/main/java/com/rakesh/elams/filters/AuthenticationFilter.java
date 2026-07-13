package com.rakesh.elams.filters;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String uri = req.getRequestURI();

		// Public resources
		if (uri.endsWith("login.jsp") || uri.endsWith("/login") || uri.endsWith("register.jsp") || uri.contains("/css/")
				|| uri.contains("/js/") || uri.contains("/images/") || uri.endsWith(".css") || uri.endsWith(".js")
				|| uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".jpeg") || uri.endsWith("/")) {

			chain.doFilter(request, response);
			return;
		}

		HttpSession session = req.getSession(false);

		System.out.println("URI = " + uri);
		System.out.println("Session = " + session);

		if (session != null) {
			System.out.println("Session ID = " + session.getId());
			System.out.println("User = " + session.getAttribute("user"));
			System.out.println("Role = " + session.getAttribute("role"));
			System.out.println("Employee ID = " + session.getAttribute("employeeId"));
		}

		if (session == null || session.getAttribute("user") == null) {
			res.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		chain.doFilter(request, response);
	}
}