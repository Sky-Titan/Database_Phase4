
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
<title>매출액 결과</title>
</head>
<body>

	<div align="center">
	<h2>매출액 결과 보기</h2>	
	<%
	String make = request.getParameter("makes")+"";
	String year = request.getParameter("years")+"";
	String month = request.getParameter("months")+"";
	
	if(make!=null && make.equals("All"))
		make = "전체";
	if(year!=null && year.equals("All"))
		year = "전체";
	if(month!=null && month.equals("All"))
		month = "전체";
	
	System.out.println("받은값 : "+make+" "+year+" "+month);
	NeedMethods methods = new NeedMethods();
	long result = methods.calculate(make, year, month);
	System.out.println("계산결과 : "+result);
	
	if(make!=null && make.equals("전체"))
		make = "All";
	if(year!=null && year.equals("전체"))
	{
		year = "All";
		month = "no";
	}
	if(month!=null && month.equals("전체"))
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