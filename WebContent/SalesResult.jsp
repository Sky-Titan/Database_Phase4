
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
<style >
	
	#mgLeft{
	margin-left: 100px;
	}
	#mgTable{
	margin-left: 650px;
	}
	#mgRight{
	margin-right: 50px;
	}
	#td-center{
	padding:1px; 
	text-align:center;
	}
	#center
	{
	align-self: center;
	}
	button{
	 border: 2px solid blue; 
	 background-color: #ffffff;
	 
	 border-top-left-radius: 5px; 
	 border-bottom-left-radius: 5px; 
	 border-top-right-radius: 5px;
	 border-bottom-right-radius: 5px;

	 color: blue; 
	 padding: 5px;}
		body{
				
				background: linear-gradient( to right, skyblue, white, skyblue );
				background-size: cover;
				height:100%;
			
               }
	
</style>
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