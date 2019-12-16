<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>condition search making DM</title>
</head>
<body>

	<%
	String list[] = {"category","fuel","color","capacity","transmission","model","detailedmodel","category_input","fuel_input","color_input","capacity_input","transmission_input","model_input","detailedmodel_input"};
	String listdata[] = new String[list.length];
	for(int i=0;i<listdata.length;i++)
	{
		listdata[i] = request.getParameter(list[i]);
		session.setAttribute(list[i]+"_search", listdata[i]);
	}
	response.sendRedirect("ConditionSearch.jsp");
	%>

</body>
</html>