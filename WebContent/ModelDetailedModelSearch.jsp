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
<title>table making</title>
</head>
<body>
	<%
	DBConnection connection = new DBConnection();
	String detailed_model = request.getParameter("detailedmodel");
	String model = (String)session.getAttribute("model");
	if(!detailed_model.equals("All"))
	{
		boolean isAdmin=true;
		if(((String)session.getAttribute("isAdmin")).equals("false"))
			isAdmin = false;
		String [][] data= connection.selectVehiclesByModelname(model, detailed_model, isAdmin);
		session.setAttribute("VehicleData", data);
	}
	session.setAttribute("detailedModel", detailed_model);
	response.sendRedirect("VehicleTable.jsp");
	%>
</body>
</html>