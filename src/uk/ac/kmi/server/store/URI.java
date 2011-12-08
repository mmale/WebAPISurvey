package uk.ac.kmi.server.store;

import java.io.Serializable;

public interface URI extends Serializable {

	public String getNameSpace();

	public String getLocalName();

	public String toSPARQL();
}

