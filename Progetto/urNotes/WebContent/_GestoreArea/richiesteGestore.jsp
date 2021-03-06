<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.CheckSession, javax.servlet.http.HttpSession" %>
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
		<script src="<%=request.getContextPath()%>/js/scripts_richieste_admin.js"></script>		
		<script src="<%=request.getContextPath()%>/js/scripts_richiesta.js"></script>		
		<script src="<%=request.getContextPath()%>/js/scripts_upload_file.js"></script>		
					
		<title>urNotes | Richieste</title>		
	</head>
	<body onLoad="getRichieste()">
		<%@ include file="/partials/header.jsp" %>				
	<div id="container_richieste_admin">	
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Richieste</p> 
				<table id="prodottiTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th class="row_title">Data</th>
							<th class="row_title">Studente</th>
							<th class="row_title">Titolo</th>
							<th class="row_title">Pagine</th>
						    <th class="row_title">Materia</th>
							<th class="row_title">Universita</th>
							<th class="row_title">Descrizione</th>
							<th class="row_title">Tipo</th>
							<th class="row_title">Azioni</th>
						</tr>	
					</thead>
					<tbody id="bodyRichieste" class="adminBodyDataTable">
						
					</tbody>
				</table>
				<div id="aggiungiDocumento" class="adminAggiungi">
			
					<button id="buttonAggiungiDocumento" class="adminButtonAggiungi"><i class="fas fa-plus" style="cursor: pointer;" title="Aggiungi Documento"></i></button>
				</div>
								
				<div id="formAggiungiDocumento" class="adminFormAggiungi" style="display: none;">
				
				</div>							
			</div>
		</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>