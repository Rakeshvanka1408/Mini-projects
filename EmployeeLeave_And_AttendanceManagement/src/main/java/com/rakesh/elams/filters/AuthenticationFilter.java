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

		if (uri.endsWith("login.jsp") || uri.endsWith("login") || uri.contains("css") || uri.contains("js")) {

			chain.doFilter(request, response);
			return;
		}

		HttpSession session = req.getSession(false);

		if (session == null) {

			res.sendRedirect(req.getContextPath() + "/login.jsp");

			return;
		}

		chain.doFilter(request, response);
	}

}