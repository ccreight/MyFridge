<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "Servlets.*"%>

<%@ page import = "SQL.*" %>
<%@ page import = "com.FoodAPI.*" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/about.css">
    <title>MyFridge</title>
  </head>
  <body>
  
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


<div id = "top">
  About Us
</div>




  <div id = "about-us">
    <div id = "title-1">
      About Us
    </div> </br> </br>
     MyFridge provides a way for users to both reduce their personal food waste and search for recipes based on the ingredients that they have at home. 
  </br> </br>



    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>
