<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�޴�</title>
</head>
<body>
<div align="Center">
		<%
		if((boolean)session.getAttribute("isAdmin"))
			out.println("<h2>������");
		else
			out.println("<h2>��");
		
		
		session.removeAttribute("make");
		session.removeValue("make");
		session.removeAttribute("model");
		session.removeValue("model");
		
		%>
		�޴�</h2>
		<%!
    public void helloWorld() {
       System.out.println("wow");
    }
%>


		<input type="button" value="ȸ�� ���� ����" onclick="location.href='AccountModification.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="ȸ�� Ż��" onclick="location.href='DeleteAccount.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="�Ź� ����" onclick="location.href='VehicleTable.jsp'"/>
		<br/>
		<br/>
		<input type = "button" value="�Ź� ���Ǻ� �˻��ϱ�" onclick="location.href='ConditionSearch.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="�ŷ����� ����" onclick="location.href='OrderTable.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="�α׾ƿ�" onclick="location.href='Logout.jsp'"/>
		
		

	</div>
</body>
</html>