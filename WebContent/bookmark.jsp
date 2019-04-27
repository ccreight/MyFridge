<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "Servlets.*"%>

<%@ page import = "SQL.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.FoodAPI.*" %>
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
			width: 200px;
			border-radius: 7px;
			text-align: center;
			color: white;
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
	
	ArrayList<SQL.Recipe> bookmarkedRecipes = j.getBookmarkedRecipes(username);
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
  <%=username%>'s Bookmarked Recipes
</div>

		<div id = "resultHead"></div>

		<%if(bookmarkedRecipes.size()>0){%><div id = "results"><%}%>
			<% for(SQL.Recipe r: bookmarkedRecipes){ %>
				<div class = "recipe">
					<img class="img" src = "<%=r.getImageUrl()%>">
					<div class = "description">
						<p><a class="title" href = "<%=r.getUrl()%>"><%=r.getName()%></a></p>
						
						<h1>Calories: <span class="calories"><%=r.getCalories()%></span>    Yields: <span class="yield"><%=r.getYield()%></span></h1>
						
						<h1 class="ingredients"><%=r.getIngredients().get(0)%></h1>
						
						<h1 class="labels"><%=r.getLabels().get(0)%></h1>
						
						<% if(isLoggedIn.equals("true")){ %>
							<div class = "bookmark">
								<img src = "Images/bookmarked.png" style="cursor:pointer;" class="bookmarkImg">
							</div>
							<h1 id = "colored"><span class="ingredientsInCommon"><%=r.getIngredientsInCommon()%></span> ingredients in common</h1>
						<% } %>
						
					</div>
					
					<br>
				</div>
				<div class = "clearfloat"></div>
			<% } %>
		<%if(bookmarkedRecipes.size()>0){%></div><%}%>
		
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