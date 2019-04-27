<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="Servlets.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
		<title>Fridge Backend</title>
		  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    	  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
	</head>
	
	<body>
	
		<form id="fridgeForm" action="FridgeServletAdd" method="post">
    		Ingredient: <input type="text" id="ingredient" name="ingredient"/><br>
    	</form>
    	<h2>Fridge:</h2>
    	<ul id="list" style="list-style: none;">
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