<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "com.FoodAPI.*" %>
    
<!DOCTYPE html>

<html>
	<head>
	
		<meta charset="ISO-8859-1">
		<title>MyFridge</title>
		
		<link href="https://fonts.googleapis.com/css?family=Josefin+Slab" rel="stylesheet">
		<link rel="stylesheet" href="css/style.css">
		
		<style>
		
			body{
				font-family: "Gill Sans", sans-serif;
			}
		
			#background{
				background-image: url(Images/blueberries.jpg);
				background-position: center; 
			    background-repeat: no-repeat;
			    height: 100%;
				width: 100%;
			    position: fixed;
			    top: 0px;
			    left: 0px;
			    z-index: -2;
			    background-size: cover;
			}
		
			#results{
				width: 1000px;
				background-color: rgba(220,220,220,.7);
				margin-left: auto;
				margin-right: auto;
				padding-top: 40px;
				margin-top: 150px;
				border-radius: 10px;
				padding-bottom: 40px;
				margin-bottom: 20px;
			}
			
			.recipe{
				padding: 50px;
				padding-top: 10px;
				padding-bottom: 10px;
				width: 800px; 
				margin-left: auto;
				margin-right: auto;
				background-color: rgb(255,255,255);
				border-radius: 5px;
				margin-bottom: 10px;
				margin-top: 10px;
			}
			
			.recipe img{
				float: left;
				padding-top: 16px;
				width: 200px;
				height: auto;
			}
			
			a{
				text-decoration: none;
			}
			
			#results a{
				text-decoration: none;
				font-size: 1.4em;
				color: white;
				text-decoration: underline lightgrey;
			}
			
			.description{
				margin-left: 220px;
				height: 180px;
				margin-top: 17px;
				width: 560px;
				/*background-color: forestgreen;*/
				background-image: url("Images/GreenBackground2.jpg");
				border-radius: 5px;
				padding-top: 20px;
				text-align: center;
				
			}
			
		</style>
		
	</head>
	<body>
	
		<div id = "background"></div>
	
		<div id = "header">
			<a href = "homepage.jsp"><span id = "logo"><img src = "Images/Fridge.png"></span>
			<span id = "name"><h1>MyFridge</h1></span></a>
		</div>
	
		<% FoodAPI c = (FoodAPI)session.getAttribute("recipes"); %>
	
		<div id = "results">
			<% for(int x = 0; x < c.getHits().size(); x++){ %>
				<div class = "recipe">
					<img src = "<%= c.getHits().get(x).getRecipe().getImage() %>">
					<div class = "description">
						<p><a href = "<%= c.getHits().get(x).getRecipe().getUrl() %>"><%= c.getHits().get(x).getRecipe().getLabel() %></a></p>
						<p></p>
					</div>
					
					<br>
				</div>
				<div class = "clearfloat"></div>
			<% } %>
		</div>
		
	</body>
</html>