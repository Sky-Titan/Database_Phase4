<%@page import="java.sql.*"%>
<%@ page import="DBpackage.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>SignInDB</title>
</head>
<body>
	<%
	// for docker
			DBConnection connection = new DBConnection();
			
			
			String id = request.getParameter("ID");
			String pw = request.getParameter("pw");
			String[] results = connection.signInDB(id);
			if(results[0]==null)//회원 존재하지 않음
			{
				//메시지 띄우고 sigin.html로
				%>
				<script>
      			alert( '해당 아이디는 존재하지 않습니다.' );
      			location.href="SignIn.html";
    			</script>
				<% 

			  
			}
			else
			{
				if(pw.equals(results[1]))//비밀번호 맞는지 여부 확인
				{
					if(connection.isAdmin(id) == true)//관리자인지 확인
					{
						//관리자메뉴 띄우기
						System.out.println("관리자");
						session.setAttribute("id", id);
						session.setAttribute("isAdmin", true);
						response.sendRedirect("AccountMenu.jsp");
						
					}
					else
					{
						//고객 메뉴 띄우기
						session.setAttribute("id", id);
						session.setAttribute("isAdmin", false);
						response.sendRedirect("AccountMenu.jsp");
						
					}
					//메뉴 창으로 이동
				}
				else//비밀번호 틀림
				{
					//메시지 띄우고 sigin.html로
					%>
					<script>
	      			alert( '비밀번호가 틀렸습니다.' );
	      			location.href="SignIn.html";
	    			</script>
					<% 
				 	
				}
			}
	%>
</body>
</html>