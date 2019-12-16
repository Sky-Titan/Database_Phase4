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
<title>차량 정보 수정</title>
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
	<h2>차량 정보 수정</h2>
	
	<script type="text/javascript">
	
	function checkBlank()
	{
		var frm = document.forms["information"];
		if(frm.mileage_modify.value=="" || frm.price_modify.value=="" )
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
	     var model = frm.model_modify.value;
	     var vehiclenumber = frm.vehiclenumber_modify.value;
	     var mileage = frm.mileage_modify.value;
	     var price = frm.price_modify.value;
	     var modelyear = frm.modelyear_modify.value;
	     var fuel = frm.fuel_modify.value;
	     var color = frm.color_modify.value;
	     var capacity = frm.capacity_modify.value;
	     var open = frm.open_modify.value;
	     
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  //Post 방식
        form.setAttribute("action", "ModifyMakingDM.jsp"); //요청 보낼 주소

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
	
	<form action="ModifyVehicleDB.jsp" method="post" name="information">
		
		<%
		String vehiclenumber = request.getParameter("vehiclenumber_modify"); 
		
		String vehiclenumber_modify = (String)session.getAttribute("vehiclenumber_modify");
		String model_modify = (String)session.getAttribute("model_modify");
		String fuel_modify = (String)session.getAttribute("fuel_modify");
		String color_modify = (String)session.getAttribute("color_modify");
		String capacity_modify = (String)session.getAttribute("capacity_modify");
		String open_modify = (String)session.getAttribute("open_modify");
		String price_modify = (String)session.getAttribute("price_regsiter");
		String mileage_modify = (String)session.getAttribute("mileage_modify");
		String modelyear_modify = (String)session.getAttribute("modelyear_modify");
		String detailedmodel_modify = (String)session.getAttribute("detailedmodel_modify");
		
		DBConnection connection = new DBConnection();
		
		if(vehiclenumber_modify==null)
		{
			String data[] = connection.selectSingleVehicle(vehiclenumber);
			vehiclenumber_modify = data[0];
			mileage_modify = data[1];
			model_modify = data[2];
			detailedmodel_modify = data[3];
			price_modify = data[4];
			
			StringTokenizer strtok = new StringTokenizer(data[5]," ");
			
			modelyear_modify = strtok.nextToken();
			fuel_modify = data[6];
			color_modify = data[7];
			capacity_modify = data[8];
			if(data[10].equals("1"))
				open_modify = "O";
			else
				open_modify = "X";
		}
		%>
		<br/><br/>
		<input type = "hidden" name="vehiclenumber_modify" <% out.println("value=\""+vehiclenumber_modify+"\"");%>/>
		<br/><br/>
		주행거리 : 
		<br/><br/>
		<input type = "number" name="mileage_modify" <% out.println("value=\""+mileage_modify+"\"");  %>/>
		<br/><br/>
		모델 :
		<br/><br/>
		<select name="model_modify" id="model_modify" onchange="makingDetailedModel();">
		
		<%	
		String models[] = connection.selectModel();
		for(int i = 0; i<models.length; i++)
		{
			if(model_modify!=null && model_modify.equals(models[i]))
				out.println("<option value=\""+models[i]+"\" selected>"+models[i]+"</option>");
			else
			out.println("<option value=\""+models[i]+"\">"+models[i]+"</option>");
		}
		%>
		</select>
		<br/><br/>
		세부모델 :
		<br/><br/>
		<select name="detailedmodel_modify" id = "detailedmodel_modify">
		<%
		
		
		String detailedmodels[] = connection.selectDetailedModel(model_modify);
		for(int i=0;i<detailedmodels.length;i++)
		{
			if(detailedmodel_modify.equals(detailedmodels[i]))
				out.println("<option value=\""+detailedmodels[i]+"\" selected>"+detailedmodels[i]+"</option>");
			else	
				out.println("<option value=\""+detailedmodels[i]+"\">"+detailedmodels[i]+"</option>");
		}
		
		
		%>
		</select>
		<br/><br/>
		가격 :
		<br/><br/>
		<input type = "number" name="price_modify" <% if(price_modify!=null) out.println("value=\""+price_modify+"\""); else out.println("value=\"\"");%>/>
		<br/><br/>
		연식 : 
		<br/><br/>
		<input type = "date" name="modelyear_modify" <% if(modelyear_modify!=null) out.println("value=\""+modelyear_modify+"\""); else out.println("value=\"1950-01-01\"");%> min="1950-01-01" max="2019-12-31"/>
		<br/><br/>
		연료 : 
		<br/><br/>
		<select name="fuel_modify" id="fuel_modify">
		<%
	
		String fuel[] = connection.selectFuel();
		for(int i=0;i<fuel.length;i++)
		{
			if(fuel_modify!=null && fuel_modify.equals(fuel[i]))
				out.println("<option value=\""+fuel[i]+"\" selected>"+fuel[i]+"</option>");
			else
				out.println("<option value=\""+fuel[i]+"\">"+fuel[i]+"</option>");
		}
		
		%>
		</select>
		<br/><br/>
		색상 : 
		<br/><br/>
		<select name="color_modify" id="color_modify">
		<%
	
		String color[] = connection.selectColor();
		for(int i=0;i<color.length;i++)
		{
			if(color_modify!=null && color_modify.equals(color[i]))
				out.println("<option value=\""+color[i]+"\" selected>"+color[i]+"</option>");
			else
				out.println("<option value=\""+color[i]+"\">"+color[i]+"</option>");
		}
		
		%>
		</select>
		<br/><br/>
		배기량 : 
		<br/><br/>
		<select name="capacity_modify" id="capacity_modify">
		<%
	
		String capacity[] = connection.selectCapacity();
		for(int i=0;i<capacity.length;i++)
		{
			if(capacity_modify!=null && capacity_modify.equals(capacity[i]))
				out.println("<option value=\""+capacity[i]+"\" selected>"+capacity[i]+"</option>");
			else
				out.println("<option value=\""+capacity[i]+"\">"+capacity[i]+"</option>");
		}
		
		%>
		</select>
		<br/><br/>
		공개 : 
		<br/><br/>
		<select name="open_modify" id="open_modify">
		<%
	
		String open[] = {"O","X"};
		for(int i=0;i<open.length;i++)
		{
			if(open_modify!=null && open_modify.equals(open[i]))
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