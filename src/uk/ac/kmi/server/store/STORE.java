package uk.ac.kmi.server.store;

public class STORE {
	public static final String NS = "http://www.kmi.open.ac.uk/survey#";

	public static final String TIME_NS = "http://www.w3.org/time#";

	public static final String Survey_Entry = NS + "SurveyEntry";

	public static final String Service_Repositoy_Survey_Entry = NS + "ServiceRepositoySurveyEntry";

	public static final String Action = NS + "API";
	
	public static final String Process = NS + "Process";
	
	public static final String HTMLDocument = NS + "HTMLDocument";
	

	//public static final String Item_Classify = NS + "ItemClassify";

	/*public static final String Item_Export = NS + "ItemExport";

	public static final String Item_SaveToRepository = NS + "ItemSaveToRepository";

	public static final String Item_SearchInWatson = NS + "ItemSearchWatson";
	
	public static final String Item_HTMLAnnotation = NS + "ItemHTMLAnnotation";

	public static final String Item_SemanticAnnotation = NS + "ItemSemanticAnnotation";
	
	public static final String Item_CallProxy = NS + "ItemCallProxy";
	
	public static final String Item_DeleteHTMLAnnotation = NS + "ItemDeleteHTMLAnnotation";
	
	public static final String Item_DeleteSemAnnotation = NS + "ItemDeleteSemAnnotation";*/
	

	public static final String Time_Instant = TIME_NS + "Instant";

	// properties
	public static final String hasCategory = NS + "hasCategory";
	
	public static final String hasUser = NS + "hasUserID";
	
	public static final String inSurvey = NS + "inSurvey";
	
	public static final String apiHome = NS + "apiHome";

	public static final String hasDateTime = NS + "hasDateTime";
	
	//public static final String hasAction = NS + "hasAction";
	//public static final String classifiedItem = NS + "classifiedItem";

	/*public static final String exportedItem = NS + "exportedItem";

	public static final String savedToRepositoryItem = NS + "savedToRepositoryItem";

	public static final String searchedInWatsonItem = NS + "searchedInWatsonItem";
	
	public static final String HTMLAnnotatedItem = NS + "HTMLAnnotatedItem";

	public static final String semanticalyAnnotatedItem = NS + "semanticalyAnnotatedItem";
	
	public static final String deletedHTMLAnnotationItem = NS + "deletedHTMLAnnotationItem";
	
	public static final String calledProxyItem = NS + "calledProxyItem";
	
	public static final String deletedSemAnnotationItem = NS + "deletedSemAnnotationItem";*/
	
	

	public static final String inXSDDateTime = TIME_NS + "inXSDDateTime";
}
