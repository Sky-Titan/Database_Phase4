
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
<title>����� ���</title>
</head>
<body>

	<div align="center">
	<h2>����� ��� ����</h2>	
	<%
	String make = request.getParameter("makes")+"";
	String year = request.getParameter("years")+"";
	String month = request.getParameter("months")+"";
	
	if(make!=null && make.equals("All"))
		make = "��ü";
	if(year!=null && year.equals("All"))
		year = "��ü";
	if(month!=null && month.equals("All"))
		month = "��ü";
	
	System.out.println("������ : "+make+" "+year+" "+month);
	NeedMethods methods = new NeedMethods();
	long result = methods.calculate(make, year, month);
	System.out.println("����� : "+result);
	
	if(make!=null && make.equals("��ü"))
		make = "All";
	if(year!=null && year.equals("��ü"))
	{
		year = "All";
		month = "no";
	}
	if(month!=null && month.equals("��ü"))
		month = "All";
	
	session.setAttribute("makes", make);
	session.setAttribute("years", year);
	session.setAttribute("months", month);
	session.setAttribute("result", String.valueOf(result));
	response.sendRedirect("ShowSales.jsp");
	%>
	</div>
</body>
</html>