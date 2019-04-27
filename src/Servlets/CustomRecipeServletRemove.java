package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import SQL.Fridge;

@WebServlet("/CustomRecipeServletRemove")
public class CustomRecipeServletRemove extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true); 
//		session.setAttribute("username", "root"); //Should be done elsewhere
		String username = ((String) (session.getAttribute("username")));
		
		Fridge f = null;
		if(session.getAttribute("CustomRecipeFridge")==null) {
			return;
		} else {
			f = (Fridge)session.getAttribute("CustomRecipeFridge");
		}
		
		String ingredient = (String) request.getParameter("ingredient");
		System.out.println("Attempting to remove from custom recipe fridge:");
		
		if(session.getAttribute("username")!=null && request.getParameter("ingredient")!=null && 
				ingredient.trim().length()>0 && username.length()>0) {
			f.removeIngredient(ingredient);
			session.setAttribute("CustomRecipeFridge", f);
			System.out.println("Removed " +ingredient +" from the custom recipe fridge.");
		} else {
			System.out.println("Failed to remove ingredient from custom recipe fridge.");
		}

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
