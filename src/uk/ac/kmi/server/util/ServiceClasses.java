package uk.ac.kmi.server.util;

import org.ontoware.rdf2go.model.QueryResultTable;
import org.openrdf.rdf2go.RepositoryModel;

import uk.ac.kmi.server.store.Configuration;
import uk.ac.kmi.server.store.ConfigurationImpl;
import uk.ac.kmi.server.store.RDFRepositoryConnector;
import uk.ac.kmi.server.store.StoreManagerImpl;
import uk.ac.kmi.server.store.RDFRepositoryException;
import uk.ac.kmi.server.store.StoreManager;

public class ServiceClasses {

	protected RDFRepositoryConnector rdfRepositoryConnector;
	public Configuration config;
	
	public ServiceClasses(){
		String baseDir = ServiceClasses.class.getResource("/").getPath();
		baseDir = baseDir.replaceAll("%20", " ");
		String configPath = baseDir + "../config.properties";
		
		config = new ConfigurationImpl(configPath);
		try {
			
			//rdfRepositoryConnector = new RDFRepositoryConnector(config.getRepositoryServerUri(), config.getPWRepositoryName());
			rdfRepositoryConnector = new RDFRepositoryConnector(new uk.ac.kmi.server.store.URIImpl("http://localhost:8080/openrdf-sesame"), "ProgrammableWeb");
			//rdfRepositoryConnector = new RDFRepositoryConnector(new uk.ac.kmi.server.store.URIImpl("http://localhost:8080/openrdf-sesame"), "ProgWeb");
			
		} catch (RDFRepositoryException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public QueryResultTable getAllClasses() throws RDFRepositoryException {
		String queryString = 
		"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n" +
		"PREFIX wl:<http://www.wsmo.org/ns/wsmo-lite#>\n" +
	
		"SELECT ?c WHERE {\n" +
		"?c rdf:type wl:FunctionalClassificationRoot . \n" +
		"}\n";
		
		RepositoryModel repoModel = rdfRepositoryConnector.openRepositoryModel();
		QueryResultTable qrt = repoModel.sparqlSelect(queryString);
		rdfRepositoryConnector.closeRepositoryModel(repoModel);
		return qrt;
	}
}
