<%@page import="java.sql.*"%>
<%@ page import="DBpackage.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>db�� �α��� ó��</title>
</head>
<body>
	<%
	// for docker
			DBConnection connection = new DBConnection();
			
			
			String id = request.getParameter("ID");
			String pw = request.getParameter("pw");
			String[] results = connection.signInDB(id);
			if(results[0]==null)//ȸ�� �������� ����
			{
				//�޽��� ���� sigin.html��
				%>
				<script>
      			alert( '�ش� ���̵�� �������� �ʽ��ϴ�.' );
      			location.href="SignIn.html";
    			</script>
				<% 

			  
			}
			else
			{
				if(pw.equals(results[1]))//��й�ȣ �´��� ���� Ȯ��
				{
					if(connection.isAdmin(id) == true)//���������� Ȯ��
					{
						//�����ڸ޴� ����
						System.out.println("������");
						response.sendRedirect("AdministratorMenu.html");
						
					}
					else
					{
						//���� �޴� ����
						response.sendRedirect("CustomerMenu.html");
						
					}
					//�޴� â���� �̵�
				}
				else//��й�ȣ Ʋ��
				{
					//�޽��� ���� sigin.html��
					%>
					<script>
	      			alert( '��й�ȣ�� Ʋ�Ƚ��ϴ�.' );
	      			location.href="SignIn.html";
	    			</script>
					<% 
				 	
				}
			}
	%>
</body>
</html>