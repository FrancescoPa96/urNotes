$(document).ready(function(){
	$('#documentiTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessun Documento Presente",
			    "sInfo":           "Vista da _START_ a _END_ di _TOTAL_ elementi",
			    "sInfoEmpty":      "Vista da 0 a 0 di 0 elementi",
			    "sInfoFiltered":   "(filtrati da _MAX_ elementi totali)",
			    "sInfoPostFix":    "",
			    "sInfoThousands":  ".",
			    "sLengthMenu":     "Visualizza _MENU_ elementi",
			    "sLoadingRecords": "Caricamento...",
			    "sProcessing":     "Elaborazione...",
			    "sSearch":         "Cerca:",
			    "sZeroRecords":    "La ricerca non ha portato alcun risultato.",
			    "oPaginate": {
			        "sFirst":      "Inizio",
			        "sPrevious":   "Precedente",
			        "sNext":       "Successivo",
			        "sLast":       "Fine"
			    },
			    "oAria": {
			        "sSortAscending":  ": attiva per ordinare la colonna in ordine crescente",
			        "sSortDescending": ": attiva per ordinare la colonna in ordine decrescente"
			    }
        }        
    } );
	
	$(document).on('click', '#buttonAggiungiDocumento', function(e){
		
		if($("#formAggiungiDocumento").css("display") == "block"){
			$("#formAggiungiDocumento").html("");
			$("#formAggiungiDocumento").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiDocumento",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"richiesta": 1
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						$("#formAggiungiDocumento").html(msg.contenuto);
						$("#formAggiungiDocumento").css("display", "block");
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungiDocumento', function(e){		
		var titolo = $("#titolo").val();
		var pagine = $("#pagine").val();
		var universita = $("#universita").val();
		var nome_materia = $("#nomeMateria").val();
		var descrizione = $("#descrizione").val();
		var prezzoDocumento = $("#prezzoDocumento").val();
		var tipo = $("#tipo").val();
		
		
		if(titolo != undefined && titolo.length > 5 && pagine != undefined && pagine > 0 && universita != undefined && universita.length > 3 && nome_materia != undefined && nome_materia.length > 1 && descrizione != undefined && descrizione.length > 5 && prezzoDocumento != undefined && prezzoDocumento > 0 && tipo != undefined && tipo > 0 ){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiDocumento",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"titolo": titolo,
					"pagine": pagine,
					"universita": universita,
					"nome_materia": nome_materia,
					"descrizione": descrizione,
					"prezzoDocumento": prezzoDocumento,
					"tipo": tipo
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungiDocumento").html("");
						$("#formAggiungiDocumento").css("display", "none");
						getDocumenti();
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
		}
		else{			
			showAlert(1, "Controllare di aver compilato correttamente tutti i campi.");
		}		
	});	
		
	
	$(document).on('click', '.eliminaDocumento', function(e){		
		var codice = $(this).data("codice");
		
		if(codice != undefined && codice > 0){		
			if(confirm("Conferma la cancellazione del documento con codice "+codice+"?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaDocumento",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"codice": codice
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getDocumenti();
						}
					},
					error: function(msg){
						showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();
			}
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});		
	
	$(document).on('click', '.fotoDocumento', function(e){		
		var codice = $(this).data("codice");
		
		if(codice != undefined && codice > 0){		
			window.location.href = 'documenti_immagini.jsp?codice='+codice;
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});			
	
	

	$(document).on('click', '.modificaPrezzo', function(e){		
		var codice = $(this).data("codice");

		if(codice != undefined && codice > 0){		
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/GetFormModificaPrezzoDocumentoAdmin",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"codice": codice
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{														
							$("#modalDettaglioPrezzoBody").html(msg.contenuto);
							$("#modalDettaglioPrezzo").css("display", "block");
						}
					},
					error: function(msg){
						showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});		

	$(document).on('click', '#confirmAggiungiPrezzoDocumento', function(e){		
		var codice = $("#codice").val();
		var prezzoDocumento = $("#prezzoDocumento").val();				
		if(codice != undefined && codice > 0){
			if(prezzoDocumento != undefined && prezzoDocumento > 0){
				
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/AggiornaPrezzoDocumentoAdmin",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"codice": codice,
						"prezzoDocumento": prezzoDocumento
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{														
							$("#modalDettaglioPrezzo").css("display", "none");
							getDocumenti();
							showAlert(0, msg.contenuto);
						}
					},
					error: function(msg){
						showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();

			}	
			else{
				showAlert(1, "Inserire un prezzo maggiore di 0.");
			}		
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});		
	
	
	$(document).on('click', '.chiudiModalDettaglioPrezzo', function(e){
		$("#modalDettaglioPrezzo").css("display", "none");
	});			
});

function getDocumenti(){ 
	$("#loader").show();
	$.ajax({
		url: absolutePath+"/GetDocumenti",
		type: "POST",
		dataType: 'JSON',
		async: false,
		data: {
			"richiesta": 1
		},
		success:function(msg){
			if(!msg.risultato){
				showAlert(1, msg.errore);
			}
			else{				
				if(msg.contenuto.length > 0){
					$("#bodyDocumento").html(msg.contenuto);
				}											
				else{
					$("#bodyDocumento").html("<tr><td colspan='10'>Nessun Documento Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}