<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="connection.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<script src="<%=request.getContextPath()%>/js/scripts_prodotto_dettaglio.js"></script>
		<script src="<%=request.getContextPath()%>/js/scripts_appunti.js"></script>
		<script src="<%=request.getContextPath()%>/js/scripts_recensione.js"></script>
		<title>urNotes | Dettagli</title>		
	</head>
	<body onload="getRecensione()">
		<%@ include file="/partials/header.jsp" %>		
			<section class="container_appunti_dettaglio">	
		<div id="content">
			<div id="content-content">

			        <%
			        String output = "";
		        	String sql = "";
		        	String filename = "";
		        	String immaginePrincipale = "";
		        	String immagini = "";
		        	String titoloDocumento = "";
		        	Integer pagine = 0;
		        	String universita = "";
		        	String descrizione = "";
		        	String prezzoDocumento = "";
		        	String materiaDocumento = "";
			        try{
			        	 Integer codice = Integer.parseInt(request.getParameter("codice"));
			        				        	
				        	ConnessioneDB connDB = new ConnessioneDB();
							if(connDB.getConn() != null) {
								try {
									Statement stmt = connDB.getConn().createStatement();							
									sql = ""
											+ "SELECT d.codice," 
											+ "       d.titolo, "
											+ "       d.pagine, "
											+ "       d.universita, "									
											+ "       d.nome_materia, "									
											+ "       d.descrizione, " 
											+ "       d.prezzo, " 
											+ "       (SELECT nome FROM materie WHERE nome = d.nome_materia) AS materie, "
											+ "       (SELECT filename FROM documenti_immagini WHERE codice = d.codice AND is_default = 1 AND attivo = 1) AS filename "
											+ "FROM documenti AS d "
											+ "WHERE d.flag = 1 AND d.codice = "+codice+" ";
									ResultSet result = stmt.executeQuery(sql);								
									if(!result.wasNull()) {
										int rowCount = result.last() ? result.getRow() : 0;
										if(rowCount > 0) {
											result.beforeFirst();										
											while(result.next()) {																
												if(result.getString("filename") != null){
													filename = new SystemInformation().getPathImmaginiDocumentoHTML()+result.getInt("codice")+"/"+result.getString("filename");												
												}
												else{
													filename = new SystemInformation().getPathImmaginiDocumentoDefault();												
												}																						
												immaginePrincipale = "<img class='showImmagineDocumento' src='"+filename+"' alt='"+filename+"' />";		
												
												titoloDocumento = result.getString("titolo");													
												pagine = result.getInt("pagine");
												universita = result.getString("universita");
												descrizione = result.getString("descrizione");
												prezzoDocumento = result.getString("prezzo");
												materiaDocumento = result.getString("nome_materia");									
												Statement stmt2 = connDB.getConn().createStatement();							
												sql = ""
														+ "SELECT filename " 
														+ "FROM documenti_immagini "
														+ "WHERE codice = "+codice+" AND is_default = 0 AND attivo = 1 " 
														+ "ORDER BY id_immagine DESC; "; 
												ResultSet result2 = stmt2.executeQuery(sql);								
												if(!result2.wasNull()) {
													while(result2.next()) { 
														filename = new SystemInformation().getPathImmaginiDocumentoHTML()+codice+"/"+result2.getString("filename");
														immagini += "<img class='showImmagineDocumento' src='"+filename+"' alt='"+filename+"' />";
													}
												}										
											
											
											}										
										}
										else {
											titoloDocumento = "Documento Non Trovato.";
										}											
									}
									
									connDB.getConn().close();
								}
								catch(Exception e) {
									titoloDocumento = e.getMessage();
								}	
							}
							else {
								titoloDocumento = connDB.getError();
							}
							
							%> <div class="dettaglioProdotto">	
					<div class="left">
						<%=immaginePrincipale %>
						<%=immagini %>						
					</div>
					<div class="right">
						<p class="titoloDocumento"><%=titoloDocumento %></p>
						<p class="universitaDocumento"><%=universita %> 
						<p class="materiaDocumento"><%=materiaDocumento %></p>
						<p class="pagineDocumento">Pagine: <%=pagine %>
						<p class="prezzoDocumento">Prezzo: <%=prezzoDocumento %>€</p>
						<p class="document_title">Descrizione</p>
						<p class="descrizioneDocumento"><%=descrizione %></p>
					
					<table id="recensioniTable">
				<thead class="adminHeadDataTable">
					
						<p class="recensioni">Recensioni</p>
				</thead>
				<tbody id="bodyRecensione" data-id=<%=codice %> class="adminBodyDataTable">
				</tbody>
			</table>									
				<button id="button_dettaglio" class='userButtonAggiungiAlCarrello product-button' data-codice='<%=codice%>'>Aggiungi Al Carrello</button>
						
					</div>
					
					<% if((Integer) request.getSession().getAttribute("tipo_utente") != null) { %>
					
					<div id="aggiungiRecensione" class="adminAggiungi">
			
					<button id="buttonAggiungiRecensione" class="adminButtonAggiungi"><i class="fas fa-plus" style="cursor: pointer;" title="Aggiungi Recensione"></i></button>
				</div>
								
				<div id="formAggiungiRecensione" class="adminFormAggiungi" style="display: none;">
					<input type="hidden" value=<%=codice %> id="codice"/>
				</div>
				<%} %>
				</div>     
				<%
			        }
			        catch(NumberFormatException e){
			        	%> numero non valido <%
			        }
				        				        
			        %>
				   			        
			</div>
		</div>
		</section>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>