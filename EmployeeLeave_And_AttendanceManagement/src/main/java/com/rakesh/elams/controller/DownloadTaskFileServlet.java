package com.rakesh.elams.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DownloadTaskFileServlet")
public class DownloadTaskFileServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fileName = request.getParameter("file");

		String filePath = "D:/ELAMS_UPLOADS/" + fileName;

		File file = new File(filePath);

		if (!file.exists()) {
			response.getWriter().println("File not found.");
			return;
		}

		response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

		response.setContentLength((int) file.length());

		FileInputStream fis = new FileInputStream(file);

		OutputStream os = response.getOutputStream();

		byte[] buffer = new byte[4096];
		int bytesRead;

		while ((bytesRead = fis.read(buffer)) != -1) {
			os.write(buffer, 0, bytesRead);
		}

		fis.close();
		os.close();
	}
}