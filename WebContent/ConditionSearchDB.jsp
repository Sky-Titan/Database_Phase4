<%@page import="java.util.ArrayList"%>
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
<title>condition search</title>
</head>
<body>

	<%
	
	DBConnection connection = new DBConnection();
	
	String list[] = {"category_input","fuel_input","color_input","capacity_input","transmission_input","model_input","detailedmodel_input"};
	String listdata[] = new String[list.length];
	for(int i=0;i<listdata.length;i++)
	{
		listdata[i] = request.getParameter(list[i]);
	}
	
	ArrayList<String> category_result = new ArrayList<>(), fuel_result= new ArrayList<>(),color_result= new ArrayList<>(), capacity_result= new ArrayList<>()
			, transmission_result= new ArrayList<>(), model_result= new ArrayList<>(), detailedmodel_result= new ArrayList<>();
	
	for(int i=0;i<listdata.length;i++)
	{
		StringTokenizer strtok = new StringTokenizer(listdata[i]," ");
		
		switch(i)
		{
			case 0:
				
				while(strtok.hasMoreTokens())
					category_result.add(strtok.nextToken());
				break;
			case 1:
		
				while(strtok.hasMoreTokens())
					fuel_result.add(strtok.nextToken());
				break;
			case 2:
				
				while(strtok.hasMoreTokens())
					color_result.add(strtok.nextToken());
				break;
			case 3:
				
				while(strtok.hasMoreTokens())
					capacity_result.add(strtok.nextToken());
				break;
			case 4:
		
				while(strtok.hasMoreTokens())
					transmission_result.add(strtok.nextToken());
				break;
			case 5:
				
				while(strtok.hasMoreTokens())
					model_result.add(strtok.nextToken());
				break;
			case 6:
				
				while(strtok.hasMoreTokens())
					detailedmodel_result.add(strtok.nextToken());
				break;				
		}	
	}
	boolean isAdmin = (boolean)session.getAttribute("isAdmin");
	String[][] data = connection.voptionBy(isAdmin, category_result, color_result, capacity_result, fuel_result, model_result, detailedmodel_result, transmission_result);
	session.setAttribute("VehicleData",data);
	
	response.sendRedirect("VehicleTable.jsp");
	%>
</body>
</html>