package Servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import SQL.Fridge;
import SQL.JDBC;
import SQL.Recipe;


@WebServlet("/CustomRecipeServletSubmit")
public class CustomRecipeServletSubmit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true); 
//		session.setAttribute("username", "root"); //Should be done elsewhere
		String username = ((String) (session.getAttribute("username")));
		String title = (String)request.getParameter("title");
		String instructions = (String)request.getParameter("instructions");
		Fridge f = (Fridge)session.getAttribute("CustomRecipeFridge");
		System.out.println("Attempting to add to custom recipe DB:");
		
		if(session.getAttribute("username")!=null && request.getParameter("title")!=null && request.getParameter("instructions")!= null 
				&& instructions.trim().length()>0 && title.trim().length()>0 && username.length()>0) {
			JDBC db = new JDBC();
			
			ArrayList<Recipe> recipes = (ArrayList<Recipe>)db.getCustomRecipes(username);
			if(recipes==null) { recipes = new ArrayList<Recipe>(); }
			
			Recipe r = new Recipe();
			r.setName(title);
			r.setInstructions(instructions);
			if(f!=null) {
				for(String s : f.getIngredients()) {
					r.addIngredient(s);
				}
			}
			recipes.add(r);
			db.addCustomRecipes(username, recipes);
			session.setAttribute("CustomRecipeFridge", null);
			System.out.println("Added the recipe " + title + " to " + username + "'s custom recipes.");
		} else {
			System.out.println("Failed to add the recipe " + title + " to " + username + "'s custom recipes.");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
