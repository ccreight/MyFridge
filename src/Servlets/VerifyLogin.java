package Servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import SQL.JDBC;

@WebServlet("/VerifyLogin")
public class VerifyLogin extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String u = request.getParameter("username");
		String p = request.getParameter("password");
		
		JDBC j = new JDBC();
		
		String result = j.validation(u, p);
		
		String target = "/home.jsp";
		String log = "false";
		
		if(!result.equals("success")) {
			target = "/login.jsp";
		}
		else {
			log = "true"; //set this as a session variable down below!!!
			request.getSession(false).setAttribute("username", u);
		}
		
		request.setAttribute("loginerror", result);
		request.getSession(false).setAttribute("log", log);
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(target);
		dispatch.forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

