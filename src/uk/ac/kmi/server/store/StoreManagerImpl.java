package uk.ac.kmi.server.store;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.ontoware.aifbcommons.collection.ClosableIterable;
import org.ontoware.rdf2go.RDF2Go;
import org.ontoware.rdf2go.model.Model;
import org.ontoware.rdf2go.model.QueryResultTable;
import org.ontoware.rdf2go.model.Statement;
import org.ontoware.rdf2go.model.Syntax;
import org.ontoware.rdf2go.vocabulary.XSD;
import org.openrdf.rdf2go.RepositoryModel;

import uk.ac.kmi.server.store.STORE;
import uk.ac.kmi.server.store.RDFRepositoryConnector;
import uk.ac.kmi.server.store.RDFRepositoryException;
import uk.ac.kmi.server.store.URI;


public class StoreManagerImpl implements StoreManager, QueryExecutor{

	protected RDFRepositoryConnector rdfRepositoryConnector;

	private org.ontoware.rdf2go.model.node.URI directTypeUri;

	private org.ontoware.rdf2go.model.node.URI hasUserID;

	private org.ontoware.rdf2go.model.node.URI inSurvey;
	
	//private org.ontoware.rdf2go.model.node.URI hasProcessUri;
	
	private org.ontoware.rdf2go.model.node.URI apiHome;

	private org.ontoware.rdf2go.model.node.URI hasDateTimeUri;

	private org.ontoware.rdf2go.model.node.URI hasCategoryPropertyUri;
	/*private org.ontoware.rdf2go.model.node.URI HTMLAnnotationItemUri;
	private org.ontoware.rdf2go.model.node.URI savedItemUri;
	private org.ontoware.rdf2go.model.node.URI savedToRepositoryItemUri;
	private org.ontoware.rdf2go.model.node.URI searchedInWatsonItemUri;
	private org.ontoware.rdf2go.model.node.URI semanticallyAnnotatedItemUri;
	private org.ontoware.rdf2go.model.node.URI calledProxyItemUri;
	private org.ontoware.rdf2go.model.node.URI deletedHTMLAnnotationItemUri;
	private org.ontoware.rdf2go.model.node.URI deletedSemAnnotationItemUri;*/

	private org.ontoware.rdf2go.model.node.URI logEntryUri;
	
	private org.ontoware.rdf2go.model.node.URI timeInstantUri;

	private org.ontoware.rdf2go.model.node.URI inXSDDateTimeUri;

	public StoreManagerImpl(URI serverUri, String repositoryName) throws RDFRepositoryException {
		rdfRepositoryConnector = new RDFRepositoryConnector(serverUri, repositoryName);
		RepositoryModel repoModel = rdfRepositoryConnector.openRepositoryModel();
		// set up the vocabulary
		directTypeUri = repoModel.createURI("http://www.w3.org/1999/02/22-rdf-syntax-ns#" + "type");
		
		hasUserID = repoModel.createURI(STORE.hasUser);
		inSurvey = repoModel.createURI(STORE.inSurvey);
		apiHome = repoModel.createURI(STORE.apiHome);
		hasDateTimeUri = repoModel.createURI(STORE.hasDateTime);
		//hasActionUri = repoModel.createURI(STORE.hasAction);
		
		hasCategoryPropertyUri = repoModel.createURI(STORE.hasCategory);
		/*HTMLAnnotationItemUri = repoModel.createURI(STORE.Item_HTMLAnnotation);
		savedItemUri = repoModel.createURI(STORE.Item_Save);
		savedToRepositoryItemUri = repoModel.createURI(STORE.Item_SaveToRepository);
		searchedInWatsonItemUri = repoModel.createURI(STORE.Item_SearchInWatson);
		semanticallyAnnotatedItemUri = repoModel.createURI(STORE.Item_SemanticAnnotation);
		calledProxyItemUri = repoModel.createURI(STORE.Item_CallProxy);
		deletedHTMLAnnotationItemUri = repoModel.createURI(STORE.Item_DeleteHTMLAnnotation);
		deletedSemAnnotationItemUri = repoModel.createURI(STORE.Item_DeleteSemAnnotation);*/
		
		logEntryUri = repoModel.createURI(STORE.Service_Repositoy_Survey_Entry);
		timeInstantUri = repoModel.createURI(STORE.Time_Instant);
		inXSDDateTimeUri = repoModel.createURI(STORE.inXSDDateTime);
		rdfRepositoryConnector.closeRepositoryModel(repoModel);
	}

