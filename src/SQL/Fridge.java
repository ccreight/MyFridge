package SQL;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;

public class Fridge implements Serializable {
	private static final long serialVersionUID = 1L;
	private ArrayList<String> ingredients = new ArrayList<String>();
	
	//constructors
	public Fridge(ArrayList<String> fridge) {
		this.ingredients=fridge;
	}
	public Fridge() {
		
	}
	
	//custom methods
	public void addIngredient(String s) {
		ingredients.add(s);
	}
	public void removeIngredient(String s) {
		//ingredients.removeAll(Collections.singleton(s));
		ingredients.remove(s);
	}
	
	//getters & setters
	public ArrayList<String> getIngredients() {
		return ingredients;
	}
	public void setIngredients(ArrayList<String> ingredients) {
		this.ingredients = ingredients;
	}

}
