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

@WebServlet("/FridgeServletDelete")
public class FridgeServletDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true); 
//		session.setAttribute("username", "root"); //Should be done elsewhere
		String username = ((String) (session.getAttribute("username")));
		String ingredient = (String) request.getParameter("ingredient");
		System.out.println("Attempting to remove from fridge:");
		
		if(session.getAttribute("username")!=null && request.getParameter("ingredient")!=null && 
				ingredient.trim().length()>0 && username.length()>0) {
			JDBC db = new JDBC();
			Fridge fridge = (Fridge)db.getFridge(username);
			if(fridge!=null) {
				fridge.removeIngredient(ingredient);
				db.addFridge(username, fridge);
				System.out.println("Removed " + ingredient.trim() + " from " + username + "'s fridge.");
			} else {
				System.out.println(ingredient.trim() + " wasn't removed since " + username + " doesn't have a fridge.");
			}
		} else {
			System.out.println("Failed to remove ingredient from fridge.");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
