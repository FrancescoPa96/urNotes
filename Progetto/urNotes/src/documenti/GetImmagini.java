package documenti;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import connection.ConnessioneDB;
/**
 * Servlet implementation class GetImmagini
 */
@WebServlet("/GetImmagini")
public class GetImmagini extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetImmagini() {
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
		Integer risultato = 0;
	    String errore = "";
	    String contenuto = "";
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");

	    Integer codice = Integer.parseInt(request.getParameter("codice"));	
	    request.getSession().setAttribute("codice", codice);
		if(codice > 0){
	        ConnessioneDB connDB = new ConnessioneDB();
			if(connDB.getConn() != null) {
				
				try {
					Statement stmt = connDB.getConn().createStatement();
					String sql = "";
					sql = ""
							+ "SELECT id_immagine, filename, is_default "
							+ "FROM documenti_immagini "
							+ "WHERE attivo = 1 AND codice = "+codice+"; ";
					//System.out.println(sql);
					ResultSet result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						while(result.next()) {
							contenuto += "<tr>";
								contenuto += "<td><img class='showImmagineDocumento' src='"+request.getContextPath()+"/images/documenti/"+codice+"/"+result.getString("filename")+"' alt='"+result.getString("filename")+"' /></td>";
								contenuto += "<td>"+(result.getInt("is_default") == 1 ? "Si" : "No")+"</td>";	
								contenuto += "<td>";
								contenuto += "	<i class='elimina eliminaImmagine fas fa-times' style='cursor: pointer;' data-idimmagine='"+result.getInt("id_immagine")+"' title='Elimina Immagine'></i>";
								contenuto += "</td>";
							contenuto += "</tr>";
						}					
					}				 
					
					risultato = 1;
					if(risultato == 0) {
						connDB.getConn().rollback();
					}
					else {
						connDB.getConn().commit();
					}																	
					connDB.getConn().close();
					
				}
				catch(Exception e) {
					errore = "Errore esecuzione Query.";
					risultato = 0;
				}
			}
			else {
				errore = connDB.getError();
				risultato = 0;
			}			
			
		}
		else {
			errore = "Errore Parametri Servlet.";
		}
		
	    
	    
	
		
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);		
	}

}
