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
<title>차량 추천받기</title>
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
	
		<script type="text/javascript">
		
		function submit()
		{
			var frm = document.forms["vehicleinfo"];
			frm.submit();
		}
		</script>
		<%
		String td_width="120";
		String header_width="100";
		String td_color="#FFFF00";
		String tr_height="40";
		
		DBConnection connection = new DBConnection();
		
		ArrayList<String> vehiclenumbers= connection.selectVehicleNumbers();
		Random random=  new Random();
		
		//랜덤으로 차량 매물 하나 가지고옴
		String vehiclenumber = vehiclenumbers.get(random.nextInt(vehiclenumbers.size()));
		String data[] = connection.selectSingleVehicleAll(vehiclenumber);
		
		String samplenumber = String.valueOf(random.nextInt(15)+1)+"";
		%>
	
	<div align="center">
		<br/><br/>
		<h1><I>차량 추천 서비스</I></h1>
		<div align = "right" id="mgRight">
			<button  onclick="location.href='AccountMenu.jsp'" style="HEIGHT: 30pt"><b>뒤로가기</b></button>
			<button onclick="location.href='RecommendVehicle.jsp'" style="HEIGHT: 30pt"><b>다른 차량 추천받기</b></button>
		</div>
		</div>
	<form action="BuyVehicle.jsp" method="POST" name="vehicleinfo">
		<input type="hidden" name="vehicleNumber" value="<%=vehiclenumber%>"/>
		<div align="center">

		<br/>
			<img id ="mgLeft" align="left" src="images/sample<%=samplenumber%>.png" alt="My Image" width="500" height="300" />	
			<div  id="mgTable" align="left">
				<table border="1">
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>차량번호</b></td><td align="center" width="<%=td_width%>"><%=data[0] %></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>색상</b></td><td align="center" width="<%=td_width%>"><%=data[7]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>주행거리</b></td><td align="center" width="<%=td_width%>"><%=data[1]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>배기량(cc)</b></td><td align="center" width="<%=td_width%>"><%=data[8]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>모델</b></td><td align="center" width="<%=td_width%>"><%=data[2]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>하이브리드</b></td><td align="center" width="<%=td_width%>"><%=data[9]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>세부모델</b></td><td align="center" width="<%=td_width%>"><%=data[3]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>제조사</b></td><td align="center" width="<%=td_width%>"><%=data[10]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>가격(원)</b></td><td align="center" width="<%=td_width%>"><%=data[4]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>차종</b></td><td align="center" width="<%=td_width%>"><%=data[11]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>연식</b></td><td align="center" width="<%=td_width%>"><%=data[5]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>연비(km)</b></td><td align="center" width="<%=td_width%>"><%=data[12]%></td>
					</tr>
					<tr height="<%=tr_height%>">
						<td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>연료</b></td><td align="center" width="<%=td_width%>"><%=data[6]%></td><td bgcolor="<%=td_color %>" align="center" width="<%=header_width%>"><b>변속기</b></td><td align="center" width="<%=td_width%>"><%=data[13]%></td>
					</tr>		
					
				</table>
			</div>	

			<br/>
			<div align="center">
			<button onclick = "submit();" style="HEIGHT: 30pt"><b>바로 구매하기</b></button>
			</div>
		</form>
	
</body>
</html>