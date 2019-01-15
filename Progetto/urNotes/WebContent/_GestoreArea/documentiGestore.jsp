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
		<script src="<%=request.getContextPath()%>/js/scripts_documenti_admin.js"></script>					
		<title>urNotes | Aggiungi Documento</title>
</head>

<body onLoad="getDocumenti()">
		<%@ include file="/partials/header.jsp" %>	
		<section class="container_appunti">				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Documenti</p> 
				<table id="documentiTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Titolo Documento</th>
							<th>N° Pagine</th>
							<th>Univerisit&agrave;</th>
							<th>Nome Materia</th>
							<th>Descrizione</th>
							<th>Prezzo</th>
							<th>Tipo</th>
						</tr>	
					</thead>
					<tbody id="bodyDocumento" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiDocumento" class="adminAggiungi">
					<button id="buttonAggiungiDocumento" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiDocumento" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		</section>
	</body>
<%@ include file="/partials/footer.jsp" %>	
</html>