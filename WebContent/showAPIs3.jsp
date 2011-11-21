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
					<a href="http://kmi-web17.open.ac.uk:8080/apis/APIs?scope=classify&URI=<%= request.getAttribute("nextURI")%>" target="_new_<%= request.getAttribute("nextURI")%>">
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
					<p>Select all categories that can be used to describe the type of API. (PIM = Personal information management)</p>
					
					
					<%= request.getAttribute("classes.all")%>
				
				</fieldset>
			
				<menu>
					<button type="submit">Next API</button>
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
