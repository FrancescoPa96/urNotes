package documenti;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import connection.ConnessioneDB;
import model.SystemInformation;
/**
 * Servlet implementation class EliminaImmagine
 */
@WebServlet("/EliminaImmagine")
public class EliminaImmagine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaImmagine() {
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
		
		int idImmagine = Integer.parseInt(request.getParameter("idImmagine"));
        
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {
				String sql = "";						
				Statement stmt0 = connDB.getConn().createStatement();				
				sql = ""
						+ "SELECT codice, filename "
						+ "FROM documenti_immagini "
						+ "WHERE attivo = 1 AND id_immagine = "+idImmagine+"; ";
				ResultSet result = stmt0.executeQuery(sql);				
				if(!result.wasNull()) {
					while(result.next()) {
						String filePath = new SystemInformation().getPathImmaginiDocumento()+result.getString("codice")+"\\"+result.getString("filename");
						File file = new File(filePath);
			    		if(file.delete()){
							Statement stmt = connDB.getConn().createStatement();				
							sql = "UPDATE documenti_immagini SET attivo = 0 WHERE id_immagine = "+idImmagine+";";
							if(stmt.executeUpdate(sql) == 1) {
								contenuto = "Immagine Eliminata con Successo";
								risultato = 1;			 		
							}
							else {
								errore = "Errore Cancellazione Immagine.";
								risultato = 0;					
							}			    			
			    		}
			    		else{
							errore = "Errore Cancellazione File di Immagine.";
							risultato = 0;					
			    		}				
					}					
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
        
        				
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);
	}

}
