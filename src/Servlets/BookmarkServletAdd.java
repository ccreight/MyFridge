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

@WebServlet("/BookmarkServletAdd")
public class BookmarkServletAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true); 
//		session.setAttribute("username", "root"); //Should be done elsewhere
		String username = ((String) (session.getAttribute("username")));
		String imageUrl = (String)request.getParameter("imageUrl");
		String url = (String)request.getParameter("url");
		String title = (String)request.getParameter("title");
		int calories = Integer.parseInt(request.getParameter("calories"));
		float yield = Float.parseFloat(request.getParameter("yield"));
		String ingredients = (String)request.getParameter("ingredients");
		String labels = (String)request.getParameter("labels");
		int ingredientsInCommon = Integer.parseInt(request.getParameter("ingredientsInCommon"));
		FoodAPI c = (FoodAPI)session.getAttribute("recipes");
		System.out.println("Attempting to add to bookmarked recipe DB:");
		
		if(session.getAttribute("username")!=null && username.length()>0) {
			JDBC db = new JDBC();
			
			ArrayList<Recipe> bookmarkedRecipes = (ArrayList<Recipe>)db.getBookmarkedRecipes(username);
			if(bookmarkedRecipes==null) { bookmarkedRecipes = new ArrayList<Recipe>(); }
			
			Recipe recipe = new Recipe();
			recipe.setImageUrl(imageUrl);
			recipe.setUrl(url);
			recipe.setName(title);
			recipe.setCalories(calories);
			recipe.setYield(yield);
			recipe.getIngredients().add(ingredients);
			recipe.getLabels().add(labels);
			recipe.setIngredientsInCommon(ingredientsInCommon);
			
			bookmarkedRecipes.add(recipe);
			db.addBookmarkedRecipes(username, bookmarkedRecipes);
			
			if(c!=null) {
				for(int i = 0; i < c.getHits().size(); i++) {
					if(c.getHits().get(i).getRecipe().getLabel().trim().equalsIgnoreCase(title.trim())) {
						c.getHits().get(i).setBookmarked(true);
					}
					
				}
				session.setAttribute("recipes", c);
			}
			
			System.out.println("Added the recipe " + title + " to " + username + "'s bookmarked recipes.");
		} else {
			System.out.println("Failed to add the recipe " + title + " to " + username + "'s bookmarked recipes.");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