	//logger.store(apiUri, surveyId, userId, hasCategoryProperty, "http://www.kmi.open.ac.uk/survey/classification/" + surveyProperyValue, new Date());
	public void store(URI apiUri, String surveyId, URI userId, URI surveyPropertyName, String surveyProperyValue, Date time) {
		try {
			RepositoryModel repoModel = rdfRepositoryConnector.openRepositoryModel();
			// FIXME: only logging ONCE within ONE millisecond.
			long currentTime = System.currentTimeMillis();
			org.ontoware.rdf2go.model.node.URI surveyEntryInst = repoModel.createURI(STORE.NS + "surveyEntry" + currentTime);
			//org.ontoware.rdf2go.model.node.URI apiInst = repoModel.createURI(STORE.NS + "api" + currentTime);
			org.ontoware.rdf2go.model.node.URI apiInst = repoModel.createURI(apiUri.toString());
			org.ontoware.rdf2go.model.node.URI timeInstantInst = repoModel.createURI(STORE.TIME_NS + "instant" + currentTime);
		
			repoModel.addStatement(timeInstantInst, directTypeUri, timeInstantUri);
			//repoModel.addStatement(apiInst, directTypeUri, repoModel.createURI(apiUri.toString()));
			
			org.ontoware.rdf2go.model.node.URI propertyUri = null;
			if ( surveyPropertyName.toString().endsWith(STORE.hasCategory) ) {
				propertyUri = hasCategoryPropertyUri;
			}
			/*else if ( actionUri.toString().endsWith(STORE.Item_HTMLAnnotation) ) {
				actUri = HTMLAnnotationItemUri;
			} else if ( actionUri.toString().endsWith(STORE.Item_Save) ) {
				actUri = savedItemUri;
			} else if ( actionUri.toString().endsWith(STORE.Item_SaveToRepository) ) {
				actUri = savedToRepositoryItemUri;
			} else if ( actionUri.toString().endsWith(STORE.Item_SearchInWatson) ) {
				actUri = searchedInWatsonItemUri;
			} else if ( actionUri.toString().endsWith(STORE.Item_SemanticAnnotation) ) {
				actUri = semanticallyAnnotatedItemUri;
			} else if ( actionUri.toString().endsWith(STORE.Item_CallProxy) ) {
				actUri = calledProxyItemUri;
			} else if ( actionUri.toString().endsWith(STORE.Item_DeleteHTMLAnnotation) ) {
				actUri = deletedHTMLAnnotationItemUri;
			} else if ( actionUri.toString().endsWith(STORE.Item_DeleteSemAnnotation) ) {
				actUri = deletedSemAnnotationItemUri;
			}*/

			//if ( null == actUri ) {
				//throw new LogException("Unknown Action: " + actionUri.toString());
			//}

			surveyProperyValue.replaceAll(" ", "");
			repoModel.addStatement(apiInst, propertyUri, repoModel.createURI(surveyProperyValue));
			repoModel.addStatement(surveyEntryInst, directTypeUri, logEntryUri);
			//repoModel.addStatement(logEntryInst, hasActionUri, actionInst);
			
			//org.ontoware.rdf2go.model.node.URI documentInst = repoModel.createURI(documentUri);
			org.ontoware.rdf2go.model.node.URI surveyInst = repoModel.createURI(surveyId);
			//repoModel.addStatement(surveyEntryInst, inSurvey, surveyInst);
			
			//org.ontoware.rdf2go.model.node.URI documentInst = repoModel.createURI(documentUri);
			//repoModel.addStatement(processInst, hasHTMLDocumentUri, documentInst);
			repoModel.addStatement(apiInst, inSurvey, surveyInst);
			// FIXME 
			org.ontoware.rdf2go.model.node.URI agnetInst = repoModel.createURI(userId.toString());
			repoModel.addStatement(apiInst, hasUserID, agnetInst);
			DatatypeFactory datatypeFactory;
			datatypeFactory = DatatypeFactory.newInstance();
			GregorianCalendar utcCalendar = new GregorianCalendar(TimeZone.getTimeZone("UTC"));
			utcCalendar.setTime(time);
			XMLGregorianCalendar xmlCalendar = datatypeFactory.newXMLGregorianCalendar(utcCalendar);
			xmlCalendar = xmlCalendar.normalize();
			repoModel.addStatement(timeInstantInst, inXSDDateTimeUri, repoModel.createDatatypeLiteral(xmlCalendar.toXMLFormat(), XSD._dateTime));
			repoModel.addStatement(surveyEntryInst, hasDateTimeUri, timeInstantInst);

			//if ( actUri.equals(exportedItemUri) ) {
				//repoModel.addStatement(repoModel.createURI(object), repoModel.createURI(SERVICE.creator), agnetInst);
			//}
			rdfRepositoryConnector.closeRepositoryModel(repoModel);
		} catch (RDFRepositoryException e) {
			//throw new LogException(e);
		} catch (DatatypeConfigurationException e) {
			//throw new LogException(e);
		}

	}

	public QueryResultTable executeQuery(String queryString) throws RDFRepositoryException {
		RepositoryModel repoModel = rdfRepositoryConnector.openRepositoryModel();
		QueryResultTable qrt = repoModel.sparqlSelect(queryString);
		rdfRepositoryConnector.closeRepositoryModel(repoModel);
		return qrt;
	}

	public String executeDescribeQuery(String queryString) throws RDFRepositoryException {
		RepositoryModel repoModel = rdfRepositoryConnector.openRepositoryModel();
		ClosableIterable<Statement> stmts = repoModel.sparqlDescribe(queryString);
		Model tempModel = RDF2Go.getModelFactory().createModel();
		tempModel.open();
		tempModel.addAll(stmts.iterator());
		String result = tempModel.serialize(Syntax.RdfXml);
		tempModel.close();
		rdfRepositoryConnector.closeRepositoryModel(repoModel);
		return result;
	}

	public RDFRepositoryConnector getConnector() {
		return rdfRepositoryConnector;
	}
	
	
}
