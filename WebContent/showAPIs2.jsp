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
		//rm=%23section2%2C%23section3%2C%23section1%2C%23URI-details%2C%23examples%2C%23heading-descriptionDetails
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
		
		// debug
		//http://localhost:8080/WebContent/APIs?URI=http://localhost:8080/lpw/resource/apis/aol-video&debug=show
	</script>
	<article>
		<h1>Web API Survey</h1>
		<h2 id="progress">Step <span>1</span> of <span>~</span></h2>
		
		<form method="post" action="StoreClassification">
			<input type="hidden" name="debug" value="<%= request.getParameter("debug") %>">
			<input type="hidden" name="scope" value="<%= request.getParameter("scope") %>">
			
			<section id="section0">
				<!--h2>Login</h2-->
				
				
				<fieldset class="xhalf">
					<legend>Welcome!</legend>
					
					<label for="user">Please provide your email address</label>
					<input type="text" id="user" name="user">
					<p>Your email will not be shared with anyone, it is used only for user-tracking purposes</p>
				</fieldset>
				
				<fieldset class="half">
					<legend>Service</legend>
					
					<label for="api-name">Name of the Web API</label>
					<input id="api-name" name="api-name" type="text" readonly value="<%= request.getAttribute("api.name")%>">
					
					<label for="api-lastUpdated">Date the documentation was last updated</label>
					<input id="api-lastUpdated" name="api-lastUpdated" type="date" readonly value="<%= request.getAttribute("api.lastUpdated")%>">
					
					<label for="api-desc">Web API Description</label>
					<textarea id="api-desc" name="api-desc" rows="3" cols="20" readonly><%= request.getAttribute("api.desc")%></textarea>
				
					<input type="hidden" name="apiId" value="<%= request.getAttribute("api.url") %>">
					
				</fieldset>
				
				<fieldset class="half last">
					<legend>Service Details</legend>
					
					<p>If you have already completed the survey for this API 
					<!-- http://localhost:8080/WebContent/APIs  http://sweetdemo.kmi.open.ac.uk/war/APIs-->
					<a href="http://kmi-web17.open.ac.uk:8080/apis/APIs?URI=<%= request.getAttribute("nextURI")%>" target="_new_<%= request.getAttribute("nextURI")%>">
					<b>click here</b></a> to get the description of the next one.</p>
					
					<label for="api-documentationUrl">Documentation URL</label>
					<div>
						<a href="<%= request.getAttribute("api.home")%>" target="_new"><b><%= request.getAttribute("api.home")%></b></a>
					</div>
					
					<!-- input id="api-documentationUrl" name="api-documentationUrl" type="text" readonly value=<%= request.getAttribute("api.home")%>">  -->
					
					<label for="documentationUrl-isCorrect">Does the URL point to the API documentation?</label>
					<div class="radio">
						<label><input type="radio" name="documentationUrl-isCorrect" value="yes">yes</label>
						<label><input type="radio" name="documentationUrl-isCorrect" value="no">no</label>
					</div>
					
					<label for="survey-canBeCompleted">Can the survey be completed for this API?</label>
					<select id="survey-canBeCompleted" name="survey-canBeCompleted">
						<option selected value="">please select...</option> 
						<option value="Yes">Yes</option>
						<option value="No">No</option>
					</select>
					
					<div id="w-noSurveyComplete" class="wrapper" style="display:none">
						<label for="noSurveyComplete" class="full">Why not?</label>
						<input type="text" id="noSurveyComplete" name="noSurveyComplete">
						<script>
							$(function(){
								$('#survey-canBeCompleted').bind('change', function() {
									if ($(this).val() == "No") {
										$('#w-noSurveyComplete').slideDown();
									} else {
										$('#w-noSurveyComplete').slideUp();
									}
								});
							});
						</script>
					</div>	
					
					<!-- 
					<label for="mashups">Number of Mashups</label>
					<input id="mashups" name="mashups" type="number" readonly value="<%-- = request.getAttribute("api.mashups") --%>">
					-->
				</fieldset>
				
				<fieldset class="checkboxes">
					<legend>Category</legend>
					<p>Select all categories that can be used to describe the type of API</p>
					
					<%= request.getAttribute("classes.all")%>
				
				</fieldset>
				
				<menu>
					<button class="next">Next »</button>
				</menu>
			</section>
			
			<section id="section1">
				
				<fieldset class="xhalf">
					<legend>Tags</legend>
					
					<label for="tags">Comma separated tags</label>
					<input type="text" id="tags" name="tags">
					<p>Please use ',' to separate the tags</p>
				</fieldset>
				
				<fieldset class="half" id="auth-fieldset">
					<legend>Authentication</legend>
					<label for="auth-example">Authentication mechanism
						<p>More details on 
						<a href="auth.html" target="_newAuth">authentication approaches</a></p>		
					</label>
					
					<div class="radio">
						<label><input type="checkbox" id="auth1" name="auth" value="none">No Authentication</label>
						<label><input type="checkbox" id="auth2" name="auth" value="API Key">API Key</label>
						<label><input type="checkbox" id="auth3" name="auth" value="Username and Password">Username and Password</label>
						<label><input type="checkbox" id="auth4" name="auth" value="OAuth">OAuth</label>
						<label><input type="checkbox" id="auth5" name="auth" value="HTTP Basic">HTTP Basic</label>
						<label><input type="checkbox" id="auth6" name="auth" value="HTTP Digest">HTTP Digest</label>
						<label><input type="checkbox" id="auth7" name="auth" value="Web API Operation">Web API Operation</label>
						<label><input type="checkbox" id="auth8" name="auth" value="Session Based">Session Based</label>
					</div>
					
					<div id="w-auth" class="wrapper">
						<label for="auth-other" class="full">Other</label>
						<input type="text" id="other-auth" name="auth-other">
					</div>
					
					<label for="authreq">Is authentication required for:</label>
					<div class="radio">
						<label><input type="radio" id="authreq1" name="authreq" value="all">All operations</label>
						<label><input type="radio" id="authreq2" name="authreq" value="data manipulation">Operations for data manipulation (create, edit and delete)</label>
						<label><input type="radio" id="authreq3" name="authreq" value="some">Some operations</label>
						<label><input type="radio" id="authreq4" name="authreq" value="none">None of the operations</label>
					</div>
					
					<label for="auth-transMedium">Where are the authentication credentials sent?</label>
					<select id="auth-transMedium" name="auth-transMedium">
						<option selected value="">please select...</option>
						<option value="URI">in the URL</option>
						<option value="HTTP Header">in a HTTP Header</option>
						<option value="HTTP Body">in the HTTP Body</option>
						<option value="unclear">unclear</option>
					</select>

					<label for="auth-example">Authentication example
						<p>If the authentication method is unclear please paste an example below:</p>		
					</label>
					<textarea id="auth-example" name="auth-example" rows="3" cols="20" ></textarea>
					
					
				</fieldset>
				
				<fieldset class="half last">
					<legend>Web API type</legend>
					
					<label for="webapi-type">Web API type
					<p><b>- RPC:</b> resource retrieval is operation or 'verb' based. For exmaple, HTTP GET http://example.com/api/getNews</p>		
					<p><b>- REST:</b> resource retrieval is resource or 'nouns' based. For exmaple, HTTP GET http://example.com/api/News/2011-11-18</p>		
					<p><b>- hybrid:</b> the used HTTP method contradicts operation semntaics (getNews via POST). For exmaple, HTTP GET http://example.com/api/getNews</p>		
					<p>More details on 
						<a href="apiTypes.html" target="_newTypes">Web API types</a></p></label>
					<select id="webapi-type" name="webapi-type">
						<option selected value="">please select...</option>
						<option value="RPC">RPC</option>
						<option value="REST">REST</option>
						<option value="hybrid">hybrid</option>
					</select>
					
					<div id="w-uri-struct" style="display:none">
						<label for="uri-struct" class="full">Does the URI reflect the hierarchical structure of the resources?
						<p>For exmaple, http://exmaple.api.com/wintersemester2011/courses/computerScience/introduction</p>		
						</label>
						<select id="uri-struct" name="uri-struct">
							<option selected value="">please select...</option>
							<option value="yes">yes</option>
							<option value="no">no</option>
						</select>
						<script>
							$(function(){
								$('#webapi-type').bind('change', function() {
									if ($(this).val() == "REST") {
										$('#w-uri-struct').slideDown();
									} else {
										$('#w-uri-struct').slideUp();
									}
								});
							});
						</script>
					</div>
					
					<label for="isHttpMethodDefined">Is the HTTP method specified?
					<p>For exmaple, this operation is called via GET or this resource can be accessed via GET and POST</p>		
					</label>
					<div class="radio">
						<label><input type="radio" name="isHttpMethodDefined" value="yes">yes</label>
						<label><input type="radio" name="isHttpMethodDefined" value="no">no</label>
					</div>
					<!--  select id="http-verb" name="http-verb">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->
					
					<label for="numberOfOperations">Number of operations</label>
					<select id="numberOfOperations" name="numberOfOperations">
						<option selected value="">please select...</option>
						<option value="1">1</option>
						<option value="2-10">2-10</option>
						<option value="11-50">11-50</option>
						<option value="51-100">51-100</option>
						<option value="101-200">101-200</option>
						<option value="200+">200+</option>
					</select>	
				</fieldset>
				
					
				<menu>
					<button class="back">« Back</button>
					<button class="next">Next »</button>
				</menu>
			</section>
			
			<section id="section2">
				<h2>Input details</h2>
				
				<fieldset class="half">
					<legend>Input details</legend>
					
					<label for="input-isGroundedIn">Way of transmitting input parameters</label>
					<select id="input-isGroundedIn" name="input-isGroundedIn">
						<option selected value="">please select...</option>
						<option value="URL">in the URL</option>
						<option value="HTTP Body">in the HTTP Body</option>
						<option value="HTTP Headers">in HTTP headers</option>
						<option value="mixed">mixed</option>
					</select>
					
					<label for="input-isObject">Is the input a complex object?
						<p>For example, XML, JSON, etc.</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-isObject" value="yes">yes</label>
						<label><input type="radio" name="input-isObject" value="no">no</label>
					</div>
					<!-- select id="input-object" name="input-object">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->
					
					<label for="input-hasDatatype">Is the data-type of the parameters stated?
					<p>For example, the parameter 'name' is a string and the parameter 'age' is an integer</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-hasDatatype" value="yes">yes</label>
						<label><input type="radio" name="input-hasDatatype" value="no">no</label>
					</div>
					<!-- select id="input-datatype" name="input-datatype">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->
					
					
					<label for="input-links">Does the API description give links between the outputs and inputs of the different operations?
					<p>For example, the output of operation 'getUserName' can be used as input to the operation 'getPhoneNumber'</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-links" value="yes">yes</label>
						<label><input type="radio" name="input-links" value="no">no</label>
					</div>
					<!--select id="input-links" name="input-links">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->
					
					<label for="input-hasSessionInfo">Does the invocation require any information related to the state of the client?
					<p>For example, session id, page number, request id - http://example.com/ad8b-0800200c9a66/news/, where 0800200c9a66 is the session id</p>
					</label>
					
					<div class="radio">
						<label><input type="radio" name="input-hasSessionInfo" value="yes">yes</label>
						<label><input type="radio" name="input-hasSessionInfo" value="no">no</label>
					</div>
					<!--select id="input-session" name="input-session">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->
					
				</fieldset>
				
				
				<fieldset class="half last">
					<legend>Parameter options</legend>
					
					<h4>Does the API use:</h4>
					
					<label for="input-hasOptionalParams">Optional parameters
					<p>No input value needs to be provided</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-hasOptionalParams" value="yes">yes</label>
						<label><input type="radio" name="input-hasOptionalParams" value="no">no</label>
					</div>
					
					<label for="input-hasRequiredParams">Required parameters
					<p>An input value must be provided</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-hasRequiredParams" value="yes">yes</label>
						<label><input type="radio" name="input-hasRequiredParams" value="no">no</label>
					</div>
					<!-- select id="param-optional" name="param-optional">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->
										
					<label for="input-hasDefaultParams">Default values
					<p>In case no input value is provided, there is a default value used</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-hasDefaultParams" value="yes">yes</label>
						<label><input type="radio" name="input-hasDefaultParams" value="no">no</label>
					</div>
					<!-- select id="param-default" name="param-default">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->
										
					<label for="input-hasCodedParams">Coded values
						<p>For example, 'en' instead of English</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-hasCodedParams" value="yes">yes</label>
						<label><input type="radio" name="input-hasCodedParams" value="no">no</label>
					</div>
					<!--select id="param-coded" name="param-coded">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->
										
					<label for="input-hasAltParams">Alternative values
						<p>For example, the input can have values 1, 2 or 3</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-hasAltParams" value="yes">yes</label>
						<label><input type="radio" name="input-hasAltParams" value="no">no</label>
					</div>
					<!-- select id="param-alt" name="param-alt">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->									

					<label for="input-hasBoolParams">Boolean values
					<p>Input with values true/false, 0/1, yes/no</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="input-hasBoolParams" value="yes">yes</label>
						<label><input type="radio" name="input-hasBoolParams" value="no">no</label>
					</div>
					<!--select id="param-bool" name="param-bool">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select-->									
				</fieldset>
				
				<menu>
					<button class="back">« Back</button>
					<button class="next">Next »</button>
				</menu>
			</section>
			
			
			<section id="section3">
				<h2>Output details</h2>
				
				
				
				<fieldset class="half">
					<legend>Output Format</legend>
					
					<label for="output-format">What is the format of the output?</label>
					
					<div class="radio">
						<label><input type="checkbox" id="output-format1" name="output-format" value="XML">XML</label>
						<label><input type="checkbox" id="output-format2" name="output-format" value="JSON">JSON</label>
						<label><input type="checkbox" id="output-format3" name="output-format" value="RDF">RDF</label>
						<label><input type="checkbox" id="output-format4" name="output-format" value="CSV">CSV</label>
						<label><input type="checkbox" id="output-format5" name="output-format" value="text">text</label>
					</div>
					
					<div id="w-output-format" class="wrapper">
						<label for="output-format-other" class="full">Other</label>
						<input type="text" id="output-format6" name="output-format-other">
					</div>
					
					
					<label for="output-format-definition">How is the output format determined?</label>
					<select id="output-format-definition" name="output-format-definition">
						<option selected value="">please select...</option>
						<option value="parameter">as a parameter</option>
						<option value="URL">as part of the URL</option>
						<option value="extension">as file extension (*.xml)</option>
						<option value="conneg">via content negotiation</option>
					</select>

					<label for="output-hasSchema">Does the output have a schema definition?</label>
					<div class="radio">
						<label><input type="radio" name="output-hasSchema" value="yes">yes</label>
						<label><input type="radio" name="output-hasSchema" value="no">no</label>
					</div>
					<!-- select id="out-format-schema" name="out-format-schema">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select-->

				</fieldset>
				
				<fieldset class="half last">
					<legend>Error handling</legend>
					
					<label for="err-has">Does the API contain description of errors?</label>
					<div class="radio">
						<label><input type="radio" name="err-has" value="yes">yes</label>
						<label><input type="radio" name="err-has" value="no">no</label>
					</div>
					<!-- select id="out-err-doc" name="out-err-doc">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select-->
					
					<label for="err-useHttpErrs">Does the API use standard HTTP error codes?
					<p>For exmaple, 403 Forbidden or 404 Not Found</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="err-useHttpErrs" value="yes">yes</label>
						<label><input type="radio" name="err-useHttpErrs" value="no">no</label>
					</div>
					<!-- select id="out-err-http" name="out-err-http">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no (custom errors)</option>
					</select-->
					
				</fieldset>
				
				<menu>
					<button class="back">« Back</button>
					<button class="next">Next »</button>
				</menu>
			</section>
			
			
			
			<section id="section4">
				<h2 id="heading-descriptionDetails">Description details</h2>
				
				
				<fieldset class="half" id="examples">
					<legend>Examples</legend>
					
					<h4>Does the description provide:</h4>
					
					<label for="example-req">Example requests?</label>
					<div class="radio">
						<label><input type="radio" name="example-req" value="yes">yes</label>
						<label><input type="radio" name="example-req" value="no">no</label>
					</div>
					<!-- select id="desc-req" name="desc-req">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select-->
					
					<label for="example-resp">Example responses?</label>
					<div class="radio">
						<label><input type="radio" name="example-resp" value="yes">yes</label>
						<label><input type="radio" name="example-resp" value="no">no</label>
					</div>
					<!-- select id="desc-resp" name="desc-resp">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select-->
					
					<label for="desc-hasInvocUri">Does the description include an invocation URI (endpoint)?</label>
					<div class="radio">
						<label><input type="radio" name="desc-hasInvocUri" value="yes">yes</label>
						<label><input type="radio" name="desc-hasInvocUri" value="no">no</label>
					</div>
					
				</fieldset>
				
				<fieldset class="half last" id="URI-details">
					<legend>URI details</legend>
					
					<label for="uri-hasTemplates">Is the URI composed through URI templates?
					<p>For exmaple, http://ex.com/api/{token}/users/{id}.xml</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="uri-hasTemplates" value="yes">yes</label>
						<label><input type="radio" name="uri-hasTemplates" value="no">no</label>
					</div>
					<!-- select id="desc-tpl" name="desc-tpl">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select-->
					
					<label for="uri-hasQueryParams">Does the URI use query parameters?
					<p>For exmaple, http://ex.com/aip/getNews?date=2011-11-11, where the query parameter is 'date'</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="uri-hasQueryParams" value="yes">yes</label>
						<label><input type="radio" name="uri-hasQueryParams" value="no">no</label>
					</div>
					<!--select id="desc-query" name="desc-query">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select-->
					
					<label for="uri-hasVersionInfo">Does the URI include version numbers?
					<p>For exmaple, http://ex.com/api/version2/getNews</p>
					</label>
					<div class="radio">
						<label><input type="radio" name="uri-hasVersionInfo" value="yes">yes</label>
						<label><input type="radio" name="uri-hasVersionInfo" value="no">no</label>
					</div>
					<!--  select id="desc-version" name="desc-version">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select-->
	
				</fieldset>
				
				<!--  menu>
					<button class="back">« Back</button>
					<button class="next">Next »</button>
				</menu -->
				<h3>Thank you for participating! Please submit the survey by pressing the button below.</h3>
				
				<menu>
					<button class="back">« Back</button>
					<button type="submit">Submit survey</button>
				</menu>
				
			</section>
			
			<!-- last section -->
			<!-- 
			<section>
				<h2>Thank you</h2>
				<h3>Please submit the survey by pressing the button below</h3>
				
				<menu>
					<button type="submit">Submit survey</button>
				</menu>
			</section>
			 -->
		</form>
	</article>
	
	
<script>
$(function() {
	$('#progress span').last().text($('form section').length);
	
	function setStep(section) {
		var step = 0;
		$('form section').each(function() {
			step++;
			if (this == section) $('#progress span').first().text(step);
		});
	}
	
	$('button.next').click(function(event) {
		event.preventDefault();
		
		$section = $(this).parents('section');
		$next = $section.next('section');
		
		$section.slideUp();
		$next.slideDown();
		
		setStep($next[0]);
	});

	$('button.back').click(function(event) {
		event.preventDefault();
		
		$section = $(this).parents('section');
		$prev = $section.prev('section');
		
		$section.slideUp();
		$prev.slideDown();
		
		setStep($prev[0]);
	});
	
});
</script>
</body>
</html>
