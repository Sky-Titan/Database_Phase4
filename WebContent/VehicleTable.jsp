
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
<title>차량매물 보기</title>
</head>
<body>
	<div align="center">
	
	
		
		<h2>차량 매물</h2>
		
		<form action="VehicleTableDB.jsp" method="POST">
		
		제조사 : 
		<select name="makes" id="makes" onchange="making_models(this)">
		<%
		String make="no";

		if(session.getAttribute("make")!=null)
			make = session.getAttribute("make")+"";
		
		DBConnection connection = new DBConnection();
		
		String[] make_data=connection.selectMakes();
		System.out.println(make_data[1]);

		
		if(make.equals(make_data[0]))
		{
			out.println("<option value=\"All\" selected>"+make_data[0]+"</option>");
			
		}
		else
		{
			out.println("<option value=\"All\" >"+make_data[0]+"</option>");
		}
		for(int i=1;i<make_data.length;i++)
		{
			if(make.equals(make_data[i]))
			{
				out.println("<option value=\""+make_data[i]+"\" selected>"+make_data[i]+"</option>");
				
			}
			else
			{
				out.println("<option value=\""+make_data[i]+"\" >"+make_data[i]+"</option>");
			}
		}
		
		%>
		<script type="text/javascript">
		
		function making_models(makes)
		{
			 var form = document.createElement("form");
		     var make = makes.value;
	         form.setAttribute("charset", "UTF-8");

	         form.setAttribute("method", "Post");  //Post 방식

	         form.setAttribute("action", "ModelMaking.jsp"); //요청 보낼 주소



	         var hiddenField = document.createElement("input");

	         hiddenField.setAttribute("type", "text");

	         hiddenField.setAttribute("name", "make");

	         hiddenField.setAttribute("value", make);

	         form.appendChild(hiddenField);



	         document.body.appendChild(form);

	         form.submit();
		}
		function making_detailmodels(models)
		{
			 var form = document.createElement("form");
		     var model = models.value;
	         form.setAttribute("charset", "UTF-8");

	         form.setAttribute("method", "Post");  //Post 방식

	         form.setAttribute("action", "DetailedModelMaking.jsp"); //요청 보낼 주소



	         var hiddenField = document.createElement("input");

	         hiddenField.setAttribute("type", "text");

	         hiddenField.setAttribute("name", "model");

	         hiddenField.setAttribute("value", model);

	         form.appendChild(hiddenField);



	         document.body.appendChild(form);

	         form.submit();
		}
		function making_table(detailedmodels)
		{
			 var form = document.createElement("form");
		     var detailedmodel = detailedmodels.value;
	         form.setAttribute("charset", "UTF-8");

	         form.setAttribute("method", "Post");  //Post 방식

	         form.setAttribute("action", "ModelDetailedModelSearch.jsp"); //요청 보낼 주소



	         var hiddenField = document.createElement("input");

	         hiddenField.setAttribute("type", "text");

	         hiddenField.setAttribute("name", "detailedmodel");

	         hiddenField.setAttribute("value", detailedmodel);

	         form.appendChild(hiddenField);



	         document.body.appendChild(form);

	         form.submit();
		}
		
		</script>
		
		
		</select>
		모델 : 
		<select name="models" id="models" onchange=" making_detailmodels(this)">
		<%
		
		if(make.equals("no") || make.equals("All"))//세션값 없을때
		{
			out.println("<option value=\"\" selected></option>");
		}
		else
		{
			
			String[] temp = connection.selectModel(make);
			String[] models = new String[temp.length+1];
			models[0]="전체";
			for(int i = 1 ; i<models.length;i++)
			{
				models[i] = temp[i-1];
			}
			
			String model = (String)session.getAttribute("model");
			if(model==null)//세션값 없을때
			{
				out.println("<option value=\"All\" selected>"+models[0]+"</option>");
				
				for(int i=1; i < models.length;i++)
				{		
					out.println("<option value=\""+models[i]+"\">"+models[i]+"</option>");
				}	
			}
			else//세션값 있을때
			{
				if(model.equals(models[0]))
				{
					out.println("<option value=\"All\" selected>"+models[0]+"</option>");
				}
				else
				{
					out.println("<option value=\"All\" >"+models[0]+"</option>");
				}
				
				for(int i=1; i < models.length;i++)
				{	
					if(model.equals(models[i]))
						out.println("<option value=\""+models[i]+"\" selected>"+models[i]+"</option>");
					else
						out.println("<option value=\""+models[i]+"\">"+models[i]+"</option>");
				}	
			}
			
		}
		
		%>
		</select>
		<select name="detailed_model" id="detailed_model" onchange="making_table(this)">
		<%
		String model = (String)session.getAttribute("model");
		if(model==null || model.equals("All"))//세션값 없을때
		{
			out.println("<option value=\"\" selected></option>");
		}
		else//세션값 있을 때
		{
			String[] temp = connection.selectDetailedModel(model);
			String[] detailed_models = new String[temp.length+1];
			detailed_models[0] = "전체";
			
			for(int i =1; i<detailed_models.length;i++)
			{
				detailed_models[i] = temp[i-1];
			}
			
			String detailedmodel= (String)session.getAttribute("detailedModel");
			if(detailedmodel==null)
			{
				out.println("<option value=\"All\" selected>"+detailed_models[0]+"</option>");
				
				for(int i=1; i < detailed_models.length;i++)
				{		
					out.println("<option value=\""+detailed_models[i]+"\">"+detailed_models[i]+"</option>");
				}
			}
			else
			{
				if(detailedmodel.equals("All"))
				{
					out.println("<option value=\"All\" selected>"+detailed_models[0]+"</option>");
				}
				else
				{
					out.println("<option value=\"All\" >"+detailed_models[0]+"</option>");
				}
				
				for(int i=1; i < detailed_models.length;i++)
				{		
					if(detailedmodel.equals(detailed_models[i]))
						out.println("<option value=\""+detailed_models[i]+"\" selected>"+detailed_models[i]+"</option>");
					else
						out.println("<option value=\""+detailed_models[i]+"\" >"+detailed_models[i]+"</option>");
				}
			}
			
			
		}
		%>
		</select>
		
		<div style="width:100%; height:400px; overflow:auto">
		<% 
		boolean isAdmin=true;
		if(String.valueOf(session.getAttribute("isAdmin")).equals("false"))
			isAdmin=false;
		
		String header[] ={"차량 번호","주행거리(km)","모델","세부모델","가격(원)","연식","연료","색상","배기량(cc)","하이브리드","공개여부","제조사","차종","연비(km)","변속기","수정"};
		
		if(!isAdmin)//고객 모드일땐 공개여부 안보여줌
		{
			String[] temp2 = {"차량 번호","주행거리(km)","모델","세부모델","가격(원)","연식","연료","색상","배기량(cc)","하이브리드","제조사","차종","연비(km)","변속기","수정"};
			header = new String[temp2.length];
			for(int i=0;i<temp2.length;i++)
				header[i] = temp2[i];
		}
		
		String[][] data;//table 데이터
		if(session.getAttribute("VehicleData")==null)
		{
			System.out.println("테이블 데이터 null이다!!! ");
			String[][] temp = connection.selectVehicles(isAdmin);
			session.setAttribute("VehicleData", temp);
			data=temp;
		}
		else
		{
			System.out.println("테이블 데이터 세션이다!!! ");
			String[][] temp = (String[][])session.getAttribute("VehicleData");
			session.removeAttribute("VehicleData");
			session.removeValue("VehicleData");
			data=temp;
		}
		out.println("<table border=\"1\">");
		for(int k=0;k<header.length;k++)
			out.println("<th>"+header[k]+"</th>");
		for(int i=0;i<data.length;i++)
		{
			
			out.println("<tr>");
			
			for(int j=0;j<data[i].length;j++)
			{
				out.println("<td>"+data[i][j]+"</td>");
			}
			out.println("<td><input type=\"radio\" name=\"modifyVehicle\" value=\""+data[i][0]+"\"></td>");
			out.println("</tr>");
		}
		out.println("</table>");
		%>
		</div>
		
		</form>
	</div>
</body>
</html>