<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang = "it">

<head>
<%@ include file="/partials/head.jsp" %>				
		<script src="<%=request.getContextPath()%>/js/scripts_materie.js"></script>					
		<title>urNotes | Catalogo Materie</title>		
	</head>
	<body onLoad="getMaterie()">
		<%@ include file="/partials/header.jsp" %>		
		<section class="container_appunti">	
		<div id="content">
			<div id="content-content">
				<table id="prodottiTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Nome</th>
						</tr>	
					</thead>
					<tbody id="bodyAppunti" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
			</div>
		</div>
</section>	

<%@ include file="/partials/footer.jsp" %>	

</body>
</html>