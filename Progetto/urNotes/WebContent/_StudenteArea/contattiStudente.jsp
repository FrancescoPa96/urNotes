<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.CheckSession, javax.servlet.http.HttpSession, model.SystemInformation" %>

<!DOCTYPE html>
<html lang = "it">

<head>
	<% 
			CheckSession ck = new CheckSession(0, request.getSession());
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
<title>urNotes | Contatti</title>
</head>

<body>
<%@ include file="/partials/header.jsp" %>		


<section class="contacts">


<div class="contact">

<img src="/urNotes/images/email.jpg" class="contact-img" alt="email">
<div class="contact-text">
<h3>Email</h3>
<p>Puoi contattarci tramite email: <a class="mail" href="mailto:assistenzaclienti@urnotes.it">assistenzaclienti@urnotes.it</a></p>
</div>

</div>

<div class="contact">

<img src="/urNotes/images/mobile.png" class="contact-img" alt="telefono">
<div class="contact-text">
<h3>Telefono</h3>
<p>Servizio Clienti:&nbsp;&nbsp;+39 1234567890 <span>Centralino Uffici:&nbsp;+39 1234567890</span></p>
</div>

</div>

<div class="contact">

<img src="/urNotes/images/indirizzo.jpg" class="contact-img" alt="indirizzo">
<div class="contact-text">
<h3>Indirizzo Postale</h3>
<p>urNotes Italia S.r.l<br>
Via G.Paolo II 84084 Fisciano(SA)
</p>
</div>

</div>
</section>

<%@ include file="/partials/footer.jsp" %>	

</body>
</html>