package uk.ac.kmi.server.util;

import org.apache.commons.httpclient.HttpClient;
import org.ontoware.rdf2go.model.QueryResultTable;
import org.ontoware.rdf2go.model.QueryRow;
import org.openrdf.rdf2go.RepositoryModel;

import uk.ac.kmi.server.store.Configuration;
import uk.ac.kmi.server.store.ConfigurationImpl;
import uk.ac.kmi.server.store.RDFRepositoryConnector;
import uk.ac.kmi.server.store.RDFRepositoryException;

public class PWAPIs {
	protected RDFRepositoryConnector rdfRepositoryConnector;
	protected RDFRepositoryConnector surveyRepositoryConnector;
	public Configuration config;
	
	public PWAPIs(){
		String baseDir = PWAPIs.class.getResource("/").getPath();
		baseDir = baseDir.replaceAll("%20", " ");
		String configPath = baseDir + "../config.properties";
		
		HttpClient httpclient = new HttpClient();
        httpclient.getHostConfiguration().setProxy("wwwcache.open.ac.uk", 80);
        
		config = new ConfigurationImpl(configPath);
		try {
			//rdfRepositoryConnector = new RDFRepositoryConnector(config.getRepositoryServerUri(), config.getPWRepositoryName());
			//rdfRepositoryConnector = new RDFRepositoryConnector(new uk.ac.kmi.server.store.URIImpl("http://localhost:8080/openrdf-sesame"), "ProgrammableWeb");
			rdfRepositoryConnector = new RDFRepositoryConnector(new uk.ac.kmi.server.store.URIImpl("http://localhost:8080/openrdf-sesame"), "ProgWeb");
			
			surveyRepositoryConnector = new RDFRepositoryConnector(new uk.ac.kmi.server.store.URIImpl("http://localhost:8080/openrdf-sesame"), "WebAPISurvey");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String getLastSurveyAPI() throws RDFRepositoryException {
		String queryString = 
		"PREFIX s:<http://www.kmi.open.ac.uk/survey#>" +
		"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>" +
		"PREFIX kmi:<http://kmi.open.ac.uk/web-api#>" +
		"SELECT ?s ?api WHERE {" +
		"?s rdf:type s:ServiceRepositoySurveyEntry ." +
		"?s kmi:apiId ?api ." +
		"} " +
		"ORDER BY DESC(?api) " +
		"LIMIT 1";

		RepositoryModel repoModel = surveyRepositoryConnector.openRepositoryModel();
		QueryResultTable qrt = repoModel.sparqlSelect(queryString);
		surveyRepositoryConnector.closeRepositoryModel(repoModel);
		String api ="";
		for(QueryRow row : qrt) {
			api = row.getValue("api").toString();
		}
		
		qrt.iterator().close();
		
		return api;
	}
	
	public Integer getCountForLastSurveyAPI(String URI) throws RDFRepositoryException {
		String queryString = 
		"PREFIX s:<http://www.kmi.open.ac.uk/survey#> \n" +
		"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> \n" +
		" PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#> \n" +
		" PREFIX kmi:<http://kmi.open.ac.uk/web-api#> \n" +
		"SELECT ?s WHERE { \n" +
		"?s rdf:type s:ServiceRepositoySurveyEntry. \n" +
		"?s kmi:apiId \""+URI+"\". \n" +
		"} ";

		RepositoryModel repoModel = surveyRepositoryConnector.openRepositoryModel();
		QueryResultTable qrt = repoModel.sparqlSelect(queryString);
		surveyRepositoryConnector.closeRepositoryModel(repoModel);
		String api ="";
		Integer i = 0;
		for(QueryRow row : qrt) {
			i++;
		}
		
		qrt.iterator().close();
		
		return i;
	}
	
	public QueryResultTable getAllAPIs() throws RDFRepositoryException {
		String queryString = 
		"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n" +
		"PREFIX lpw:<http://iserve.kmi.open.ac.uk/ontology/lpw#>\n" +
		"PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>\n" +
	
		"SELECT ?api ?desc ?home ?lastUp ?name WHERE {\n" +
		"?api rdf:type lpw:API . \n" +
		"?api rdfs:label ?name . \n" +
		"?api lpw:apiHome ?home. \n" +
		"?api lpw:summary ?desc. \n" +
		"?api lpw:lastUpdate ?lastUp. \n" +
		"}\n" +
		"ORDER BY ASC(?api)";// +
		//"LIMIT 20 \n";
		
		RepositoryModel repoModel = rdfRepositoryConnector.openRepositoryModel();
		QueryResultTable qrt = repoModel.sparqlSelect(queryString);
		rdfRepositoryConnector.closeRepositoryModel(repoModel);
		return qrt;
	}
	
	public String[] getNextAPIForSurvey(String URI) throws RDFRepositoryException {
		
		String[] uris = new String[2];
		
		QueryResultTable allAPIs = getAllAPIs();
		String api = "";
		Boolean entryFound = false;
		Boolean nextFound = false;
		
		for(QueryRow row : allAPIs) {
			
			api = row.getValue("api").toString();
			
			if (nextFound == true && !api.equalsIgnoreCase(uris[0])){
				
				uris[1] = api;
				
				allAPIs.iterator().close();
				
				return uris;
				
			} else if (entryFound == true && nextFound == false && !api.equalsIgnoreCase(URI)){
				
				uris[0] = api;
				nextFound = true;
				
			} else {
				if(api.equalsIgnoreCase(URI)){
					entryFound = true;
				}
			}
		}
		
		allAPIs.iterator().close();
		return uris;
	}
	
	public QueryRow getAPIsbyURI(String URI) throws RDFRepositoryException {
		String queryString = 
			"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n" +
			"PREFIX lpw:<http://iserve.kmi.open.ac.uk/ontology/lpw#>\n" +
			"PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>\n" +
		
			"SELECT ?desc ?home ?lastUp ?name WHERE {\n" +
			"<"+URI+">" + " rdf:type lpw:API . \n" +
			"<"+URI+">" + " rdfs:label ?name . \n" +
			"<"+URI+">" + " lpw:apiHome ?home. \n" +
			"<"+URI+">" + " lpw:summary ?desc. \n" +
			"<"+URI+">" + " lpw:lastUpdate ?lastUp. \n" +
			"}\n" +
			"LIMIT 1 \n";
			
			RepositoryModel repoModel = rdfRepositoryConnector.openRepositoryModel();
			QueryResultTable qrt = repoModel.sparqlSelect(queryString);
			rdfRepositoryConnector.closeRepositoryModel(repoModel);
			
			QueryRow apiURI = qrt.iterator().next();
			qrt.iterator().close();
			return apiURI;
	}
	
	public QueryRow getAPIsbyIndex(int index) throws RDFRepositoryException {
		//QueryRow resultAPI = new QueryRow();
		
		QueryRow result;
		
		QueryResultTable allAPIs = getAllAPIs();
		int i = 0;
		for(QueryRow row : allAPIs) {
			if (i == index){
				
				result = row;
				allAPIs.iterator().close();
				
				return result;
			}
			else {
				i++;
			}
		}
		
		allAPIs.iterator().close();
		return null;
		
		//return resultAPI;
	}
}
