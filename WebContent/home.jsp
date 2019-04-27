<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "Servlets.*"%>

<%@ page import = "SQL.*" %>
<%@ page import = "com.FoodAPI.*" %>
    
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/main.css">
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
			margin-top: 75px;
			width: 200px;
			border-radius: 7px;
			text-align: center;
			color: white;
			background-color: rgba(100,130,100,.5);
		}
		
		.recipe{
			padding-left: 23px;
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
		
		.description{
			margin-left: 220px;
			height: 180px;
			margin-top: 17px;
			width: 560px;
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
			top: 7px;
			left: 5px;
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- JQUERY code to hide/show the dropdown -->
    <script>
      $(document).ready(function(){
        $("#hide").click(function(){
          $("#dropDownWrapper").hide();
          $(".form-control").css("border-bottom-color","#64CC3D");
          $(".form-control").css("border-radius","20px");
          $(".iconDown").css('display','block');
        });
        $("#show").click(function(){
          $("#dropDownWrapper").show();
          $(".form-control").css("border-bottom-left-radius","0px");
          $(".form-control").css("border-bottom-right-radius","0px");
          $(".form-control").css("border-bottom-color","black");
          $(".iconDown").css('display','none');
        });
      });
    </script>

	<%
	
		String isLoggedIn = (String)session.getAttribute("log");
		if(isLoggedIn == null || isLoggedIn.trim() == ""){
			isLoggedIn = "false";
		}
	
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


  <!-- Search form -->
  <div class="d-flex justify-content-center align-items-center">
      <div id="formid" class="formWrapper">
        <!-- Form -->
        <form class="submitForm" action="ParseSearch" method="POST" >
          <input class="form-control" id="food" type="text" name="food" placeholder="What recipe are you looking for?" aria-label="Search">
          <!-- drop down icon -->
          <button type=button id="show" class="iconDown"></button>
          
            <!-- checkbox/dropdown div -->
		  <div class="d-flex justify-content-center align-items-center">
		    <!-- drop down wrapper -->
		    <div id="dropDownWrapper">
		      <!-- dropdown div -->
		        <div id="dropdown" class="dropdown">
		
		          <div id="containe" class="container1">
		              <!-- Left Checkboxes -->
		              <div class="checkbox">
		                  <input type="checkbox" id="checkbox1" name="v1" value="vegetarian">
		                  <label for="checkbox1"><span>Vegetarian</span></label>
		              </div>
		              <div class="checkbox">
		                 <input type="checkbox" id="checkbox2" name="v2" value="vegan">
		                 <label for="checkbox2"><span>Vegan</span></label>
		              </div>
		              <div class="checkbox">
		                 <input type="checkbox" id="checkbox3" name="v3" value="low-fat">
		                 <label for="checkbox3"><span style="width: 100px;">Low-Fat</span></label>
		              </div>
		          </div>
		          <!-- Right Checkboxes -->
		          <div class="container2">
		              <div class="checkbox">
		                <input type="checkbox" id="checkbox4" name="v4" value="low-carb">
		                <label for="checkbox4"><span style="width: 100px;">Low-Carb</span></label>
		              </div>
		              <div class="checkbox">
		                <input type="checkbox" id="checkbox5" name="v5" value="high-protein">
		                <label for="checkbox5"><span style="width: 200px;">High Protein</span></label>
		              </div>
		              <div class="checkbox">
		                <input type="checkbox" id="checkbox6" name="v6" value="peanut-free">
		                <label for="checkbox6"><span style="width: 200px;">No Peanuts</span></label>
		              </div>
		          </div>
		          <!-- Hide the dropdown Icon-->
		          <button id="hide" class="iconUp"></button>
		        </div>
		   	 </div>
		    </div>
          
        </form>
      </div>
  </div>


	<%
		FoodAPI c = (FoodAPI)session.getAttribute("recipes");
		String hasSearched = (String)session.getAttribute("searched");
		String error = (String)session.getAttribute("error");
		                		
		if(hasSearched != null && c != null && !c.getHits().isEmpty() && hasSearched.equals("true") && error == null && (error != null || error != "No Recipes Found")){
			
	%>
	
		<div id = "resultHead"><h2>Results</h2></div>
	
		<div id = "results">
			<% for(int x = 0; x < c.getHits().size(); x++){ %>
				<div class = "recipe">
					<img class="img" src = "<%= c.getHits().get(x).getRecipe().getImage() %>">
					<div class = "description">
						<p><a class="title" href = "<%= c.getHits().get(x).getRecipe().getUrl() %>"><%= c.getHits().get(x).getRecipe().getLabel() %></a></p>
						
						<% if(c.getHits().get(x).getRecipe().getCalories() != null){ %><h1>Calories: <span class="calories"><%= c.getHits().get(x).getRecipe().getCalories().intValue() %></span>    <% if(c.getHits().get(x).getRecipe().getYield() != null){ %>Yields: <span class="yield"><%=c.getHits().get(x).getRecipe().getYield()%></span><% } %></h1><% } %>
						
						<h1 class="ingredients"><% for(int i = 0; i < c.getHits().get(x).getRecipe().getIngredientLines().size() && i < 4; i++){%><%= c.getHits().get(x).getRecipe().getIngredientLines().get(i) %><% if(i == 3){ %>... <% } else if(i == c.getHits().get(x).getRecipe().getIngredientLines().size()-1){ %><%} else{%>, <% } } %></h1>
						
						<h1 class="labels"><% for(int i = 0; i < c.getHits().get(x).getRecipe().getDietLabels().size(); i++){ %><%=c.getHits().get(x).getRecipe().getDietLabels().get(i)%>, <% } for(int i = 0; i < c.getHits().get(x).getRecipe().getHealthLabels().size(); i++){ %><%= c.getHits().get(x).getRecipe().getHealthLabels().get(i) %><% if(i != c.getHits().get(x).getRecipe().getHealthLabels().size()-1){ %>, <% }} %></h1>
						
						<% if(isLoggedIn.equals("true")){ %>
							<div class = "bookmark">
								<%if(c.getHits().get(x).getBookmarked()){%>
								<img src = "Images/bookmarked.png" style="cursor:pointer;" class="bookmarkImg">
								<%}else{%>
								<img src = "Images/not_bookmarked.png" style="cursor:pointer;" class="bookmarkImg">
								<%}%>
							</div>
							<h1 id = "colored"><span class="ingredientsInCommon"><%= c.getHits().get(x).getRecipe().getIngredientsInCommon() %></span> ingredients in common</h1>
						<% } %>
						
					</div>
					
					<br>
				</div>
				<div class = "clearfloat"></div>
			<% } %>
		</div>
		
	<% } %>

	<%
		hasSearched = "false";
	%>


  <!-- Script for submitting the form-->
  <script>
    $('form.submitForm').on('submit',function(){
      var that = $(this),
        url = that.attr('action'),
        method = that.attr('method'),
        data ={};
        //If you're reading this dont laugh at my code
        //didnt feel like grouping everything and then using a loop lol
        data["search"] = document.getElementById("form-control").value;
        data["option1"] = document.getElementById('checkbox1').checked;
        data["option2"] = document.getElementById('checkbox2').checked;
        data["option3"] = document.getElementById('checkbox3').checked;
        data["option4"] = document.getElementById('checkbox4').checked;
        data["option5"] = document.getElementById('checkbox5').checked;
        data["option6"] = document.getElementById('checkbox6').checked;
        //Ajax submiting form
        /*
          $.ajax({
            url: url,
            type: type,
            data: data,
            success: function(response){
                console.log(response);
            }
          });
        */
      return false;
    });
  </script>
  
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <script>
 
    
    $(".bookmarkImg").on('click',function(){
    	event.preventDefault(); 
    	$bookmarkImg = $(this);
    	$description = $(this).parent().parent();
    	$recipe = $(this).parent().parent().parent();
    	
    	if($bookmarkImg.attr('src')=='Images/not_bookmarked.png'){
	    	$imageUrl = $recipe.find(".img").attr("src");
	    	//console.log($imageUrl);
	    	$url = $description.find(".title").attr("href");
	    	//console.log($url);
	    	$title = $description.find(".title").text();
	    	//console.log($title);
	    	$calories = $description.find(".calories").text();
	    	//console.log($calories);
	    	$yield = $description.find(".yield").text();
	    	//console.log($yield);
	    	$ingredients = $description.find(".ingredients").text();
	    	//console.log($ingredients);
	       	$labels = $description.find(".labels").text();
	    	//console.log($labels);
	    	$ingredientsInCommon = $description.find(".ingredientsInCommon").text();
	    	//console.log($ingredientsInCommon);
	    	
	    	$.post('BookmarkServletAdd', { imageUrl:$imageUrl, url:$url, title:$title, calories:$calories, yield:$yield,
	    		ingredients:$ingredients, labels:$labels, ingredientsInCommon:$ingredientsInCommon }, function(response) {
	    		$bookmarkImg.attr("src","Images/bookmarked.png");
	    	});
    	} else {
    		$title = $description.find(".title").text();
    		$.post('BookmarkServletRemove', { title:$title }, function(response) {
	    		$bookmarkImg.attr("src","Images/not_bookmarked.png");
	    	});
    	}
    	
    	
    });
    
    </script>
  </body>
</html>