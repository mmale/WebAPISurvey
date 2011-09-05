package uk.ac.kmi.server.util;

import org.ontoware.rdf2go.model.QueryResultTable;
import org.ontoware.rdf2go.model.QueryRow;
import org.openrdf.rdf2go.RepositoryModel;

import uk.ac.kmi.server.store.Configuration;
import uk.ac.kmi.server.store.ConfigurationImpl;
import uk.ac.kmi.server.store.RDFRepositoryConnector;
import uk.ac.kmi.server.store.RDFRepositoryException;

public class PWAPIs {
	protected RDFRepositoryConnector rdfRepositoryConnector;
	public Configuration config;
	
	public PWAPIs(){
		String baseDir = PWAPIs.class.getResource("/").getPath();
		baseDir = baseDir.replaceAll("%20", " ");
		String configPath = baseDir + "../config.properties";
		
		config = new ConfigurationImpl(configPath);
		try {
			//rdfRepositoryConnector = new RDFRepositoryConnector(config.getRepositoryServerUri(), config.getPWRepositoryName());
			rdfRepositoryConnector = new RDFRepositoryConnector(new uk.ac.kmi.server.store.URIImpl("http://localhost:8080/openrdf-sesame"), "ProgrammableWeb");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public QueryResultTable getAllAPIs() throws RDFRepositoryException {
		String queryString = 
		"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n" +
		"PREFIX lpw:<http://iserve.kmi.open.ac.uk/ontology/lpw#>\n" +
	
		"SELECT ?api ?desc ?home WHERE {\n" +
		"?api rdf:type lpw:API . \n" +
		"?api lpw:apiHome ?home. \n" +
		"?api lpw:summary ?desc. \n" +
		"}\n" +
		"LIMIT 20 \n";
		
		RepositoryModel repoModel = rdfRepositoryConnector.openRepositoryModel();
		QueryResultTable qrt = repoModel.sparqlSelect(queryString);
		rdfRepositoryConnector.closeRepositoryModel(repoModel);
		return qrt;
	}
	
	public QueryRow getAPIsbyIndex(int index) throws RDFRepositoryException {
		//QueryRow resultAPI = new QueryRow();
		
		QueryResultTable allAPIs = getAllAPIs();
		int i = 0;
		for(QueryRow row : allAPIs) {
			if (i == index){
				return row;
			}
			else {
				i++;
			}
		}
		return null;
		
		//return resultAPI;
	}
}
