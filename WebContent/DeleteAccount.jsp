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
	//ȸ��Ż�� ��Ű��
	DBConnection connection = new DBConnection();
	String id = session.getAttribute("id")+"";

	
	if(((boolean)session.getAttribute("isAdmin")))//������ ������ ������ ���� �ּ� 1���̻� �����ϴ��� üũ
	{
		if(connection.countAdminAccount() <= 1)//���� ������ �����ڰ��� 1�� ������ ��� Ż�� �Ұ�
		{
			%>
			<script>
  			alert( '������ ������ �ּ� 1���̻��̿����մϴ�' );
  			location.href="AccountMenu.jsp";
			</script>
			<% 
		}
		
	}
	
	//Ż��
	if(connection.deleteAccount(id))
	{
		session.invalidate();
		%>
		<script>
			alert( 'Ż��Ϸ�' );
			location.href="SignIn.html";
		</script>
		<% 
	}
	else
	{
		%>
		<script>
			alert( 'Ż����� - �������� �߻�' );
			location.href="AccountMenu.jsp";
		</script>
		<% 
	}
	
	%>
</body>
</html>