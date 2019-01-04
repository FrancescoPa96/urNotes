<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.CheckSession, javax.servlet.http.HttpSession, model.ConnessioneDB, java.sql.*" %>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<% 	
			CheckSession ck = new CheckSession(1, request.getSession());	
			if(ck.getRedirect()){
				String path = request.getContextPath()+ck.getUrlRedirect();
				%>
					<script>
						window.location.href = '<%=path%>';
					</script>
				<%	
			} 
		%>
		<%@ include file="/partials/head.jsp" %>
<title>urNotes | Gestore</title>
</head>
<body>
<%@ include file="/partials/header.jsp" %>
<p> Accesso Effettuato da Gestore</p>
<p>Ciao <%=request.getSession().getAttribute("nome") %> <%=request.getSession().getAttribute("cognome") %>

<%@ include file="/partials/footer.jsp" %>	
</body>
</html>