package Servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.FoodAPI.FoodAPI;
import com.FoodAPI.Hit;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import SQL.Fridge;
import SQL.JDBC;
import SQL.Recipe;

/**
 * Servlet implementation class ParseSearch
 */
@WebServlet("/ParseSearch")
public class ParseSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String food = request.getParameter("food");
		food = food.replace(' ', '-');
		
		String additionalProperties = "";
		
		if(request.getParameterValues("v1") != null) {
			additionalProperties += "&health=" + request.getParameterValues("v1")[0];
		}
		if(request.getParameterValues("v2") != null) {
				additionalProperties += "&health=" + request.getParameterValues("v2")[0];
		}
		if(request.getParameterValues("v3") != null) {
				additionalProperties += "&diet=" + request.getParameterValues("v3")[0];
		}
		if(request.getParameterValues("v4") != null) {
				additionalProperties += "&diet=" + request.getParameterValues("v4")[0];
		}
		if(request.getParameterValues("v5") != null) {
				additionalProperties += "&diet=" + request.getParameterValues("v5")[0];
		}
		if(request.getParameterValues("v6") != null) {
				additionalProperties += "&health=" + request.getParameterValues("v6")[0];
		}
		
//		String[] props = request.getParameterValues("restrictions");
//		
//		if(props != null) {
//			for(int i = 0; i < props.length; i++) {
//				System.out.print(props[i] + " ");
//			}
//		}
		
		//String targetPage = "/results.jsp";
		String targetPage = "/home.jsp";
		
		URL url = new URL("https://api.edamam.com/search?q=" + food + "&app_id=278bbd02&app_key=7d60a3510c6faa58ff3b27f73e5b120e"+ additionalProperties);
		BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
		
		URLConnection uc = url.openConnection();
		uc.connect();
		
		JsonParser jp = new JsonParser();
		JsonElement root = jp.parse(new InputStreamReader((InputStream) uc.getContent()));
		JsonObject rootobj = root.getAsJsonObject();
		
		Gson gson = new Gson();
		FoodAPI c = gson.fromJson(rootobj, FoodAPI.class);
		
		if(c == null) {
			targetPage = "/home.jsp";
			request.getSession(false).setAttribute("error", "No Recipes Found");
		}
		else {
			//sort by ingredients the user has
			JDBC jd = new JDBC();
			Fridge f = jd.getFridge((String)request.getSession(false).getAttribute("username"));
			ArrayList<Recipe> bookmarkedRecipes = jd.getBookmarkedRecipes((String)request.getSession(false).getAttribute("username"));
			
			for(int i = 0; i < c.getHits().size(); i++) {
				boolean hit = false;
				for(Recipe r: bookmarkedRecipes) {
					if(r.getName().trim().equalsIgnoreCase(c.getHits().get(i).getRecipe().getLabel().trim())) {
						hit=true;
						break;
					}
				}
				if(hit) {
					c.getHits().get(i).setBookmarked(true);
				} else {
					c.getHits().get(i).setBookmarked(false);
				}
			}
			
			if(f != null) {
				int[] count = new int[c.getHits().size()];
				
				for(int j = 0; j < c.getHits().size(); j++) {
					count[j] = 0;
				}
				
				for(int i = 0; i < c.getHits().size(); i++) {
					for(int j = 0; j < f.getIngredients().size(); j++) {
						for(String s: c.getHits().get(i).getRecipe().getIngredientLines()) {
							if(s.contains(f.getIngredients().get(j))) {
								count[i]++;
							}
						}
					}
				}
					
				for(int i = 0; i < c.getHits().size(); i++) {
					c.getHits().get(i).getRecipe().setIngredientsInCommon(count[i]);
				}
				
				for(int i = 0; i < c.getHits().size()-1; i++) {
					for(int j = i; j < c.getHits().size(); j++) {
						if(count[i] < count[j]) {
							Hit h = c.getHits().get(i);
							c.getHits().set(i, c.getHits().get(j));
							c.getHits().set(j, h);
						}
					}
				}
				
			}
			
		}
		
		
		request.getSession(false).setAttribute("recipes", c);
		request.getSession(false).setAttribute("searched", "true");
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(targetPage);
		dispatch.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
