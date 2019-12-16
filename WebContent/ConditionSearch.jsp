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
<title>조건별 검색</title>
</head>
<body>
	<div align="center">
	
	<script>
	
	
	function categoryAdd(category) {
		var selected = category.value;
		if(selected!="All")
			document.getElementById("category_input").value+=selected+" ";
		else
			document.getElementById("category_input").value="";
	}
	
	function fuelAdd(fuel) {
		var selected = fuel.value;
		if(selected!="All")
			document.getElementById("fuel_input").value+=selected+" ";
		else
			document.getElementById("fuel_input").value="";
	}
	
	function colorAdd(color) {
		var selected = color.value;
		if(selected!="All")
			document.getElementById("color_input").value+=selected+" ";
		else
			document.getElementById("color_input").value="";
	}
	
	function capacityAdd(capacity) {
		var selected = capacity.value;
		if(selected!="All")
			document.getElementById("capacity_input").value+=selected+" ";
		else
			document.getElementById("capacity_input").value="";
	}
	
	function transmissionAdd(transmission) {
		var selected = transmission.value;
		if(selected!="All")
			document.getElementById("transmission_input").value+=selected+" ";
		else
			document.getElementById("transmission_input").value="";
	}
	
	function modelAdd(model) {
		var selected = model.value;
		if(selected!="All")
			document.getElementById("model_input").value+=selected+" ";
		else
			document.getElementById("model_input").value="";
		
		var form = document.createElement("form");
		var frm = document.forms["condition"];
		
		var category = frm.category_search.value;
		var fuel = frm.fuel_search.value;
		var color = frm.color_search.value;
		var capacity = frm.capacity_search.value;
		var transmission = frm.transmission_search.value;
	    var model = frm.model_search.value;
	    var detailedmodel = frm.detailedmodel_search.value;
	    
	    var category_input = frm.category_input.value;
		var fuel_input = frm.fuel_input.value;
		var color_input = frm.color_input.value;
		var capacity_input = frm.capacity_input.value;
		var transmission_input = frm.transmission_input.value;
	    var model_input = frm.model_input.value;
	    var detailedmodel_input = frm.detailedmodel_input.value;
	     
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  //Post 방식
        form.setAttribute("action", "ConditionSearchMakingDM.jsp"); //요청 보낼 주소

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "category");
        hiddenField.setAttribute("value", category);
        form.appendChild(hiddenField);
       
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "fuel");
        hiddenField.setAttribute("value", fuel);
        form.appendChild(hiddenField);
        
        
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "color");
        hiddenField.setAttribute("value", color);
        form.appendChild(hiddenField);
        
        
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "capacity");
        hiddenField.setAttribute("value", capacity);
        form.appendChild(hiddenField);
        
        
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "transmission");
        hiddenField.setAttribute("value", transmission);
        form.appendChild(hiddenField);
        
        
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "model");
        hiddenField.setAttribute("value", model);
        form.appendChild(hiddenField);
        
        
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "detailedmodel");
        hiddenField.setAttribute("value", detailedmodel);
        form.appendChild(hiddenField);
        
     
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "category_input");
        hiddenField.setAttribute("value", category_input);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "fuel_input");
        hiddenField.setAttribute("value", fuel_input);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "color_input");
        hiddenField.setAttribute("value", color_input);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "capacity_input");
        hiddenField.setAttribute("value", capacity_input);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "transmission_input");
        hiddenField.setAttribute("value", transmission_input);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "model_input");
        hiddenField.setAttribute("value", model_input);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "detailedmodel_input");
        hiddenField.setAttribute("value", detailedmodel_input);
        form.appendChild(hiddenField);
        
        document.body.appendChild(form);
        form.submit();
	}
	
	function detailedmodelAdd(detailedmodel) {
		var selected = detailedmodel.value;
		if(selected!="All")
			document.getElementById("detailedmodel_input").value+=selected+" ";
		else
			document.getElementById("detailedmodel_input").value="";
	}
	
	function checkBlank()
	{
		var frm = document.forms["condition"];
		if(frm.category_input.value=="" && frm.fuel_input.value=="" && frm.color_input.value=="" && frm.capacity_input.value=="" && frm.transmission_input.value=="" && frm.model_input.value=="" && frm.detailedmodel_input.value=="")
			alert('빈칸이 있습니다');
		else
		{	
				frm.submit();
		}
	}
	</script>
	
	<h2>조건 검색하기</h2>
	
		<%
		DBConnection connection = new DBConnection();
		
		String category_input_search = (String)session.getAttribute("category_input_search");
		String fuel_input_search = (String)session.getAttribute("fuel_input_search");
		String color_input_search = (String)session.getAttribute("color_input_search");
		String capacity_input_search = (String)session.getAttribute("capacity_input_search");
		String transmission_input_search = (String)session.getAttribute("transmission_input_search");
		String model_input_search = (String)session.getAttribute("model_input_search");
		String detailedmodel_input_search = (String)session.getAttribute("detailedmodel_input_search");
		%>
	<form action = "ConditionSearchDB.jsp" name = "condition" method="POST">
		
		카테고리 :
		<br/><br/> 
		<select name="category_search" id="category_search" onchange="categoryAdd(this)">
		
		<%
		String category_search = (String)session.getAttribute("category_search");
		String[] category_data = connection.selectCategories();
		
		
		if(category_search!=null && category_search.equals(category_data[0]))
		{
			out.println("<option value=\"All\" selected>"+category_data[0]+"</option>");
		}
		else
		{
			out.println("<option value=\"All\">"+category_data[0]+"</option>");
		}
		
		for(int i =1;i<category_data.length;i++)
		{
			if(category_search!=null && category_search.equals(category_data[i]))
			{
				out.println("<option value=\""+category_data[i]+"\" selected>"+category_data[i]+"</option>");
			}
			else
			{
				out.println("<option value=\""+category_data[i]+"\">"+category_data[i]+"</option>");
			}
		}
		%>
		</select>
		<br/><br/>
		<input type = "text" readonly="readonly" <% if(capacity_input_search!=null) out.println("value=\""+category_input_search+"\" "); else out.println("value=\"\""); %> name="category_input" id="category_input"/>
		<br/><br/>
		
		연료 :
		<br/><br/> 
		<select name="fuel_search" id="fuel_search" onchange="fuelAdd(this)">
		
		<%
		String fuel_search = (String)session.getAttribute("fuel_search");
		String temp[] = connection.selectFuel();
		String[] fuel_data = new String[temp.length+1];
		fuel_data[0] = "전체";
		for(int i=1;i<temp.length+1;i++)
			fuel_data[i] = temp[i-1];
		
		
		if(fuel_search!=null && fuel_search.equals(fuel_data[0]))
		{
			out.println("<option value=\"All\" selected>"+fuel_data[0]+"</option>");
		}
		else
		{
			out.println("<option value=\"All\">"+fuel_data[0]+"</option>");
		}
		
		for(int i =1;i<fuel_data.length;i++)
		{
			if(fuel_search!=null && fuel_search.equals(fuel_data[i]))
			{
				out.println("<option value=\""+fuel_data[i]+"\" selected>"+fuel_data[i]+"</option>");
			}
			else
			{
				out.println("<option value=\""+fuel_data[i]+"\">"+fuel_data[i]+"</option>");
			}
		}
		%>
		</select>
		<br/><br/>
		<input type = "text" readonly="readonly" <% if(fuel_input_search!=null) out.println("value=\""+fuel_input_search+"\" "); else out.println("value=\"\""); %> name="fuel_input" id="fuel_input"/>
		<br/><br/>
		
		색상 :
		<br/><br/> 
		<select name="color_search" id="color_search" onchange="colorAdd(this)">
		
		<%
		String color_search = (String)session.getAttribute("color_search");
		temp = connection.selectColor();
		String[] color_data = new String[temp.length+1];
		color_data[0] = "전체";
		for(int i=1;i<temp.length+1;i++)
			color_data[i] = temp[i-1];
		
		
		if(color_search!=null && color_search.equals(color_data[0]))
		{
			out.println("<option value=\"All\" selected>"+color_data[0]+"</option>");
		}
		else
		{
			out.println("<option value=\"All\">"+color_data[0]+"</option>");
		}
		
		for(int i =1;i<color_data.length;i++)
		{
			if(color_search!=null && color_search.equals(color_data[i]))
			{
				out.println("<option value=\""+color_data[i]+"\" selected>"+color_data[i]+"</option>");
			}
			else
			{
				out.println("<option value=\""+color_data[i]+"\">"+color_data[i]+"</option>");
			}
		}
		%>
		</select>
		<br/><br/>
		<input type = "text" readonly="readonly" <% if(color_input_search!=null) out.println("value=\""+color_input_search+"\" "); else out.println("value=\"\""); %> name="color_input" id="color_input"/>
		<br/><br/>
		
		배기량 :
		<br/><br/> 
		<select name="capacity_search" id="capacity_search" onchange="capacityAdd(this)">
		
		<%
		String capacity_search = (String)session.getAttribute("capacity_search");
		temp = connection.selectCapacity();
		String[] capacity_data = new String[temp.length+1];
		capacity_data[0] = "전체";
		for(int i=1;i<temp.length+1;i++)
			capacity_data[i] = temp[i-1];
		
		
		if(capacity_search!=null && capacity_search.equals(capacity_data[0]))
		{
			out.println("<option value=\"All\" selected>"+capacity_data[0]+"</option>");
		}
		else
		{
			out.println("<option value=\"All\">"+capacity_data[0]+"</option>");
		}
		
		for(int i =1;i<capacity_data.length;i++)
		{
			if(capacity_search!=null && capacity_search.equals(capacity_data[i]))
			{
				out.println("<option value=\""+capacity_data[i]+"\" selected>"+capacity_data[i]+"</option>");
			}
			else
			{
				out.println("<option value=\""+capacity_data[i]+"\">"+capacity_data[i]+"</option>");
			}
		}
		%>
		</select>
		<br/><br/>
		<input type = "text" readonly="readonly" <% if(capacity_input_search!=null) out.println("value=\""+capacity_input_search+"\" "); else out.println("value=\"\""); %> name="capacity_input" id="capacity_input"/>
		<br/><br/>
		
		변속기 :
		<br/><br/> 
		<select name="transmission_search" id="transmission_search" onchange="transmissionAdd(this);">
		
		<%
		String transmission_search = (String)session.getAttribute("transmission_search");
		temp = connection.selectTransmission();
		String[] transmission_data = new String[temp.length+1];
		transmission_data[0] = "전체";
		for(int i=1;i<temp.length+1;i++)
			transmission_data[i] = temp[i-1];
		
		
		if(transmission_search!=null && transmission_search.equals(transmission_data[0]))
		{
			out.println("<option value=\"All\" selected>"+transmission_data[0]+"</option>");
		}
		else
		{
			out.println("<option value=\"All\">"+transmission_data[0]+"</option>");
		}
		
		for(int i =1;i<transmission_data.length;i++)
		{
			if(transmission_search!=null && transmission_search.equals(transmission_data[i]))
			{
				out.println("<option value=\""+transmission_data[i]+"\" selected>"+transmission_data[i]+"</option>");
			}
			else
			{
				out.println("<option value=\""+transmission_data[i]+"\">"+transmission_data[i]+"</option>");
			}
		}
		%>
		</select>
		<br/><br/>
		<input type = "text" readonly="readonly" <% if(transmission_input_search!=null) out.println("value=\""+transmission_input_search+"\" "); else out.println("value=\"\""); %> name="transmission_input" id="transmission_input"/>
		<br/><br/>
		
		모델 :
		<br/><br/> 
		<select name="model_search" id="model_search" onchange="modelAdd(this);">
		
		<%
		String model_search = (String)session.getAttribute("model_search");
		temp = connection.selectModel();
		String[] model_data = new String[temp.length+1];
		model_data[0] = "전체";
		for(int i=1;i<temp.length+1;i++)
			model_data[i] = temp[i-1];
		
		
		if(model_search!=null && model_search.equals(model_data[0]))
		{
			out.println("<option value=\"All\" selected>"+model_data[0]+"</option>");
		}
		else
		{
			out.println("<option value=\"All\">"+model_data[0]+"</option>");
		}
		
		for(int i =1;i<model_data.length;i++)
		{
			if(model_search!=null && model_search.equals(model_data[i]))
			{
				out.println("<option value=\""+model_data[i]+"\" selected>"+model_data[i]+"</option>");
			}
			else
			{
				out.println("<option value=\""+model_data[i]+"\">"+model_data[i]+"</option>");
			}
		}
		%>
		</select>
		<br/><br/>
		<input type = "text" readonly="readonly" <% if(model_input_search!=null) out.println("value=\""+model_input_search+"\" "); else out.println("value=\"\""); %> name="model_input" id="model_input"/>
		<br/><br/>
		
		세부모델 :
		<br/><br/> 
		<select name="detailedmodel_search" id="detailedmodel_search" onchange="detailedmodelAdd(this)">
		
		<%
		
		if(model_search!=null && !model_search.equals("All"))
		{	
			temp = connection.selectDetailedModel(model_search);
			String[] detailedmodel_data = new String[temp.length+1];
			detailedmodel_data[0] = "전체";
			for(int i=1;i<temp.length+1;i++)
				detailedmodel_data[i] = temp[i-1];
			
			
			
			out.println("<option value=\"All\">"+detailedmodel_data[0]+"</option>");
			
			
			for(int i =1;i<detailedmodel_data.length;i++)
			{
				out.println("<option value=\""+detailedmodel_data[i]+"\">"+detailedmodel_data[i]+"</option>");	
			}	
		}
		else
		{
			out.println("<option value=\"\"></option>");
		}
		
		String list[] = {"category","fuel","color","capacity","transmission","model","detailedmodel","category_input","fuel_input","color_input","capacity_input","transmission_input","model_input","detailedmodel_input"};
		for(int i=0;i<list.length;i++)
		{
			session.removeAttribute(list[i]+"_search");
			session.removeValue(list[i]+"_search");
		}
		%>
		</select>
		<br/><br/>
		<input type = "text" readonly="readonly" <% if(detailedmodel_input_search!=null) out.println("value=\""+detailedmodel_input_search+"\" "); else out.println("value=\"\""); %> name="detailedmodel_input" id="detailedmodel_input"/>
		<br/><br/>
		
		<input type = "button" value="검색" onclick="checkBlank();"/>
		<input type = "button" value="취소" onclick="history.back(-1);"/>
	</form>
	
	</div>
</body>
</html>