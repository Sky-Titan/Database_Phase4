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
<title>�޴�</title>
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
		<br/><br/>
		<div align="Center">
				<%
				if((boolean)session.getAttribute("isAdmin"))
					out.println("<h1><i>������");
				else
					out.println("<h1><i>��");
				
				String button_width = "style=\"width: 100pt\"";
				
				session.removeAttribute("make");
				session.removeValue("make");
				session.removeAttribute("model");
				session.removeValue("model");
				
				%>
				�޴�</i></h1>
				<%!
		    public void helloWorld() {
		       System.out.println("wow");
		    }
			%>
			<br/><br/>
			<%
			
			DBConnection connection = new DBConnection();
			if(!connection.hasOrdered((String)session.getAttribute("id")))//�����̷� ������ ��õ �޴� ����
			{
				%><button onclick="location.href='RecommendVehicle.jsp'" <%=button_width %>><b>������õ�ޱ�</b></button><br/><br/><%
			}
			%>
			
			<button onclick="location.href='AccountModification.jsp'" <%=button_width %>><b>ȸ�� ���� ����</b></button>
			<br/>
			<br/>
			<button onclick="location.href='DeleteAccount.jsp'" <%=button_width %>><b>ȸ�� Ż��</b></button>
			<br/>
			<br/>
			<button onclick="location.href='VehicleTable.jsp'" <%=button_width %>><b>�Ź� ����</b></button>
			<br/>
			<br/>
			<button onclick="location.href='OrderTable.jsp'" <%=button_width %>><b>�ŷ����� ����</b></button>
			<br/>
			<br/>
			<button onclick="location.href='Logout.jsp'" <%=button_width %>><b>�α׾ƿ�</b></button>
		</div>
		

	
</body>
</html>