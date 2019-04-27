package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import SQL.Fridge;
import SQL.JDBC;


@WebServlet("/FridgeServletAdd")
public class FridgeServletAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true); 
//		session.setAttribute("username", "root"); //Should be done elsewhere
		String username = ((String) (session.getAttribute("username")));
		String ingredient = request.getParameter("ingredient");
		System.out.println("Attempting to add to fridge:");
		
		if(session.getAttribute("username")!=null && request.getParameter("ingredient")!=null && 
				ingredient.trim().length()>0 && username.length()>0) {
			JDBC db = new JDBC();
			Fridge fridge = (Fridge)db.getFridge(username);
			if(fridge!=null) {
				fridge.addIngredient(ingredient.trim());
				db.addFridge(username, fridge);
				System.out.println("Added " + ingredient.trim() + " to " + username + "'s fridge.");
			} else {
				fridge = new Fridge();
				fridge.addIngredient(ingredient.trim());
				db.addFridge(username, fridge);
				System.out.println("Added " + ingredient.trim() + " to " + username + "'s new fridge.");
			}
			session.setAttribute("searched", "false");
		} else {
			System.out.println("Failed to add ingredient to fridge.");
		}

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
