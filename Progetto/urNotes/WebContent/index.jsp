<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.CheckSession, javax.servlet.http.HttpSession, connection.ConnessioneDB, java.sql.*" %>

<!DOCTYPE html>
<html lang = "it">

<head>
<%@ include file="/partials/head.jsp" %>
<title>urNotes | Appunti e Dispense per Studenti Universitari</title>
</head>

<body>
<%@ include file="/partials/header.jsp" %>		



<div id="wowslider-container1">
<div class="ws_images"><ul>
		<li><img src="data1/images/imagescroll1.png" alt="image1" title="imagescroll1" id="wows1_0"/></li>
		<li><img src="data1/images/imagescroll2.jpg" alt="image2" title="imagescroll2" id="wows1_2"/></li>
		<li><img src="data1/images/imagescroll3.jpg" alt="image3" title="imagescroll3" id="wows1_1"/></li>
	</ul>
</div>

<div class="ws_bullets"><div>
		<a href="#" title="imagescroll1"><span>1</span></a>
		<a href="#" title="imagescroll2"><span>2</span></a>
		<a href="#" title="imagescroll3"><span>3</span></a>
	</div>
</div>

</div>
<script type="text/javascript" src="engine1/wowslider.js"></script>
<script type="text/javascript" src="engine1/script.js"></script>



<% if((Integer) request.getSession().getAttribute("tipo_utente") == null){ %>
<section class="container-section">
<div class="section-image">
<div class="title-section">Gli Appunti 2.0</div>
<div class="section-text">
È possibile per ogni insegnamento caricare e visualizzare dispense e appunti.
Ogni Documento è visionabile leggendo tutte le informazioni ad esso relative.
<img class="image-section1" alt="icon" src="/urNotes/images/tutoring.png">
<br>
<a id="button" href="/urNotes/appunti.jsp">Appunti</a>
</div>
</div>       
</section>
<% } %>


<section class="container-section">
<div class="section-image">
<div class="title-section">Ti Aiutiamo nello Studio</div>

<div class="section-text">
 Migliaia di studenti utilizzano urNotes per preparare i loro esami.
 <p>Facile e Veloce</p>
 Cerca l'appunto che ti serve, leggi la sua descrizione e acquista!
 <img class="image-section1" alt="icon" src="/urNotes/images/icon2.png">
<br>
<a id="button" href="/urNotes/comeFunziona.jsp">Come Funziona</a>
</div>

</div>       
</section>


<% if((Integer) request.getSession().getAttribute("tipo_utente") == null) { %>
	<section class="container-section">
	<div class="section-image">
	<div class="title-section">Effettua la registrazione</div>
	<div class="section-text">
	Trovare tempo per preparare un esame non è sempre facile, 
	per questo hai bisogno di studiare quando e dove vuoi. 
	Trova i tuoi appunti sul tuo tablet o 
	sul tuo smartphone e acquista!
	<img class="image-section1" alt="icon" src="/urNotes/images/icon3.png">
		<br>
	<a id="button" href="/urNotes/registrati.jsp">Registrati</a>
	</div>
	</div>     
	</section>		

<% } else if((Integer) request.getSession().getAttribute("tipo_utente") == 1) { %>
	<section class="container-section">
	<div class="section-image">
	<div class="title-section">Gestisci i Documenti</div>
	<div class="section-text">
	Aggiungi appunti e dispense in modo facile e veloce.
	Pubblicare nuovi documenti non è mai stato cosi facile. Prova!.
	<img class="image-section1" alt="icon" src="/urNotes/images/setting.png">
	<br>
	<a id="button" href="/urNotes/_GestoreArea/documentiGestore.jsp">Documenti</a>
	</div>
	</div>     
	</section>

<% } else if((Integer) request.getSession().getAttribute("tipo_utente") == 2) {  %>
<section class="container-section">
<div class="section-image">
<div class="title-section">Gli Appunti 2.0</div>
<div class="section-text">
Sarà possibile per ogni insegnamento caricare e visualizzare dispense e appunti.
Ogni Documento sarà commentabile e visionabile in anteprima senza doverlo acquistare.
<img class="image-section1" alt="icon" src="/urNotes/images/tutoring.png">
<br>
<a id="button" href="/urNotes/appunti.jsp">Appunti</a>
</div>

</div>       
</section>	
<% } %>


<a href="#" class="scrollup"><i class="fa fa-chevron-up fa-2x" style="left:1292px; color:white;"></i></a>

<%@ include file="/partials/footer.jsp" %>	

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
</body>
</html>