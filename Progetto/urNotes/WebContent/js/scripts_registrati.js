$(document).ready(function(){
	$(document).on('submit', '#formRegistrati', function(e){
		var username = $("#username").val();
		var nome = $("#nome").val();
		var cognome = $("#cognome").val();
		var email = $("#email").val();
		var password = $("#password").val();
		var confermaPassword = $("#confermaPassword").val();

		
		var continua = 1;
		if(username == undefined || username == "" || username.length < 3){			
			showAlert(1, "Inserire un Username valido");
			continua *= 0;
		}
		if(nome == undefined || nome == "" || nome == "." || nome.length < 3){			
			showAlert(1, "Inserire un Nome valido");
			continua *= 0;
		}
		if(cognome == undefined || cognome == "" || cognome.length < 4){			
			showAlert(1, "Inserire un Cognome valido");
			continua *= 0;
		}
		if(email == undefined || email == "" || !checkEmail(email)){			
			showAlert(1, "Inserire un'Email valida");
			continua *= 0;
		}
		if(password == undefined || password == "" || password.length < 6){			
			showAlert(1, "Inserire una Password valida di almeno 6 caratteri");
			continua *= 0;
		}
		if(confermaPassword == undefined || password != confermaPassword){			
			showAlert(1, "Controllare che le due password coincidano");
			continua *= 0;
		}
		
	
		if(continua){
			$("#loader").show();

			$.ajax({
				url: absolutePath+"/SalvaUtente",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"username": username,
					"nome": nome,
					"cognome": cognome,
					"email": email,
					"password": password
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						window.location.href = msg.redirect;
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
			return false;
		}
		else{			
			return false;
		}					
		return false;
	});	
	
	
	
	
	
});
