<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>All APIs</title>
</head>
<body>
<table border="0">
	<tr> <th>API</th><th>Description</th><th>API Home</th>
	</tr>
	<tr>
		<td><%= request.getAttribute("api.url")%></td>
		<td><%= request.getAttribute("api.desc")%></td>
		<td><%= request.getAttribute("api.home")%></td>
	</tr>
</table>
<table border="0">
	<tr> <th>Categories</th>
	</tr>
	<tr>
		<td><%= request.getAttribute("classes.all")%></td>
	</tr>
</table>
</body>
</html>