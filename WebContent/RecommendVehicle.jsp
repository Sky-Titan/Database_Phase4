<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
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
<title>���� ��õ�ޱ�</title>
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
	
</style>
</head>
<body>
	
		<%
		String td_width="120";
		String header_width="100";
		String td_color="#FFFF00";
		String tr_height="40";
		
		DBConnection connection = new DBConnection();
		
		ArrayList<String> vehiclenumbers= connection.selectVehicleNumbers();
		Random random=  new Random();
		
		//�������� ���� �Ź� �ϳ� �������
		String vehiclenumber = vehiclenumbers.get(random.nextInt(vehiclenumbers.size()));
		String data[] = connection.selectSingleVehicleAll(vehiclenumber);
		
		String samplenumber = String.valueOf(random.nextInt(15)+1)+"";
		%>
	
	<form action="BuyVehicle.jsp" method="POST">
		<div align="center">
		<br/><br/>
		<h1>���� ��õ ����</h1>
		<div align = "right" id="mgRight">
			<input type="button" value="�ڷΰ���" onclick="history.back(-1)" style="HEIGHT: 30pt"/>
			<input type="button" value="�ٸ� ���� ��õ�ޱ�" onclick="window.location.reload()" style="HEIGHT: 30pt"/>
		</div>

		<br/>
			<img id ="mgLeft" align="left" src="images/sample<%=samplenumber%>.png" alt="My Image" width="500" height="300" />	
			<div  id="mgTable" align="left">
				<table border="1">
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>������ȣ</b></td><td align="center" width="<%=td_width%>"><%=data[0] %></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>����</b></td><td align="center" width="<%=td_width%>"><%=data[7]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>����Ÿ�</b></td><td align="center" width="<%=td_width%>"><%=data[1]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>��ⷮ(cc)</b></td><td align="center" width="<%=td_width%>"><%=data[8]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>��</b></td><td align="center" width="<%=td_width%>"><%=data[2]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>���̺긮��</b></td><td align="center" width="<%=td_width%>"><%=data[9]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>���θ�</b></td><td align="center" width="<%=td_width%>"><%=data[3]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>������</b></td><td align="center" width="<%=td_width%>"><%=data[10]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>����(��)</b></td><td align="center" width="<%=td_width%>"><%=data[4]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>����</b></td><td align="center" width="<%=td_width%>"><%=data[11]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>����</b></td><td align="center" width="<%=td_width%>"><%=data[5]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>����(km)</b></td><td align="center" width="<%=td_width%>"><%=data[12]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>����</b></td><td align="center" width="<%=td_width%>"><%=data[6]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>���ӱ�</b></td><td align="center" width="<%=td_width%>"><%=data[13]%></td>
					</tr>		
					
				</table>
			</div>	

			<br/><br/>
			<div align="center">
			<input type="submit" value="�ٷ� �����ϱ�" style="HEIGHT: 30pt"/>
			</div>
		</form>
	
</body>
</html>