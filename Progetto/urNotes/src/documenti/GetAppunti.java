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
import model.SystemInformation;
/**
 * Servlet implementation class GetAppunti
 */
@WebServlet("/GetAppunti")
public class GetAppunti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAppunti() {
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
	    
		String value = request.getParameter("value");
		
		Integer risultato = 0;
	    String errore = "";
	    String contenuto = "";
	    
	    
	    
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {
				Statement stmt = connDB.getConn().createStatement();
				String sql = "";
				sql = ""
						+ "SELECT d.codice, d.titolo, d.pagine, d.universita, d.nome_materia, d.prezzo "
						+ "FROM documenti AS d "
						+ "WHERE d.tipo LIKE 'Appunti' AND d.flag=1 AND d.nome_materia LIKE '"+value+"';";
				//System.out.println(sql);
				ResultSet result = stmt.executeQuery(sql);	
				
				if(!result.wasNull()) {
					contenuto += "<tr>";
					contenuto += "<td class='row_title'>"+"Titolo"+"</td>";
					contenuto += "<td class='row_title'>"+"Pagine"+"</td>";
					contenuto += "<td class='row_title'>"+"Prezzo"+"</td>";
					contenuto += "<td class='row_title'>"+""+"</td>";
					contenuto += "</tr>";
					while(result.next()) {
						contenuto += "<tr>";
						contenuto += "<td>"+""+"</td>";
						contenuto += "<td>"+""+"</td>";
						contenuto += "<td>"+""+"</td>";
						contenuto += "<td>"+""+"</td>";
						contenuto += "</tr>";
						contenuto += "<tr id=container_documenti>";
						contenuto += "<td>"+result.getString("titolo")+"</td>";		
						contenuto += "<td>"+result.getInt("pagine")+"</td>";
						contenuto += "<td>";
						contenuto += new SystemInformation().truncateDecimal(result.getFloat("prezzo"),2);							
						contenuto += "�"+"</td>";	
						contenuto += "<td><button type='submit' id='idAppuntoDett' data-id='"+result.getString("codice")+"' name='submitForm'><i class='fas fa-search' style='cursor: pointer;' title='Dettagli Appunto'></i></button></td>";
						contenuto += "<td>";
						contenuto += "<div class='product'>";
						contenuto += "<div class='product-button' data-codice='"+result.getInt("codice")+"'>";
						contenuto += "<button type='submit' class='userButtonAggiungiAlCarrello product-button' data-codice='"+result.getInt("codice")+"' name='submitForm'><i class='fas fa-shopping-cart' style='cursor: pointer;' title='Aggiunta Carrello'></i></button></td>";
						contenuto += "</div>";
						contenuto += "</div>";	
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
	
		
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);		
	}

}