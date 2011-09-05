package uk.ac.kmi.server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.ontoware.rdf2go.model.QueryResultTable;
import org.ontoware.rdf2go.model.QueryRow;

import uk.ac.kmi.server.store.RDFRepositoryException;
import uk.ac.kmi.server.util.PWAPIs;
import uk.ac.kmi.server.util.ServiceClasses;

/**
 * Servlet implementation class APIs
 */
public class APIs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public APIs() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		// retrieve the method requested
		String index = request.getParameter("index");
		
		//For testing only!
		index = "2";
		
		
		// initialize the result variable
		QueryRow apiResult = null;
		String apiURL =  "No URL!";
		String apiDesc = "No description!";
		String apiHome = "No home URL!";
		
		QueryResultTable classesResult = null;
		
		try {
			int i = Integer.parseInt(index);

			PWAPIs apis = new PWAPIs();
			apiResult = apis.getAPIsbyIndex(i);
		} catch (RDFRepositoryException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if( apiResult.toString() != null){
			apiURL = apiResult.getValue("api").toString();
			apiDesc = apiResult.getValue("desc").toString();
			apiHome = apiResult.getValue("home").toString();
		}
		
		request.setAttribute("api.url",apiURL );
		request.setAttribute("api.desc",apiDesc );
		request.setAttribute("api.home",apiHome );
		
		if( session != null ) {
			session.setAttribute("apiURL", apiHome);
		}
		
		try {
			ServiceClasses allClasses = new ServiceClasses();
			classesResult = allClasses.getAllClasses();
		} catch (RDFRepositoryException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String allClassesHTML ="<form name='classification' action='StoreClassification' method='POST'>";
		
		int i = 0;
		String category = "";
		String caregoryURL= "";
			
		if( classesResult.toString() != null){
			for(QueryRow row : classesResult) {
				
				category = row.getValue("c").toString();
				category = category.substring(category.lastIndexOf("/") + 1, category.length()); 
				caregoryURL = row.getValue("c").toString();
				
				if(i > 0){
					allClassesHTML  = allClassesHTML + 
					"<input type='checkbox' name='apiClasses' value='" +
					caregoryURL + "' id='" + i + "' /> " +
					category + "<br />";
				}
				
				i++;
			}
		}
		
		allClassesHTML = allClassesHTML + "<input type='submit' value='Submit' /> </form>";
		
		request.setAttribute("classes.all",allClassesHTML );
		
		request.getRequestDispatcher("/showAPIs.jsp").forward(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//request..getRequestDispatcher("/showBrowser.jsp").forward(request,response);
		
	}

}