package SQL;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;

public class Recipe implements Serializable {
	private static final long serialVersionUID = 1L;
	private String name;
	private String url;
	private String imageUrl;
	private int calories;
	private float yield;
	private int ingredientsInCommon;
	private String instructions;
	private ArrayList<String> ingredients = new ArrayList<String>();
	private ArrayList<String> labels = new ArrayList<String>();
	
	//constructors
	public Recipe(String name, String url, String imageUrl, int calories, float yield, int ingredientsIncommon, 
			String instructions, ArrayList<String> ingredients, ArrayList<String> labels) {
		this.setName(name);
		this.setUrl(url);
		this.setImageUrl(imageUrl);
		this.setCalories(calories);
		this.setYield(yield);
		this.setIngredientsInCommon(ingredientsIncommon);
		this.setInstructions(instructions);
		this.setIngredients(ingredients);
		this.setLabels(labels);
	}
	
	public Recipe() {
		
	}
	
	//custom methods
	
	public void addIngredient(String ingredient) {
		ingredients.add(ingredient);
	}
	public void removeIngredient(String ingredient) {
		ingredients.remove(ingredient);
	}
	public void addLabel(String label) {
		labels.add(label);
	}
	public void removeLabel(String label) {
		labels.remove(label);
	}
		
	//getters & setters
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public int getCalories() {
		return calories;
	}
	public void setCalories(int calories) {
		this.calories = calories;
	}

	public ArrayList<String> getIngredients() {
		return ingredients;
	}

	public void setIngredients(ArrayList<String> ingredients) {
		this.ingredients = ingredients;
	}

	public String getInstructions() {
		return instructions;
	}

	public void setInstructions(String instructions) {
		this.instructions = instructions;
	}

	public float getYield() {
		return yield;
	}

	public void setYield(float yield) {
		this.yield = yield;
	}

	public int getIngredientsInCommon() {
		return ingredientsInCommon;
	}

	public void setIngredientsInCommon(int ingredientsInCommon) {
		this.ingredientsInCommon = ingredientsInCommon;
	}

	public ArrayList<String> getLabels() {
		return labels;
	}

	public void setLabels(ArrayList<String> labels) {
		this.labels = labels;
	}

	

}
