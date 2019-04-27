package Servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.FoodAPI.FoodAPI;

import SQL.JDBC;
import SQL.Recipe;

@WebServlet("/BookmarkServletRemove")
public class BookmarkServletRemove extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true); 
		String username = ((String) (session.getAttribute("username")));
		String title = (String) request.getParameter("title");
		FoodAPI c = (FoodAPI)session.getAttribute("recipes");
		System.out.println("Attempting to remove from bookmarked recipes:");
		
		if(session.getAttribute("username")!=null && request.getParameter("title")!=null && 
				title.trim().length()>0 && username.length()>0) {
			JDBC db = new JDBC();
			ArrayList<Recipe> bookmarkedRecipes = (ArrayList<Recipe>)db.getBookmarkedRecipes(username);
			
			if(c!=null) {
				for(int i = 0; i < c.getHits().size(); i++) {
					if(c.getHits().get(i).getRecipe().getLabel().trim().equalsIgnoreCase(title.trim())) {
						c.getHits().get(i).setBookmarked(false);
					}
					
				}
				session.setAttribute("recipes", c);
			}
			
			if(bookmarkedRecipes!=null) {
				for(int i = 0; i < bookmarkedRecipes.size(); i++) {
					if(bookmarkedRecipes.get(i).getName().trim().equalsIgnoreCase(title.trim())) {
						bookmarkedRecipes.remove(i);
						System.out.println("Removed the recipe " + title.trim() + " from " + username + "'s bookmarked recipes.");
					}
				}
				db.addBookmarkedRecipes(username, bookmarkedRecipes);
			} else {
				System.out.println(title.trim() + " wasn't removed since " + username + " doesn't have bookmarked recipes.");
			}
		} else {
			System.out.println("Failed to remove recipe from bookmarked recipes.");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
