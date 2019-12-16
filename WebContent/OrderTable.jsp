<%@page import="DBpackage.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>차량 거래내역</title>
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
	<div align="Center">
	<h1>차량거래내역</h1>
	<%
	String id = session.getAttribute("id")+"";
	
	boolean isAdmin = (boolean)session.getAttribute("isAdmin");
	
	
	if(isAdmin)
	{
		session.removeAttribute("makes");
	
		session.removeAttribute("years");
		session.removeAttribute("result");
		session.setAttribute("months", "no");
	%>
	
	<button onclick="location.href='setAll_true.jsp'" ><b>전체 거래 내역 보기</b></button>
	<button onclick="location.href='setAll_false.jsp'"><b>관리자 개인 거래 내역 보기</b></button>

	<button onclick="location.href='ShowSales.jsp'"><b>매출액 보기</b></button>
	<%
	}
	%>
	<button onclick="location.href='AccountMenu.jsp';"><b>뒤로 가기</b></button>
	
	<br/>
	<br/>
	<%
	boolean isAll=true;//true면 전체 거래내역, false면 관리자 개인거래내역
	
	if(session.getAttribute("isAll")==null)//null값이면 처음 접속이기 때문에 무조건 true
	{
		if(isAdmin)//관리자면 전체내역
			isAll=true;
		else//고객이면 개인내역
			isAll=false;
	}
	else
	{
		if(session.getAttribute("isAll").equals("false"))
		{
			isAll=false;
		}
	}
	String[] header = {"거래 번호","거래 날짜","구매자ID","모델","세부모델","가격(원)","연식","연료","색상","하이브리드"};
	String[][] data;
	DBConnection connection = new DBConnection();
	if(isAll)
		data = connection.selectOrderlist();//전체 내역 출력
	else
	{
		data = connection.selectOrderlist(id);//개인내역출력
	}
	
	%>
	<div style="width:100%; height:600px; overflow:auto">
	<% 
	out.println("<table border=\"1\">");
	for(int k=0;k<header.length;k++)
		out.println("<th bgcolor=\"#ffffff\" align=\"center\">"+header[k]+"</th>");
	for(int i=0;i<data.length;i++)
	{
		
		out.println("<tr>");
		
		for(int j=0;j<data[i].length;j++)
		{
			out.println("<td bgcolor=\"#ffffff\" align=\"center\">"+data[i][j]+"</td>");
		}
		
		out.println("</tr>");
	}
	out.println("</table>");
	%>
	</div>
	</div>
	
</body>
</html>