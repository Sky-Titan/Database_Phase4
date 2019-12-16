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
<title>차량 매물 등록</title>
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
	<div align="center">
	<h2>차량 매물 등록</h2>
	
	<script type="text/javascript">
	
	function checkBlank()
	{
		var frm = document.forms["information"];
		if(frm.vehiclenumber_register.value=="" || frm.mileage_register.value=="" || frm.price_register.value=="" )
			alert('빈칸이 있습니다');
		else
		{	
				frm.submit();
			
		}
	}
	
	function makingDetailedModel()
	{
		var form = document.createElement("form");
		var frm = document.forms["information"];
	     var model = frm.model_register.value;
	     var vehiclenumber = frm.vehiclenumber_register.value;
	     var mileage = frm.mileage_register.value;
	     var price = frm.price_register.value;
	     var modelyear = frm.modelyear_register.value;
	     var fuel = frm.fuel_register.value;
	     var color = frm.color_register.value;
	     var capacity = frm.capacity_register.value;
	     var open = frm.open_register.value;
	     
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  //Post 방식
        form.setAttribute("action", "RegisterMakingDM.jsp"); //요청 보낼 주소

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "vehiclenumber");
        hiddenField.setAttribute("value", vehiclenumber);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "mileage");
        hiddenField.setAttribute("value", mileage);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "model");
        hiddenField.setAttribute("value", model);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "price");
        hiddenField.setAttribute("value", price);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "text");
        hiddenField.setAttribute("name", "modelyear");
        hiddenField.setAttribute("value", modelyear);
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
        hiddenField.setAttribute("name", "open");
        hiddenField.setAttribute("value", open);
        form.appendChild(hiddenField);
        
        document.body.appendChild(form);
        form.submit();
        
        
	}
	</script>
	
	<form action="RegisterVehicleDB.jsp" method="post" name="information">
		
		<%
		String vehiclenumber_register = (String)session.getAttribute("vehiclenumber_register");
		String model_register = (String)session.getAttribute("model_register");
		String fuel_register = (String)session.getAttribute("fuel_register");
		String color_register = (String)session.getAttribute("color_register");
		String capacity_register = (String)session.getAttribute("capacity_register");
		String open_register = (String)session.getAttribute("open_register");
		String price_register = (String)session.getAttribute("price_regsiter");
		String mileage_register = (String)session.getAttribute("mileage_register");
		String modelyear_register = (String)session.getAttribute("modelyear_register");
		String detailedmodel_register[] = (String[])session.getAttribute("detailedmodel_register");
		%>
		
		차량번호 : 
		<br/><br/>
		<input type = "number" name="vehiclenumber_register" <% if(vehiclenumber_register!=null) out.println("value=\""+vehiclenumber_register+"\""); else out.println("value=\"\""); %>/>
		<br/><br/>
		주행거리 : 
		<br/><br/>
		<input type = "number" name="mileage_register" <% if(mileage_register!=null) out.println("value=\""+mileage_register+"\""); else out.println("value=\"\""); %>/>
		<br/><br/>
		모델 :
		<br/><br/>
		<select name="model_register" id="model_register" onchange="makingDetailedModel();">
		
		<%	
		DBConnection connection = new DBConnection();
		String models[] = connection.selectModel();
		for(int i = 0; i<models.length; i++)
		{
			if(model_register!=null && model_register.equals(models[i]))
				out.println("<option value=\""+models[i]+"\" selected>"+models[i]+"</option>");
			else
			out.println("<option value=\""+models[i]+"\">"+models[i]+"</option>");
		}
		%>
		</select>
		<br/><br/>
		세부모델 :
		<br/><br/>
		<select name="detailedmodel_register" id = "detailedmodel_register">
		<%
		
		if(model_register==null)
		{
			String detailedmodels[] = connection.selectDetailedModel(models[0]);
			for(int i=0;i<detailedmodels.length;i++)
			{
				if(i==0)
					out.println("<option value=\""+detailedmodels[i]+"\" selected>"+detailedmodels[i]+"</option>");
				else	
					out.println("<option value=\""+detailedmodels[i]+"\">"+detailedmodels[i]+"</option>");
			}
		}
		else
		{
			String detailedmodels[] = connection.selectDetailedModel(model_register);
			for(int i=0;i<detailedmodels.length;i++)
			{
				if(i==0)
					out.println("<option value=\""+detailedmodels[i]+"\" selected>"+detailedmodels[i]+"</option>");
				else
					out.println("<option value=\""+detailedmodels[i]+"\">"+detailedmodels[i]+"</option>");
			}
		}
		
		%>
		</select>
		<br/><br/>
		가격 :
		<br/><br/>
		<input type = "number" name="price_register" <% if(price_register!=null) out.println("value=\""+price_register+"\""); else out.println("value=\"\"");%>/>
		<br/><br/>
		연식 : 
		<br/><br/>
		<input type = "date" name="modelyear_register" <% if(modelyear_register!=null) out.println("value=\""+modelyear_register+"\""); else out.println("value=\"1950-01-01\"");%> min="1950-01-01" max="2019-12-31"/>
		<br/><br/>
		연료 : 
		<br/><br/>
		<select name="fuel_register" id="fuel_register">
		<%
	
		String fuel[] = connection.selectFuel();
		for(int i=0;i<fuel.length;i++)
		{
			if(fuel_register!=null && fuel_register.equals(fuel[i]))
				out.println("<option value=\""+fuel[i]+"\" selected>"+fuel[i]+"</option>");
			else
				out.println("<option value=\""+fuel[i]+"\">"+fuel[i]+"</option>");
		}
		
		%>
		</select>
		<br/><br/>
		색상 : 
		<br/><br/>
		<select name="color_register" id="color_register">
		<%
	
		String color[] = connection.selectColor();
		for(int i=0;i<color.length;i++)
		{
			if(color_register!=null && color_register.equals(color[i]))
				out.println("<option value=\""+color[i]+"\" selected>"+color[i]+"</option>");
			else
				out.println("<option value=\""+color[i]+"\">"+color[i]+"</option>");
		}
		
		%>
		</select>
		<br/><br/>
		배기량 : 
		<br/><br/>
		<select name="capacity_register" id="capacity_register">
		<%
	
		String capacity[] = connection.selectCapacity();
		for(int i=0;i<capacity.length;i++)
		{
			if(capacity_register!=null && capacity_register.equals(capacity[i]))
				out.println("<option value=\""+capacity[i]+"\" selected>"+capacity[i]+"</option>");
			else
				out.println("<option value=\""+capacity[i]+"\">"+capacity[i]+"</option>");
		}
		
		%>
		</select>
		<br/><br/>
		공개 : 
		<br/><br/>
		<select name="open_register" id="open_register">
		<%
	
		String open[] = {"O","X"};
		for(int i=0;i<open.length;i++)
		{
			if(open_register!=null && open_register.equals(open[i]))
				out.println("<option value=\""+open[i]+"\" selected>"+open[i]+"</option>");
			else
				out.println("<option value=\""+open[i]+"\">"+open[i]+"</option>");
		}
		
		%>
		</select>
		<br/><br/>
		<input type = "button" value="완료" name="complete" onclick="checkBlank();"/>
		<input type = "button" value="취소" name="cancel" onclick="history.back(-1);"/>
	</form>
	</div>
</body>
</html>