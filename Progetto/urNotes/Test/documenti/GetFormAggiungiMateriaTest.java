package documenti;

import static org.junit.Assert.*;



import java.io.IOException;
import java.security.SecureRandom;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;


import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import documenti.GetFormAggiungiMateria;

public class GetFormAggiungiMateriaTest extends Mockito{

	 private GetFormAggiungiMateria servlet;
	  private MockHttpServletRequest request;
	  private MockHttpServletResponse response;

	  /**
	   * Before.
	   */
	  @Before
	  public void setUp() {
	    servlet = new GetFormAggiungiMateria();
	    request = new MockHttpServletRequest();
	    response = new MockHttpServletResponse();
	  }
	
	@Test
	  public void FormMateria() throws ServletException, IOException  {
	    request.addParameter("richiesta","1");
	    servlet.doPost(request, response);
	    assertEquals("text/html", response.getContentType());
	  }
	
	@Test
	  public void FormMateriaget() throws ServletException, IOException  {
	    request.addParameter("richiesta","1");
	    servlet.doGet(request, response);
	    assertEquals("text/html", response.getContentType());
	  }
}