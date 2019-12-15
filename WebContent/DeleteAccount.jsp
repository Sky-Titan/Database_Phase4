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
<title>Insert title here</title>
</head>
<body>
	<%
	//회원탈퇴 시키기
	DBConnection connection = new DBConnection();
	String id = session.getAttribute("id")+"";

	
	if(((boolean)session.getAttribute("isAdmin")))//관리자 계정은 관리자 계정 최소 1개이상 존재하는지 체크
	{
		if(connection.countAdminAccount() <= 1)//현재 서버에 관리자계정 1개 이하인 경우 탈퇴 불가
		{
			%>
			<script>
  			alert( '관리자 계정은 최소 1개이상이여야합니다' );
  			location.href="AccountMenu.jsp";
			</script>
			<% 
		}
		
	}
	
	//탈퇴
	if(connection.deleteAccount(id))
	{
		session.invalidate();
		%>
		<script>
			alert( '탈퇴완료' );
			location.href="SignIn.html";
		</script>
		<% 
	}
	else
	{
		%>
		<script>
			alert( '탈퇴실패 - 서버에러 발생' );
			location.href="AccountMenu.jsp";
		</script>
		<% 
	}
	
	%>
</body>
</html>