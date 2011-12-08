package uk.ac.kmi.server.store;

import org.ontoware.rdf2go.model.QueryResultTable;


public interface QueryExecutor {

	public QueryResultTable executeQuery(String queryString) throws RDFRepositoryException;

}
