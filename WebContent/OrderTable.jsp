<%@page import="DBpackage.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �ŷ�����</title>
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
	<h1>�����ŷ�����</h1>
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
	
	<button onclick="location.href='setAll_true.jsp'" ><b>��ü �ŷ� ���� ����</b></button>
	<button onclick="location.href='setAll_false.jsp'"><b>������ ���� �ŷ� ���� ����</b></button>

	<button onclick="location.href='ShowSales.jsp'"><b>����� ����</b></button>
	<%
	}
	%>
	<button onclick="location.href='AccountMenu.jsp';"><b>�ڷ� ����</b></button>
	
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