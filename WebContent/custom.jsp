<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "Servlets.*"%>

<%@ page import = "SQL.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/custom.css">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    <title>MyFridge</title>
    <style>
    
   		#results{
			width: 1000px;
			background-color: rgba(220,220,220,.7);
			margin-left: auto;
			margin-right: auto;
			padding-top: 40px;
			margin-top: 30px;
			border-radius: 10px;
			padding-bottom: 40px;
			margin-bottom: 20px;
		}
		
		#resultHead{
			margin-left: auto;
			padding-top: 10px;
			padding-bottom: 5px;
			margin-right: auto;
			margin-top: 30px;
			width: 400px;
			border-radius: 7px;
			text-align: center;
			color: white;
			background-color: rgba(100,130,100,.5);
		}
		
		.recipe{
			padding-left: 23px;
			padding-right: 23px;
			padding-top: 10px;
			padding-bottom: 10px;
			width: 830px; 
			margin-left: auto;
			margin-right: auto;
			background-color: rgb(255,255,255);
			border-radius: 5px;
			margin-bottom: 10px;
			margin-top: 10px;
			position: relative;
		}
		
		.recipe img{
			float: left;
			padding-top: 22px;
			width: 175px;
			border-radius: 5px;
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
		
		#results p{
			text-decoration: none;
			font-size: 1.4em;
			color: white;
			text-decoration: underline lightgrey;
		}
		
		.description{

			height: 180px;
			margin-top: 17px;
			width: 100%;
			/*background-color: forestgreen;*/
			/*background-image: url("Images/GreenBackground2.jpg");*/
			background-color: rgb(100, 204, 61);
			border-radius: 5px;
			padding-top: 20px;
			text-align: center;
			padding-left: 10px;
			padding-right: 10px;
			
		}
		
		.bookmark img {
			width: 7%;
			height: auto;
			position: absolute;
			top: 0px;
			right: 5%;
		}
		
		h1{
			color: white;
			font-size: .9em;
			font-weight: 200;
		}
		p{
			margin-bottom: 0px;
		}
		#colored{
			color: darkgreen;
			font-style: bold;
		}
		
    </style> 
  </head>
  <body>
  	<% 
  	String isLoggedIn = (String)session.getAttribute("log");
	if(isLoggedIn == null || isLoggedIn.trim() == ""){
		isLoggedIn = "false";
	}
  	
  	session.setAttribute("CustomRecipeFridge", null); 
  	String username = "UNDEFINED";
	if(session.getAttribute("username") != null || ((String)session.getAttribute("username")).trim() != ""){
		username = (String)session.getAttribute("username");
	}
	JDBC j = new JDBC();
	
	ArrayList<Recipe> customRecipes = j.getCustomRecipes(username);
	%>

    <nav class="navbar navbar-expand-lg navbar-dark header">
    <a class="navbar-brand logoname" href="home.jsp"><img src="assets/fridgelogo.png" class="logo" alt="logo">MyFridge</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <a class="nav-link" href="home.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="about.jsp">About Us</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#">Donations</a>
        </li>
      </ul>

	  <% if(isLoggedIn.equals("false")){ %>
	      <ul class="nav navbar-nav ml-auto">
	          <li class="nav-item"><a href="register.jsp" class="navbar-nav pull-right nav-link">Register</a></li>
	          <li class="nav-item"><a href="login.jsp" class="navbar-nav pull-right nav-link">Sign in</a></li>
	      </ul>
      <% } %>
      <% if(isLoggedIn.equals("true")){ %>
	      <ul class="nav navbar-nav ml-auto">
	          <li class="nav-item"><a href="profile.jsp" class="navbar-nav pull-right nav-link">Profile</a></li>
	          <li class="nav-item"><a href="ChangeSession" class="navbar-nav pull-right nav-link">Log out</a></li>
	      </ul>
      <% } %>
      
    </div>
  </nav>


<div id = "top">
  <%=username%>'s Custom Recipes
</div>

