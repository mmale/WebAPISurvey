package uk.ac.kmi.server.store;

import java.util.Date;
import java.util.HashMap;
import java.util.Vector;

import uk.ac.kmi.server.store.Configuration;
import uk.ac.kmi.server.store.ConfigurationImpl;
import uk.ac.kmi.server.store.STORE;
import uk.ac.kmi.server.store.StoreManagerImpl;
import uk.ac.kmi.server.store.RDFRepositoryConnector;
import uk.ac.kmi.server.store.RDFRepositoryException;
import uk.ac.kmi.server.store.URI;
import uk.ac.kmi.server.store.URIImpl;

public class InitializeStore {

	//private ManagerRDF2GO managerRDF2GO;

	private URI hasCategoryProperty;
	/*private URI exportedItem;
	private URI savedToRepositoryItem;
	private URI searchedInWatsonItem;
	private URI HTMLAnnotatedItem;
	private URI semanticalyAnnotatedItem;
	private URI calledProxyItem;
	private URI deletedHTMLAnnotationItem;
	private URI deletedSemAnnotationItem;*/

	public StoreManager logger;
	
	public RDFRepositoryConnector storeRdfRepositoryConnector;
	public URI repositoryURI; 

	// singleton
	private static InitializeStore initializeLogger;

	public Configuration config;

	public InitializeStore() {
		String baseDir = InitializeStore.class.getResource("/").getPath();
		baseDir = baseDir.replaceAll("%20", " ");
		String configPath = baseDir + "../config.properties";
		
		config = new ConfigurationImpl(configPath);
		try {
			
			//RDFRepositoryConnector rdfRepositoryConnector = new RDFRepositoryConnector(config.getLogRepositoryServerUri(), config.getLogRepositoryName());
			//repositoryURI = config.getLogRepositoryServerUri();
			
			//logger = new StoreManagerImpl(config.getRepositoryServerUri(), config.getRepositoryName());
			logger = new StoreManagerImpl(new uk.ac.kmi.server.store.URIImpl("http://localhost:8080/openrdf-sesame"), "WebAPISurvey");
			
		} catch (RDFRepositoryException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		storeRdfRepositoryConnector = ((StoreManagerImpl)logger).getConnector();
		
		hasCategoryProperty = new URIImpl(STORE.hasCategory);
		/*exportedItem = new URIImpl(LOG.Item_Export);
		savedToRepositoryItem = new URIImpl(LOG.Item_SaveToRepository);
		searchedInWatsonItem = new URIImpl(LOG.Item_SearchInWatson);
		HTMLAnnotatedItem = new URIImpl(LOG.Item_HTMLAnnotation);
		semanticalyAnnotatedItem = new URIImpl(LOG.Item_SemanticAnnotation);
		calledProxyItem = new URIImpl(LOG.Item_CallProxy);
		deletedHTMLAnnotationItem = new URIImpl(LOG.Item_DeleteHTMLAnnotation);
		deletedSemAnnotationItem = new URIImpl(LOG.Item_DeleteSemAnnotation);*/
	}

	
	public static InitializeStore get() throws RDFRepositoryException {
		if ( null == initializeLogger ) {
			initializeLogger = new InitializeStore();
		}
		return initializeLogger;
	}
	
	//URI apiUri, String surveyId, String userId, String surveyPropertyName, String surveyProperyValue, Date time
	public void addClassifiedItem(URI apiUri, String surveyId, URI userId, String surveyProperyValue) {
		//URI result = managerFacade2Go.addDocument(name, content);
		//String documentId = UUID.randomUUID().toString();
		if ( logger != null ) {
			//agent,action,object,time,method
			logger.store(apiUri, surveyId, userId, hasCategoryProperty, "http://www.kmi.open.ac.uk/survey/classification/" + surveyProperyValue, new Date());
		}
		//return result;
	}
	
	public void addFormData(URI apiUri, String surveyId, URI userId, HashMap<String, String[]> parameters) {
		if (logger != null) 
			logger.store(apiUri, surveyId, userId, parameters, new Date());
	}
}
