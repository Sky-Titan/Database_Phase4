<%@page import="java.sql.*"%>
<%@ page import="DBpackage.*" %>
<%@page import="java.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ����������</title>
</head>
<body>

	<%
	DBConnection connection = new DBConnection();
	
	//ȸ������ �ҷ�����
	String accountInfo[];
	String id = session.getAttribute("id")+"";
	accountInfo = connection.selectAccountInfo(id);
	%>
	<div align="Center">
	<h2>ȸ������ ����</h2>
	<h3>*�� �ʼ������� �Է��ؾ��մϴ�.</h3>
	
	<form action="AccountModificationDB.jsp" method="POST" >
	
		��й�ȣ : (*)
		<br/>
		<br/>
		<input type="password" name="pw" size = "15" value="<% out.print(accountInfo[4]); %>"/>
		<br/>
		<br/>
		��й�ȣ Ȯ�� : (*)
		<br/>
		<br/>
		<input type="password" name="pwConfirm" size = "15" value="<% out.print(accountInfo[4]); %>"/>
		<br/>
		<br/>
		�������� : (*)
		<br/>
		<br/>
		<select name="kind">
		 <%
		 if(accountInfo[1].equals("Admin"))
		 {
		 %>
			<option value="Admin" selected>������</option>
			<option value="Customer">��</option>
		<% 
		 }
		 else
		 {
		%>
			<option value="Admin">������</option>
			<option value="Customer" selected>��</option>
		<% 
		 }
		%>
		</select>
		<br/>
		<br/>
		�̸� : (*)
		<br/>
		<br/>
		<input type="text" name="fname" size = "15" value="<% out.print(accountInfo[2]); %>"/>
		<br/>
		<br/>
		�� : (*)
		<br/>
		<br/>
		<input type="text" name="lname" size = "15" value="<% out.print(accountInfo[3]); %>"/>
		<br/>
		<br/>
		�޴�����ȣ : (*)
		<br/>
		'-'���� �Է�
		<br/>
		<br/>
		<input type="text" name="phonenumber" size="20" value="<% out.print(accountInfo[5]); %>"/>
		<br/>
		<br/>
		������� :
		<br/>
		<br/>
		<input type="date" name="bdate" min="1950-01-01" max="2000-12-31" value="<% 
		if(accountInfo[6]!=null)
			out.print(accountInfo[6]);
		else
			out.print("");
		%>"/>
		<br/>
		<br/>
		���� :
		<br/>
		<br/>
		<select name="gender" >
			<option value="" <% if(accountInfo[7]!=null && accountInfo[7].equals("")) { %>selected<%} %>>���þ���</option>
			<option value="Male" <% if(accountInfo[7]!=null &&accountInfo[7].equals("Male")) { %>selected<%} %>>��</option>
			<option value="Female" <%if(accountInfo[7]!=null &&accountInfo[7].equals("Female")) { %>selected<%} %>>��</option>
		</select>
		<br/>
		<br/>
		���� :
		<br/>
		<br/>
		<input type="text" name="job" size = "15" value="<% 
		if(accountInfo[8]!=null)
			out.print(accountInfo[8]);
		else
			out.print("");
		%>"/>
		<br/>
		<br/>
		���� :
		<br/>
		<br/>
		<input type="text" name="country" size = "15" value="<% 
		if(accountInfo[9]!=null)
			out.print(accountInfo[9]);
		else
			out.print("");
		%>"
		/>
		<br/>
		<br/>
		���� :
		<br/>
		<br/>
		<input type="text" name="city" size = "15" value="<% 
		if(accountInfo[10]!=null)
			out.print(accountInfo[10]);
		else
			out.print("");
		%>"/>
		<br/>
		<br/>
		�ּ� :
		<br/>
		<br/>
		<input type="text" name="detail_address" size = "15" value="<% 
		if(accountInfo[11]!=null)
			out.print(accountInfo[11]);
		else
			out.print("");
		%>"/>
		<br/>
		<br/>
		<input type="submit" value="�Ϸ�"/>
		<input type="button" value="���" onclick="history.back(-1);"/>
	</form>
	</div>
</body>
</html>