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
<title>register vehicle</title>
</head>
<body>
	<%
	DBConnection connection = new DBConnection();
	
	String namelist[] = {"vehiclenumber_modify","mileage_modify","model_modify","detailedmodel_modify","price_modify","modelyear_modify","fuel_modify","color_modify","capacity_modify","open_modify"};
	String list[]=new String[namelist.length];
	for(int i =0;i<list.length;i++)
	{
		list[i] = request.getParameter(namelist[i]);
		System.out.println("등록 : "+list[i]);
	}

		String modelyear = "TO_DATE('"+list[5]+"','yyyy-mm-dd')";
		
		String ishybridString;
		if(list[6].contains("+"))
			ishybridString = "1";
		else
			ishybridString = "0";
		
		String isopenString;
		
		if(list[9].equals("O"))
			isopenString = "1";
		else
			isopenString = "0";
		
		boolean result = connection.updateVehicles(list[0], list[1], list[2], list[3], list[4], modelyear, list[6], list[7], list[8], ishybridString, isopenString);
		if(result == true)//등록 완료
		{
			for(int i=0;i<namelist.length;i++)
			{
				session.removeAttribute(namelist[i]);
				session.removeValue(namelist[i]);
			}
			session.removeAttribute("VehicleData");
			session.removeValue("VehicleData");
			%>
			<script>
			alert('수정완료');
			location.href="VehicleTable.jsp";
			</script>
			<% 
			//response.sendRedirect("VehicleTable.jsp");
		}
		else//등록 실패
		{
			%>
			<script>
			alert('서버에러');
			location.href="ModifyVehicle.jsp";
			</script>
			<% 
		}	
	
	
	
	%>
</body>
</html>