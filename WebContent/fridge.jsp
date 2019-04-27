<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "Servlets.*"%>

<%@ page import = "SQL.*" %>
<%@ page import = "com.FoodAPI.*" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/fridge.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

    <title>MyFridge</title>
  </head>
  <body>
  
  <%
	String isLoggedIn = (String)session.getAttribute("log");
	if(isLoggedIn == null || isLoggedIn.trim() == ""){
		isLoggedIn = "false";
	}
	
	String username = "UNDEFINED";
	if(session.getAttribute("username") != null || ((String)session.getAttribute("username")).trim() != ""){
		username = (String)session.getAttribute("username");
	}
	JDBC j = new JDBC();
	Fridge f = j.getFridge(username);
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

  <div class="container">
    <p class="fridgeText"><%=username%>'s Fridge</p>
    <div class="todoWrapper">
      <p class="todoHeader">Ingredient in the Fridge</p>
      <div class="todoInput">
        <form id="fridgeForm" action="FridgeServletAdd" method="post">
          <input  type="text" id="ingredient" name="ingredient" placeholder="Add an ingredient here" maxlength="37" autocomplete="off">
        </form>
      </div>
      <ul id="list" style="list-style: none;background-color:white;">
      	<%
      	if(f!=null) {
	      	for(String s: f.getIngredients()){%>
	        <li><i class="fas fa-trash-alt delete" style="cursor:pointer;" name="ingredient" value="<%=s%>"></i><%=s%></li>
        <%}}%>
      </ul>
    </div>
  </div>
    
    	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		 <script>
	
		 
		 $(document).on("submit", "#fridgeForm", function(event) {
			    var $form = $(this);
			    $form.find('input:text, input:password, input:file, select, textarea').each(function() {
			    	$(this).attr('readonly', true);
			    });
			    $ingredient = $("#ingredient").val();
			    if($ingredient.trim().length>0) {
				    $.post($form.attr("action"), $form.serialize(), function(response) {	
			    		$("#list").append('<li><i class="fas fa-trash-alt delete" style="cursor:pointer;" name="ingredient" value="'+$ingredient+'"></i> '+$ingredient+' </li>')
			            $("#ingredient").val('');
				    		
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
			 $(this).addClass("clicked");
			 event.stopPropagation();
			 $li = $(this);
			 $.post('FridgeServletDelete', { ingredient : $(this).attr("value") }, function(response) {
				 $li.parent().fadeOut(500,function(){
					    $li.remove();
				});	
			 });
			 event.preventDefault(); 
		});
		 
        </script>

  </body>
</html>
