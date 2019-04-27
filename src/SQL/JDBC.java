package SQL;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class JDBC {

	/* [--------COMPLETE--------] */
	public String validation(String u, String p) {
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM Users WHERE username=? AND password=?");
			ps.setString(1,  u); //specifies that first ? should be the fname from request
			ps.setString(2, p);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				return "success";
			}
			else {
				rs.close();
				ps.close();
				conn.close();
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
				ps = conn.prepareStatement("SELECT * FROM Users WHERE username=?");
				ps.setString(1,  u); //specifies that first ? should be the fname from request
				rs = ps.executeQuery();
				
				if(rs.next()) {
					return "Incorrect Password";
				}
				else {
					return "Username Does Not Exist";
				}
			}
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return "";
		
	}
	
	/* [--------COMPLETE--------] */
	/*
	public String addCustomRecipe(String u, String rn, String ing, String st) {
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		if(rn == null || rn == "" || ing == null || ing == "" || st == null || st == "") {
			return "Invaild Input Values";
		}
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			Statement s = conn.createStatement();
			s.executeUpdate("INSERT INTO CustomRecipes(username,recipeName,ingredients,steps) VALUES ('" + u + "','" + rn  + "','" + ing  + "','" + st + "');");
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return "success";
		
	}
	*/
	
	/* [--------COMPLETE--------] */
	public String registerUser(String u, String p1, String p2) {
		
		/*if(!p1.equals(p2)) {
			return "Passwords Do Not Match";
		}
		
		if(u.length() <= 4) {
			return "Username Must Be Longer Than 4 Characters";
		}
		
		if(p1.length() < 8) {
			return "Password Must Be At Least 8 Characters";
		}*/
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null; //stores the table returned by SELECT
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM Users WHERE username=?");
			ps.setString(1,  u); //specifies that first ? should be the fname from request
			rs = ps.executeQuery();
			
			if(rs.next()) {
				rs.close();
				ps.close();
				conn.close();
				return "Username Already Exists";
			}
			else {
				rs.close();
				ps.close();
				conn.close();
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
				Statement s = conn.createStatement();
				s.executeUpdate("INSERT INTO Users(username,password) VALUES ('" + u + "','" + p1 + "');");
			}
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return "success";
		
	}
	
	/* [--------COMPLETE--------]
	 * returns a Vector where each String is a recipe:
	 * 		Each component (name, steps) is separated with "|",
	 * 		each step / ingredient should be separated with "/" by user */
	/*
	public Vector<String> getCustomRecipes(String u) {
		
		Vector<String> v = new Vector<String>();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null; //stores the table returned by SELECT
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM CustomRecipes WHERE username=?");
			ps.setString(1,  u);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				String recipe = "" + rs.getString("recipeName") + "|" + rs.getString("ingredients") + "|" + rs.getString("steps");
				
				if(recipe != null) {
					v.add(recipe);
				}
				
			}
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return v;
		
	}
	*/
	
	/*
	public void addIngredient(String u, String ing) {
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			Statement s = conn.createStatement();
			
			//GOTTA ACCOUNT FOR IF INGREDIENT ALREADY EXISTS
			s.executeUpdate("INSERT INTO Ingredients(username,ingredientName) VALUES ('" + u + "','" + ing + ")");
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
	}
	*/
	
	/*
	public Vector<String> getIngredients(String u) {
		
		Vector<String> v = new Vector<String>();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null; //stores the table returned by SELECT
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM Ingredients WHERE username=?");
			ps.setString(1,  u);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				String ing = rs.getString("ingredientName");
				
				if(ing != null) {
					v.add(ing);
				}
				
			}
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return v;
		
	}
	*/
	
	public void addFridge(String username, Object fridge){
			
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			try {
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
				ps = conn.prepareStatement("INSERT INTO fridge(username,fridgeObject) VALUES(?,?) ON DUPLICATE KEY UPDATE fridgeObject=?;");
				ps.setString(1, username);
				ps.setObject(2, fridge);
				ps.setObject(3, fridge);
				ps.executeUpdate();
				
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} catch(ClassNotFoundException cnfe) {
				System.out.println("cnfe: " + cnfe.getMessage());
			} finally {
				try {
					if(rs != null) {
						rs.close();
					}
					if(ps != null) {
						ps.close();
					}
					if(conn != null) {
						conn.close();
					}
				} catch(SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
			
	}
	
	public Fridge getFridge(String username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("SELECT fridgeObject FROM fridge WHERE username=?;");
			ps.setString(1, username);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				byte[] buf = rs.getBytes(1);
				ObjectInputStream objectIn = null;
				if (buf != null) { objectIn = new ObjectInputStream(new ByteArrayInputStream(buf)); }
				Object deSerializedObject = objectIn.readObject();
				return (Fridge)deSerializedObject;
			} else {
				System.out.println(username +" does not have a fridge.");
				return new Fridge();
			}
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} catch (IOException ioe){
			System.out.println("ioe: " + ioe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return new Fridge();
	}
	
	public void addCustomRecipes(String username, Object recipes){
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("INSERT INTO customRecipes(username,customRecipesObject) VALUES(?,?) ON DUPLICATE KEY UPDATE customRecipesObject=?;");
			ps.setString(1, username);
			ps.setObject(2, recipes);
			ps.setObject(3, recipes);
			ps.executeUpdate();
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
			
	}

	public ArrayList<Recipe> getCustomRecipes(String username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("SELECT customRecipesObject FROM customRecipes WHERE username=?;");
			ps.setString(1, username);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				byte[] buf = rs.getBytes(1);
				ObjectInputStream objectIn = null;
				if (buf != null) { objectIn = new ObjectInputStream(new ByteArrayInputStream(buf)); }
				Object deSerializedObject = objectIn.readObject();
				return (ArrayList<Recipe>)deSerializedObject;
			} else {
				System.out.println(username +" does not have custom recipes.");
				return new ArrayList<Recipe>();
			}
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} catch (IOException ioe){
			System.out.println("ioe: " + ioe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return new ArrayList<Recipe>();
	}

	public void addBookmarkedRecipes(String username, Object recipes){
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("DELETE FROM bookmarkedRecipes WHERE username=?;");
			ps.setString(1, username);
			ps.executeUpdate();
			if(ps != null) {
				ps.close();
			}
			ps = conn.prepareStatement("INSERT INTO bookmarkedRecipes(username,bookmarkedRecipesObject) VALUES(?,?);");
			ps.setString(1, username);
			ps.setObject(2, recipes);
			ps.executeUpdate();
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
	}

	public ArrayList<Recipe> getBookmarkedRecipes(String username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyFridge?user=root&password=root");
			ps = conn.prepareStatement("SELECT bookmarkedRecipesObject FROM bookmarkedRecipes WHERE username=?;");
			ps.setString(1, username);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				byte[] buf = rs.getBytes(1);
				ObjectInputStream objectIn = null;
				if (buf != null) { objectIn = new ObjectInputStream(new ByteArrayInputStream(buf)); }
				Object deSerializedObject = objectIn.readObject();
				return (ArrayList<Recipe>)deSerializedObject;
			} else {
				System.out.println(username +" does not have bookmarked recipes.");
				return new ArrayList<Recipe>();
			}
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} catch (IOException ioe){
			System.out.println("ioe: " + ioe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return new ArrayList<Recipe>();
	}
	
	public static void main(String[] args) {
		Fridge fridge = new Fridge();
		fridge.addIngredient("pancake mix");
		fridge.addIngredient("butter");
		fridge.addIngredient("syrup");
		
		JDBC j = new JDBC();
		j.addFridge("root", fridge);
		Fridge fridge2 = j.getFridge("root");
		
		for(String ingredient: fridge2.getIngredients()) {
			System.out.println(ingredient);
		}
	}
	
}
