package ordini;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

import connection.ConnessioneDB;
import model.Carrello;


/**
 * Servlet implementation class AggiungiOrdine
 */
@WebServlet("/AggiungiOrdine")
public class AggiungiOrdine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiOrdine() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");

        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        Integer richiesta = Integer.parseInt(request.getParameter("richiesta"));		
        if(richiesta == 1) {
	    	if(request.getSession() != null){
	    		Integer serial_id = (Integer) request.getSession().getAttribute("serial_id");   
	    		System.out.println("serial id = "+serial_id);
	    		Integer id_utente = (Integer) request.getSession().getAttribute("id_utente");
	    		System.out.println("id utente = "+id_utente);

	    		if(serial_id != null && id_utente != null){
			        ConnessioneDB connDB = new ConnessioneDB();
					if(connDB.getConn() != null) {
						try {				
							String sql; 
			    			Statement stmt0;
			    			ResultSet result;
							stmt0 = connDB.getConn().createStatement();
		    				sql = ""
									+ "SELECT od.quantita, od.codice "
									+ "FROM ordini_documenti AS od "
									+ "WHERE od.attivo = 1 AND od.serial_id = "+serial_id+"; ";
	    					result = stmt0.executeQuery(sql);				
	    					if(!result.wasNull()) {	    							    					
	    						int rowCount = result.last() ? result.getRow() : 0;
	    						System.out.println(rowCount);
	    						if(rowCount > 0) {
	    							Integer continua = 1;	    							
		    						result.beforeFirst();
		    						PreparedStatement  stmt;

		    						
		    						if(continua == 1) {
		    							sql = "UPDATE ordini SET attivo = 1 WHERE serial_id = ?;";
		    							stmt = connDB.getConn().prepareStatement(sql);
		    							stmt.setInt(1, serial_id);
		    							if(stmt.executeUpdate() == 1) {								

		    								Carrello newCart = new Carrello(id_utente);
											request.getSession().setAttribute("carrello", newCart);
		    								risultato = 1;					
		    								contenuto = "Ordine Terminato con Successo";
		    							}
		    							else {
		    								risultato = 0;					
		    								contenuto = "Errore Completamento Ordine";
		    							}											    							
		    						}
		    						else {
		    							risultato = 0;
		    						}	    							
	    						}
	    						else {
	    							errore = "Nessun Documento Trovato";
	    							risultato = 0;
	    						}
	    					}
	    					else {
								risultato = 0;					
								errore = "Errore Prelevamento Quantit&agrave; Ordine";	    						
	    					}
											
	    					if(risultato == 0) {
	    						connDB.getConn().rollback();
	    					}
	    					else {
	    						connDB.getConn().commit();
	    					}									    					
							connDB.getConn().close();		    						
						}
						catch(Exception e) {
							errore = "Errore esecuzione Query."+e.getMessage();
							risultato = 0;
						}
					}
					else {
				        errore = connDB.getError();
						risultato = 0;
					}    				    				
				}
				else {
					errore = "Nessun ordine trovato.";
					risultato = 0;		    		    				
				}
	    	}
	    	else {
				errore = "Nessun Carrello trovato.";
				risultato = 0;		    		    				    		
	    	}        	
        }
        				
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);
	}



}
