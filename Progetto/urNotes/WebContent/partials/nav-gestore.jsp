
<ul class="header_menu animate">
<li class="header_item"><a>Gestione</a>
<ul>
<li class="drop_item"><a href="<%=request.getContextPath()%>/_GestoreArea/materieGestore.jsp">Materie</a></li>
<li class="drop_item"><a href="<%=request.getContextPath()%>/_GestoreArea/documentiGestore.jsp">Documenti</a></li>
<li class="drop_item"><a href="<%=request.getContextPath()%>/_GestoreArea/recensioniGestore.jsp">Recensioni</a></li>
</ul>
</li>

<li class="header_item"><a>Spedizioni</a>
<ul>
<li class="drop_item"><a href="<%=request.getContextPath()%>/_GestoreArea/vettoriGestore.jsp">Vettori</a></li>
</ul>
</li>

<li class="header_item"><a href="<%=request.getContextPath()%>/_GestoreArea/clientiGestore.jsp">Clienti</a></li>

<ul class="header_menu_dx">
<li class=header_item_dx><a href="<%=request.getContextPath()%>/_GestoreArea/profilo_gestore.jsp">
<p class="account_item"><span class="display">Ciao <%=request.getSession().getAttribute("nome") %></span> <i class="fas fa-user"></i></p></a></li>
<li class=header_item_dx><a class="display" href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
</ul>

</ul>