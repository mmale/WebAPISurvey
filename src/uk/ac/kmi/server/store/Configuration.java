package uk.ac.kmi.server.store;

import uk.ac.kmi.server.store.URI;

public interface Configuration {

	public String getHostName();

	public URI getRepositoryServerUri();
	
	public String getRepositoryName();
	
	public String getPWRepositoryName();

	public String getProxyHostName();

	public String getProxyPort();
}
