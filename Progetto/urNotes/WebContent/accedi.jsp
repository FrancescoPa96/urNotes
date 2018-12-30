<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB, java.sql.*"%>
<!DOCTYPE html>
<html lang = "it">

<head>
<%@ include file="/partials/head-accesso.jsp" %>	
<script src="<%=request.getContextPath()%>/js/scripts_accedi.js"></script>				
<title>urNotes | Accedi</title>
</head>

<body>

<div class="loginbox">


<form action="#" method="POST" id="formAccedi">					
				    <fieldset>
				        <legend>Username</legend>
				        <input type="text" id="Username" name="Username" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Password</legend>
				        <input type="password" id="Password" name="Password" class="campoForm" />
				    </fieldset>					
				    
					<input type="submit" id="submitForm" name="submitForm" class="campoForm submitForm" value="Accedi" />				
				</form>
 
</div>

</body>
</html>
