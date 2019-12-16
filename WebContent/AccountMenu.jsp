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
<title>메뉴</title>
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
					out.println("<h1><i>관리자");
				else
					out.println("<h1><i>고객");
				
				String button_width = "style=\"width: 100pt\"";
				
				session.removeAttribute("make");
				session.removeValue("make");
				session.removeAttribute("model");
				session.removeValue("model");
				
				%>
				메뉴</i></h1>
				<%!
		    public void helloWorld() {
		       System.out.println("wow");
		    }
			%>
			<br/><br/>
			<%
			
			DBConnection connection = new DBConnection();
			if(!connection.hasOrdered((String)session.getAttribute("id")))//구매이력 없으면 추천 메뉴 보임
			{
				%><button onclick="location.href='RecommendVehicle.jsp'" <%=button_width %>><b>차량추천받기</b></button><br/><br/><%
			}
			%>
			
			<button onclick="location.href='AccountModification.jsp'" <%=button_width %>><b>회원 정보 수정</b></button>
			<br/>
			<br/>
			<button onclick="location.href='DeleteAccount.jsp'" <%=button_width %>><b>회원 탈퇴</b></button>
			<br/>
			<br/>
			<button onclick="location.href='VehicleTable.jsp'" <%=button_width %>><b>매물 보기</b></button>
			<br/>
			<br/>
			<button onclick="location.href='OrderTable.jsp'" <%=button_width %>><b>거래내역 보기</b></button>
			<br/>
			<br/>
			<button onclick="location.href='Logout.jsp'" <%=button_width %>><b>로그아웃</b></button>
		</div>
		

	
</body>
</html>