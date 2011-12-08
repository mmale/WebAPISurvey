package uk.ac.kmi.server.store;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import uk.ac.kmi.server.store.Configuration;
import uk.ac.kmi.server.store.URI;
import uk.ac.kmi.server.store.URIImpl;

public class ConfigurationImpl implements Configuration {

	private Properties props;

	//private String hRestsXsltPath;

	public ConfigurationImpl(String filePath) {
		//this.hRestsXsltPath = hRestsXsltPath;
		props = new Properties();
		try {
			InputStream in = new BufferedInputStream (new FileInputStream(filePath));
			props.load(in);
		} catch (FileNotFoundException e) {
		//	throw new ConfigurationException(e);
		} catch (IOException e) {
		//	throw new ConfigurationException(e);
		}
	}

	public String getHostName() {
		if ( props != null )
			return props.getProperty("serverName");
		return null;
	}
	
	public URI getRepositoryServerUri() {
		if ( props != null )
			return new URIImpl(props.getProperty("serverURL"));
		return null;
	}

	public String getRepositoryName() {
		if ( props != null )
			return props.getProperty("repoName");
		return null;
	}
	
	public String getPWRepositoryName() {
		if ( props != null )
			return props.getProperty("pwRepoName");
		return null;
	}
	
	public String getProxyHostName() {
		if ( props != null )
			return props.getProperty("proxyHostName");
		return null;
	}

	public String getProxyPort() {
		if ( props != null )
			return props.getProperty("proxyPort");
		return null;
	}
}
