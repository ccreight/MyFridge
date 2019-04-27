<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "Servlets.*"%>

<%@ page import = "SQL.*" %>
<%@ page import = "com.FoodAPI.*" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/login.css">
    <title>MyFridge</title>
  </head>
  <body>

	<%
	session.setAttribute("searched", "false");

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

    <div class="container">
      <div class= "col1">
        <div class="col1-content1">
          <img style="width: 50px; height: 50px;"src="assets/food-icon.png"></img>
          <p>Log in to allow the storage of ingredients that you have at home with just the click of a button!</p>
        </div>
        <div class="col1-content2">
          <img style="width: 50px; height: 50px;"src="assets/mag-glass.png"></img>
          <p>Searches will become individualized to what you already have, making it less costly for you.</p>
        </div>
        <div class="col1-content3">
          <img style="width: 50px; height: 50px;"src="assets/gear.png"></img>
          <p>As additional features, you'll also be able to bookmark recipes and write your own for safe-keeping.</p>
        </div>

      </div>

      <div class = "col2">
        <img class="loginIcon"src="assets/food-icon.png"></img>
        <p id="loginText" class="loginTextText">Login</p>
        <div class="signInForm">
          <form action = "VerifyLogin" method = "POST">
	          <p id="loginText">Username</p>
	          <input class="username"  name = "username" type="text" placeholder="Username" aria-label="Username" onfocus='if(this.placeholder=="Username"){this.placeholder="";}' onfocusout='if(this.placeholder==""){this.placeholder="Username";}'>
	          <p id="loginText" class="passwordText">Password</p>
	          <input class="password"  name = "password" type="password" placeholder="Password" aria-label="Password" onfocus='if(this.placeholder=="Password"){this.placeholder="";}' onfocusout='if(this.placeholder==""){this.placeholder="Password";}'>
	          <button type="submit" class="submitButton">Log In</button>
	      </form>
        </div>
      </div>
    </div>



    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>