<div class = "flexbox-container">
  <div class = "flexbox-item-1">
    <form id = "form" action="#" method="#" >
      <input id = "input-bar" type="text" name="ingredient" placeholder="Enter an ingredient's name to add it to your recipe">
    </form>

  <div class = "flexbox-item-2">
    <table id = "dynamic-table" style="list-style: none;">
    </table>
    </div>
  </div>

  <div class = "flexbox-item-3">
    <div class = "final-addition">
      <form id = "form2">
        <input id = "input-bar2" type="text" name="input" placeholder="Enter the title of your custom recipe here.">
      </form>
    </div>

    <textarea id = "big-form" placeholder = "Enter the instructions to make your recipe here"></textarea>
    </div>
  </div>

  <form class = "flexbox-item-4">
    <input type="submit" id = "create-button" type="button" value="Create Recipe!">
  </form>
  
  <div id="customResults">
 	<%if(customRecipes.size()>0){%><div id = "resultHead"><h2>Custom Recipes:</h2></div>
		<div id = "results">
			<% for(Recipe r: customRecipes){ %>
				<div class = "recipe">
					<div class = "description">
						<p><%= r.getName() %></p>
						<h1>Ingredients: <% for(int i = 0; i < r.getIngredients().size(); i++){if(i==r.getIngredients().size()-1){%><%=r.getIngredients().get(i)%><%}else{%><%=r.getIngredients().get(i)%>, <%}}%></h1>											
						<h1>Instructions: <%= r.getInstructions() %></h1>						
					</div>
					<br>
				</div>
				<div class = "clearfloat"></div>
			<% } %>
		</div>
		<%}%>
	</div>


    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  
  	<script>
  		let ingredients = [];
  		let customRecipeSize=<%=customRecipes.size()%>;
  		
		 $(document).on("submit", "#form", function(event) {
			    event.preventDefault(); 
			    
			    var $form = $(this);
			    $form.find('input:text, input:password, input:file, select, textarea').each(function() {
			    	$(this).attr('readonly', true);
			    });
			    $ingredient = $("#input-bar").val();
			    if($ingredient.trim().length>0){
				    $.post('CustomRecipeServletAdd', { ingredient : $ingredient }, function(response) {
				    		ingredients.push($ingredient);
				    		$("#dynamic-table").append('<tr><td><i class="fas fa-trash-alt delete" style="cursor:pointer;" name="ingredient" value="'+$ingredient+'"></i> '+$ingredient+' </td></tr>')
				            $("#input-bar").val('');
				    	$form.find('input:text, input:password, input:file, select, textarea').each(function() {
					    	$(this).attr('readonly', false);
					    });
				    });
			    } else {
			    	$form.find('input:text, input:password, input:file, select, textarea').each(function() {
				    	$(this).attr('readonly', false);
				    });
			    }
			    event.preventDefault(); 
		});
		 
		$(document).on('click','.delete',function(event){
			 event.stopPropagation();
			 $li = $(this).parent();
			 $.post('CustomRecipeServletRemove', { ingredient : $(this).attr("value") }, function(response) {
				 $li.parent().fadeOut(500,function(){
					    $li.remove();
				});	
			 });
		});
		 
		 $(document).on("submit", ".flexbox-item-4", function(event) {
			 	event.preventDefault(); 
			   
			 	$("#input-bar").attr('readonly', true);
			   	$("#input-bar2").attr('readonly', true);
			   	$("#big-form").attr('readonly', true);
			   	
			    $title = $("#input-bar2").val().trim();
		    	$instructions = $("#big-form").val().trim();
		    	if($title.length>0 && $instructions.length>0){
				    $.post('CustomRecipeServletSubmit', {title:$title,instructions:$instructions}, function(response) {
			    		$("#input-bar").attr('readonly', false);
			    		$("#input-bar2").attr('readonly', false);
					   	$("#big-form").attr('readonly', false);
					   	if(customRecipeSize==0){
					   		$("#customResults").append('<div id = "resultHead"><h2>Custom Recipes:</h2></div>');
					   		$("#customResults").append('<div id = "results">');
					   	}
						
						let $ingredientList = "Ingredients: ";
						for(let i = 0; i < ingredients.length; i++){
							if(i==ingredients.length-1){
								$ingredientList+=ingredients[i];
							} else {
								$ingredientList+=ingredients[i];
								$ingredientList+=", ";
							}
						}
						
						$("#results").append('<div class = "recipe"><div class = "description"><p>'
								+$title+'</p><h1>'
								+$ingredientList+'</h1><h1>Instructions: '
								+$instructions+'</h1></div><br></div><div class = "clearfloat"></div>');
						
					   	
					   	if(customRecipeSize==0){
					   		$("#customResults").append('</div');
					   	}
					   	
					   	$("#dynamic-table tr").remove();
					    $("#input-bar").val('');
					    $("#input-bar2").val('');
				    	$("#big-form").val('');
				    	ingredients = [];
				    });
		    	} else {
		    		$("#input-bar").attr('readonly', false);
		    		$("#input-bar2").attr('readonly', false);
				   	$("#big-form").attr('readonly', false);
		    	}
		});
		 
        </script>
  
  </body>
</html>
