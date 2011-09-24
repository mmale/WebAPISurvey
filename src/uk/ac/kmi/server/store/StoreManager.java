package uk.ac.kmi.server.store;

import java.util.Date;
import java.util.HashMap;
import java.util.Vector;

import uk.ac.kmi.server.store.URI;

public interface StoreManager {
	//agentUri - the id of the user completing the survey, alternatively the session id
	//surveyId - survey process id, in order to be able to identify all the steps completed as part of one survey
	//apiUri
	//documentUri -
	//object
	//time - time when the survey step was completed
	//method
	public void store(URI apiUri, String surveyId, URI userId, URI surveyPropertyName, String surveyProperyValue, Date time);// throws LogException;
	//logger.store(agentUri, processId, classifiedItem, documentUri, "http://www.soa4all.eu/Save/" + element, new Date(), method);
	
	public void store(URI apiUri, String surveyId, URI userId, HashMap<String, String[]> parameters, Date time);// throws LogException;
}
