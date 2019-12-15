<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.*"%>
<%@page import="java.*"%>

<%@ page import="DBpackage.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>model making</title>
</head>
<body>
	<%
	DBConnection connection = new DBConnection();
	String make = request.getParameter("make");
	
	boolean isAdmin=true;
	if(((String)session.getAttribute("isAdmin")).equals("false"))
		isAdmin = false;
	
	if(!make.equals("All"))
	{
		String data[][] = connection.selectVehicles(make, isAdmin);
		session.setAttribute("VehicleData", data);
	}
	else
	{
		String data[][] = connection.selectVehicles(isAdmin);
		session.setAttribute("VehicleData", data);
	}
	session.setAttribute("make", make);
	session.removeAttribute("model");
	session.removeValue("model");
	session.removeAttribute("detailedModel");
	session.removeValue("detailedModel");
	response.sendRedirect("VehicleTable.jsp");
	%>
</body>
</html>