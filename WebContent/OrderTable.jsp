<%@page import="DBpackage.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>차량 거래내역</title>
</head>
<body>
	<div align="Center">
	<h2>차량거래내역</h2>
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
	
	<input type = "button" value="전체 거래 내역 보기" onclick="location.href='setAll_true.jsp'" >
	<input type = "button" value="관리자 개인 거래 내역 보기" onclick="location.href='setAll_false.jsp'">
	<input type = "button" value="매출액 보기" onclick="location.href='ShowSales.jsp'">
	
	<%
	}
	%>
	<input type = "button" value="뒤로가기 " onclick="history.back(-1);"/>
	
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
	<div style="width:100%; height:400px; overflow:auto">
	<% 
	out.println("<table border=\"1\">");
	for(int k=0;k<header.length;k++)
		out.println("<th>"+header[k]+"</th>");
	for(int i=0;i<data.length;i++)
	{
		
		out.println("<tr>");
		
		for(int j=0;j<data[i].length;j++)
		{
			out.println("<td>"+data[i][j]+"</td>");
		}
		
		out.println("</tr>");
	}
	out.println("</table>");
	%>
	</div>
	</div>
	
</body>
</html>