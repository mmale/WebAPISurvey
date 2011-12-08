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
	<script>
	
    </script>
</head>
<body>
	<%
	String redirectURL = "http://apisurvey.kmi.open.ac.uk/APIs?scope=classify&URI="+ request.getParameter("nextURI");
    response.sendRedirect(redirectURL);%>
</body>
</html>
