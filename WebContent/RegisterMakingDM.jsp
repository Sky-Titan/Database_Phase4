<%@page import="DBpackage.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>making Detail model</title>
</head>
<body>
	<%
	String namelist[] = {"vehiclenumber","model","mileage","price","modelyear","fuel","color","capacity","open"};
	String list[]=new String[namelist.length];
	for(int i =0;i<list.length;i++)
	{
		list[i] = request.getParameter(namelist[i]);
		session.setAttribute(namelist[i]+"_register", list[i]);
	}
	
	response.sendRedirect("RegisterVehicle.jsp");
	%>
</body>
</html>