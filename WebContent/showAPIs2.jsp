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
		
		// debug
		//http://localhost:8080/WebContent/APIs?URI=http://localhost:8080/lpw/resource/apis/aol-video&debug=show
	</script>
	<article>
		<h1>Web API Survey</h1>
		<h2 id="progress">Step <span>1</span> of <span>~</span></h2>
		
		<form method="post" action="StoreClassification">
			<input type="hidden" name="debug" value="<%= request.getParameter("debug") %>">
			
			<section id="section1">
				<h2>Characteristics collectable from ProgrammableWeb’s API</h2>
				
				<fieldset class="half">
					<legend>Service</legend>
					
					<label for="name">Name</label>
					<input id="name" name="name" type="text" readonly value="<%= request.getAttribute("api.name")%>">
					
					<label for="desc">Summary</label>
					<textarea id="desc" name="desc" rows="3" cols="20" readonly><%= request.getAttribute("api.desc")%></textarea>
				</fieldset>
				
				<fieldset class="half">
					<legend>Service Details</legend>
					
					<label for="updated">Last updated</label>
					<input id="updated" name="updated" type="date" readonly value="<%= request.getAttribute("api.lastUpdated")%>">
					
					<label for="doc">Documentation URL</label>
					<input id="doc" name="doc" type="text" readonly value="<%= request.getAttribute("api.home")%>">
					
					<!-- 
					<label for="mashups">Number of Mashups</label>
					<input id="mashups" name="mashups" type="number" readonly value="<%-- = request.getAttribute("api.mashups") --%>">
					-->
				</fieldset>
				
				
				<fieldset class="checkboxes">
					<legend>Category</legend>
					
					<%= request.getAttribute("classes.all")%>
					
				</fieldset>
				
				<fieldset class="xhalf">
					<legend>Tags</legend>
					
					<label for="tags">Comma separated tags</label>
					<textarea id="tags" name="tags" rows="3" cols="20"></textarea>
				</fieldset>
				
				<fieldset class="half" id="auth-fieldset">
					<legend>Authentication</legend>
					
					<label for="auth">Authentication mechanism</label>
					<select id="auth" name="auth">
						<option selected value="">please select...</option> 
						<option value="none">No Authentication</option>
						<option value="API Key">API Key</option>
						<option value="Username and Password">Username and Password</option>
						<option value="OAuth">OAuth</option>
						<option value="HTTP Basic">HTTP Basic</option>
						<option value="HTTP Digest">HTTP Digest</option>
						<option value="Web API Operation">Web API Operation</option>
						<option value="Session Based">Session Based</option>
						<option value="Other">Other</option>
					</select>
					
					<div id="w-other-auth" class="wrapper" style="display:none">
						<label for="other-auth">Other</label>
						<input type="text" id="other-auth" name="other-auth">
						<script>
							$(function(){
								$('#auth').bind('change', function() {
									if ($(this).val() == "Other") {
										$('#w-other-auth').slideDown();
									} else {
										$('#w-other-auth').slideUp();
									}
								});
							});
						</script>
					</div>
					
					
					
					<label for="auth-medium">Method of transmitting authentication credentials</label>
					<select id="auth-medium" name="auth-medium">
						<option selected value="">please select...</option>
						<option value="URI">in the URL</option>
						<option value="HTTP Header">in a HTTP Header</option>
						<option value="HTTP Body">in the HTTP Body</option>
						<option value="unclear">unclear</option>
					</select>

					<label for="auth-desc">Authentication example
						<p>If the authentication method is unclear please paste an example below:</p>		
					</label>
					<textarea id="auth-desc" name="auth-desc" rows="3" cols="20" ></textarea>
					
					
				</fieldset>
				
				<fieldset class="half">
					<legend>Web API type</legend>
					
					<label for="webapi-type">Web API type</label>
					<select id="webapi-type" name="webapi-type">
						<option selected value="">please select...</option>
						<option value="RPC">RPC</option>
						<option value="REST">REST</option>
						<option value="hybrid">hybrid</option>
					</select>
					
					<div id="w-uri-struct" style="display:none">
						<label for="uri-struct">Does the URI reflect the hierarchical structure of the resources?</label>
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
					
					<label for="http-verb">HTTP method specified</label>
					<select id="http-verb" name="http-verb">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>
					
					<label for="noop">Number of operations</label>
					<select id="noop" name="noop">
						<option selected value="">please select...</option>
						<option value="1">1</option>
						<option value="2-10">2-10</option>
						<option value="11-50">11-50</option>
						<option value="51-100">51-100</option>
						<option value="101-200">101-200</option>
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
					
					<label for="input-method">Method of transmitting input parameters</label>
					<select id="input-method" name="input-method">
						<option selected value="">please select...</option>
						<option value="URL">in the URL</option>
						<option value="HTTP Body">in the HTTP Body</option>
						<option value="HTTP Headers">in HTTP headers</option>
						<option value="mixed">mixed</option>
					</select>
					
					<label for="input-object">Input is a complex object
						<p>For example: XML, JSON, etc.</p>
					</label>
					<select id="input-object" name="input-object">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>
					
					<label for="input-datatype">Is the data-type of the parameters stated</label>
					<select id="input-datatype" name="input-datatype">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>
					
					
					<label for="input-links">Does the API description give links between outputs and inputs of different operations?</label>
					<select id="input-links" name="input-links">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>
					
					<label for="input-session">Is there any session token passed as input?</label>
					<select id="input-session" name="input-session">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>
					
				</fieldset>
				
				
				<fieldset class="half">
					<legend>Parameter options</legend>
					
					<h4>Does the API use:</h4>
					
					<label for="param-optional">Optional parameters</label>
					<select id="param-optional" name="param-optional">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>
										
					<label for="param-default">Default values</label>
					<select id="param-default" name="param-default">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>
										
					<label for="param-coded">Coded values
						<p>For example:....</p>
					</label>
					<select id="param-coded" name="param-coded">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>
										
					<label for="param-alt">Alternative values</label>
					<select id="param-alt" name="param-alt">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>									

					<label for="param-bool">Boolean values</label>
					<select id="param-bool" name="param-bool">
						<option selected value="">please select...</option>
						<option value="no">no</option>
						<option value="yes">yes</option>
					</select>									
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
					
					<label for="out-format">What is the format of the output?</label>
					<select id="out-format" name="out-format">
						<option selected value="">please select...</option>
						<option value="XML">XML</option>
						<option value="JSON">JSON</option>
						<option value="RDF">RDF</option>
						<option value="CSV">CSV</option>
						<option value="text">Text</option>
						<option value="Other">Other</option>
					</select>
					
					<div id="w-out-format" class="wrapper" style="display:none">
						<label for="out-format-other">Other</label>
						<input type="text" id="out-format-other" name="out-format-other">
						<script>
							$(function(){
								$('#out-format').bind('change', function() {
									if ($(this).val() == "Other") {
										$('#w-out-format').slideDown();
									} else {
										$('#w-out-format').slideUp();
									}
								});
							});
						</script>
					</div>
					
					
					<label for="out-format-spec">How is the output format determined?</label>
					<select id="out-format-spec" name="out-format-spec">
						<option selected value="">please select...</option>
						<option value="parameter">as a parameter</option>
						<option value="URL">as part of the URL</option>
						<option value="extension">as file extension (*.xml)</option>
						<option value="conneg">via content negotiation</option>
					</select>

					<label for="out-format-schema">Does the output have a schema definition?</label>
					<select id="out-format-schema" name="out-format-schema">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select>

				</fieldset>
				
				<fieldset class="half">
					<legend>Error handling</legend>
					
					<label for="out-err-doc">Does the API document errors?</label>
					<select id="out-err-doc" name="out-err-doc">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select>
					
					<label for="out-err-http">Does the API use standard HTTP error codes?</label>
					<select id="out-err-http" name="out-err-http">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no (custom errors)</option>
					</select>
					
				</fieldset>
				
				<menu>
					<button class="back">« Back</button>
					<button class="next">Next »</button>
				</menu>
			</section>
			
			
			
			<section id="section4">
				<h2>Description details</h2>
				
				
				<fieldset class="half">
					<legend>Examples</legend>
					
					<h4>Does the description provide:</h4>
					
					<label for="desc-req">Example requests?</label>
					<select id="desc-req" name="desc-req">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select>
					
					<label for="desc-resp">Example responses?</label>
					<select id="desc-resp" name="desc-resp">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select>
					
					
				</fieldset>
				
				<fieldset class="half">
					<legend>URI details</legend>
					
					<label for="desc-endpoint">Does the description include an invocation URI (endpoint)?</label>
					<select id="desc-endpoint" name="desc-endpoint">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select>
					
					<label for="desc-tpl">Is the URI composed through URI templates?</label>
					<select id="desc-tpl" name="desc-tpl">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select>
					
					<label for="desc-query">Does the URI use query parameters?</label>
					<select id="desc-query" name="desc-query">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select>
					
					<label for="desc-version">Does the URI include version numbers?</label>
					<select id="desc-version" name="desc-version">
						<option selected value="">please select...</option>
						<option value="yes">yes</option>
						<option value="no">no</option>
					</select>
					
					
					
				</fieldset>
				
				<!--  menu>
					<button class="back">« Back</button>
					<button class="next">Next »</button>
				</menu -->
				<h3>Please submit the survey by pressing the button below</h3>
				
				<menu>
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
