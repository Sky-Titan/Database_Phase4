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
<title>detail model making</title>
</head>
<body>
	<%
	DBConnection connection = new DBConnection();
	String model = request.getParameter("model");
	String make = (String)session.getAttribute("make");
	boolean isAdmin=(boolean)session.getAttribute("isAdmin");
	
	if(!model.equals("All"))
	{
		String [][] data= connection.selectVehiclesByModelname(model, isAdmin);
		session.setAttribute("VehicleData", data);
	}
	else
	{
		String [][] data= connection.selectVehicles(make, isAdmin);
		session.setAttribute("VehicleData", data);
	}
	session.setAttribute("model", model);
	response.sendRedirect("VehicleTable.jsp");
	%>
</body>
</html>