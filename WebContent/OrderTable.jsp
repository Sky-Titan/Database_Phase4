<%@page import="DBpackage.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �ŷ�����</title>
</head>
<body>
	<div align="Center">
	<h2>�����ŷ�����</h2>
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
	
	<input type = "button" value="��ü �ŷ� ���� ����" onclick="location.href='setAll_true.jsp'" >
	<input type = "button" value="������ ���� �ŷ� ���� ����" onclick="location.href='setAll_false.jsp'">
	<input type = "button" value="����� ����" onclick="location.href='ShowSales.jsp'">
	
	<%
	}
	%>
	<input type = "button" value="�ڷΰ��� " onclick="history.back(-1);"/>
	
	<br/>
	<br/>
	<%
	boolean isAll=true;//true�� ��ü �ŷ�����, false�� ������ ���ΰŷ�����
	
	if(session.getAttribute("isAll")==null)//null���̸� ó�� �����̱� ������ ������ true
	{
		if(isAdmin)//�����ڸ� ��ü����
			isAll=true;
		else//���̸� ���γ���
			isAll=false;
	}
	else
	{
		if(session.getAttribute("isAll").equals("false"))
		{
			isAll=false;
		}
	}
	String[] header = {"�ŷ� ��ȣ","�ŷ� ��¥","������ID","��","���θ�","����(��)","����","����","����","���̺긮��"};
	String[][] data;
	DBConnection connection = new DBConnection();
	if(isAll)
		data = connection.selectOrderlist();//��ü ���� ���
	else
	{
		data = connection.selectOrderlist(id);//���γ������
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