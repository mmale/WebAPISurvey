<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<title>Web API Survey</title>

	<meta name="viewport" content="width=device-width,initial-scale=1">

	<!-- <link rel="stylesheet" href="stylesheets/style.css"> -->
	<link href="stylesheets/screen.css" media="screen, projection" rel="stylesheet" type="text/css" />
	<link href="stylesheets/print.css" media="print" rel="stylesheet" type="text/css" />
	<!--[if lt IE 8]>
	<link href="stylesheets/ie.css" media="screen, projection" rel="stylesheet" type="text/css" />
	<![endif]-->
	<script src="js/libs/modernizr-2.0.min.js"></script>
</head>
<body>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	<script>window.jQuery || document.write('<script src="js/libs/jquery-1.6.2.min.js"><\/script>')</script>
	<script>
		// hide (remove) by CSS (jQuery) selector
		// ?rm=...escaped value of #section1,#fieldsetQuery will be
		// ?rm=%23section1%2C%23fieldsetQuery
		// escape("#section1,#fieldsetQuery")
		// example http://localhost:8080/WebContent/APIs?rm=%23section2%2C%23section3
		// or disable auth which is a fieldset with id auth-fieldset
		// ?rm=%23auth-fieldset
		// http://localhost:8080/WebContent/APIs?rm=%23auth-fieldset
		
		var rm = "<%= request.getParameter("rm") %>";
		$(function() {
			if (rm != null) $(rm).remove();
		});

		// load by URI
		// http://localhost:8080/WebContent/APIs?URI=http://localhost:8080/lpw/resource/apis/aol-video
		// load by index
		// http://localhost:8080/WebContent/APIs?index=6
	</script>
	<article>
		<h1>Web API Survey</h1>
		<h2 id="progress">Thank you for participating in this survey.</h2>
		
		<% if( "show".equals(request.getParameter("debug")) ){ %>
		<section>
			<h2>Debug Information</h2>
			
			
			<%
			//old style
			
			//String uri = request.getAttribute("URI") + "";
	    out.println(
	                "<BODY BGCOLOR=\"#FDF5E6\">\n" +
	                //"<H3 ALIGN=CENTER><a href='http://localhost:8080/openrdf-workbench/repositories/WebAPISurvey/query?queryLn=SPARQL&query=describe%20%3C"+uri+"%3E&limit=200&infer=true' target='_new'>" + uri + "</a></H3>\n" +
	                "<TABLE BORDER=1 ALIGN=CENTER>\n" +
	                "<TR BGCOLOR=\"#cccccc\">\n" +
	                "<TH>Parameter Name<TH>Parameter Value(s)");
	    java.util.Enumeration paramNames = request.getParameterNames();
	    while(paramNames.hasMoreElements()) {
	      String paramName = (String)paramNames.nextElement();
	      out.println("<TR><TD>" + paramName + "\n<TD>");
	      String[] paramValues = request.getParameterValues(paramName);
	      if (paramValues.length == 1) {
	        String paramValue = paramValues[0];
	        if (paramValue.length() == 0)
	          out.print("<I>No Value</I>");
	        else
	          out.print(paramValue);
	      } else {
	        out.println("<UL>");
	        for(int i=0; i<paramValues.length; i++) {
	          out.println("<LI>" + paramValues[i]);
	        }
	        out.println("</UL>");
	      }
	    }
	    out.println("</TABLE>\n</BODY></HTML>");
			
			%>
			
		</section>
		<% }//debug? %>
		
	</article>
	
	
</body>
</html>
