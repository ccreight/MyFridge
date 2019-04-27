<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="Servlets.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
		<title>Fridge Backend</title>
		  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    	  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
	<% session.setAttribute("CustomRecipeFridge", null); %>
	</head>
	
	<body>
	
		<form id="fridgeForm" action="CustomRecipeServletAdd" method="post">
    		Ingredient: <br><input type="text" id="ingredient" name="ingredient"/><br>
    	</form>
    	<h2>Fridge:</h2>
    	<ul id="list" style="list-style: none;">
    	</ul>
    	<form id="customRecipeForm" action="#" method="post">
    		Title: <br><input type="text" id="title" name="title"/><br>
    		Instructions: <br><textarea type="text" id="instructions" name="instructions" style="width:250px;height:125px;"></textarea><br>
    		<input type="submit" value="Submit">
    	</form>
    	<h2>Custom Recipes:</h2>
    	<ul id="list2" style="list-style: none;">
    	</ul>
	
	
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
			    if($ingredient.trim().length>0){
				    $.post('CustomRecipeServletAdd', $form.serialize(), function(response) {
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
			 event.stopPropagation();
			 $li = $(this);
			 $.post('CustomRecipeServletRemove', { ingredient : $(this).attr("value") }, function(response) {
				 $li.parent().fadeOut(500,function(){
					    $li.remove();
				});	
			 });
			 event.preventDefault(); 
		});
		 
		 $(document).on("submit", "#customRecipeForm", function(event) {
			    var $form = $(this);
			    $form.find('input:text, input:password, input:file, select, textarea').each(function() {
			    	$(this).attr('readonly', true);
			    });
			    $title = $("#title").val();
		    	$instructions = $("#instructions").val();
		    	if($title.trim().length>0 && $instructions.trim().length>0){
				    $.post('CustomRecipeServletSubmit', $form.serialize(), function(response) {
			    		$("#list2").append('<li>' + $title + " : " + $instructions +' </li>')
			           	$("#title").val('');
			    		$("#instructions").val('');
			    		$("#list").empty();
			    		
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
		 
        </script>
	</body>
</html>