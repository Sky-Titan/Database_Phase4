
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
<title>�����Ź� ����</title>
</head>
<body>
	<div align="center">
	
		<%
		//register vehicle�� �����ϱ��� ���ǰ� ����
		if(session.getAttribute("model_reegister")!=null)
		{
			session.removeAttribute("model_register");
			session.removeValue("model_register");
		}
		%>
	
		
		<h2>���� �Ź�</h2>
		
		
		
		������ : 
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
		
		function modifyVehicle() {
			var radio_btn = document.getElementsByName("choiceVehicle");
			 
	        //���� ��ư�� üũ�Ǿ��� Ȯ���ϱ� ���� ����
	        var radio_btn_check = 0;
	        for(var i = 0; i<radio_btn.length; i++){
	            //���� ���� ��ư�� üũ�� �Ǿ��ִٸ� true
	            if(radio_btn[i].checked==true){
	            	
	            	var form = document.createElement("form");
	   		     var make = makes.value;
	   	         form.setAttribute("charset", "UTF-8");

	   	         form.setAttribute("method", "Post");  //Post ���

	   	         form.setAttribute("action", "ModifyVehicle.jsp"); //��û ���� �ּ�



	   	         var hiddenField = document.createElement("input");

	   	         hiddenField.setAttribute("type", "text");

	   	         hiddenField.setAttribute("name", "vehicleNumber");

	   	         hiddenField.setAttribute("value", radio_btn[i].value);

	   	         form.appendChild(hiddenField);



	   	         document.body.appendChild(form);

	   	         form.submit();
	           		return;
	            }
	        }
	        
	        if(radio_btn_check==0){
	            alert("���� ��ư�� �������ּ���");
	            return;
	        }

		}
		
		function making_models(makes)
		{
			 var form = document.createElement("form");
		     var make = makes.value;
	         form.setAttribute("charset", "UTF-8");

	         form.setAttribute("method", "Post");  //Post ���

	         form.setAttribute("action", "ModelMaking.jsp"); //��û ���� �ּ�



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

	         form.setAttribute("method", "Post");  //Post ���

	         form.setAttribute("action", "DetailedModelMaking.jsp"); //��û ���� �ּ�



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

	         form.setAttribute("method", "Post");  //Post ���

	         form.setAttribute("action", "ModelDetailedModelSearch.jsp"); //��û ���� �ּ�



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
		�� : 
		<select name="models" id="models" onchange=" making_detailmodels(this)">
		<%
		
		if(make.equals("no") || make.equals("All"))//���ǰ� ������
		{
			out.println("<option value=\"\" selected></option>");
		}
		else
		{
			
			String[] temp = connection.selectModel(make);
			String[] models = new String[temp.length+1];
			models[0]="��ü";
			for(int i = 1 ; i<models.length;i++)
			{
				models[i] = temp[i-1];
			}
			
			String model = (String)session.getAttribute("model");
			if(model==null)//���ǰ� ������
			{
				out.println("<option value=\"All\" selected>"+models[0]+"</option>");
				
				for(int i=1; i < models.length;i++)
				{		
					out.println("<option value=\""+models[i]+"\">"+models[i]+"</option>");
				}	
			}
			else//���ǰ� ������
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
		if(model==null || model.equals("All"))//���ǰ� ������
		{
			out.println("<option value=\"\" selected></option>");
		}
		else//���ǰ� ���� ��
		{
			String[] temp = connection.selectDetailedModel(model);
			String[] detailed_models = new String[temp.length+1];
			detailed_models[0] = "��ü";
			
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
		
		<input type="button" value="�ڷΰ���" onclick="location.href='AccountMenu.jsp'"/>
		
		<br/>
		<br/>
		<form action="BuyVehicle.jsp" method="POST">
		<div style="width:100%; height:400px; overflow:auto">
		<% 
		boolean isAdmin= (boolean)session.getAttribute("isAdmin");
		
		String header[] ={"���� ��ȣ","����Ÿ�(km)","��","���θ�","����(��)","����","����","����","��ⷮ(cc)","���̺긮��","��������","������","����","����(km)","���ӱ�","����"};
		
		if(!isAdmin)//�� ����϶� �������� �Ⱥ�����
		{
			String[] temp2 = {"���� ��ȣ","����Ÿ�(km)","��","���θ�","����(��)","����","����","����","��ⷮ(cc)","���̺긮��","������","����","����(km)","���ӱ�","����"};
			header = new String[temp2.length];
			for(int i=0;i<temp2.length;i++)
				header[i] = temp2[i];
		}
		
		String[][] data;//table ������
		if(session.getAttribute("VehicleData")==null)
		{
			System.out.println("���̺� ������ null�̴�!!! ");
			String[][] temp = connection.selectVehicles(isAdmin);
			session.setAttribute("VehicleData", temp);
			data=temp;
		}
		else
		{
			System.out.println("���̺� ������ �����̴�!!! ");
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
			out.println("<td><input type=\"radio\" name=\"choiceVehicle\" value=\""+data[i][0]+"\"></td>");
			out.println("</tr>");
		}
		out.println("</table>");
		%>
		</div>
		<%
		out.println("<br/>");
		if(isAdmin)
		{
			out.println("<input type=\"button\" value=\"���� �Ź� ���\" onclick=\"location.href='RegisterVehicle.jsp'\"></input>");
			out.println("<input type=\"button\" value=\"���� ���� ����\" onclick=\"location.href='ModifyVehicle.jsp'\"></input>");
		}
		out.println("<input type=\"submit\" name=\"submit\" value=\"����\" ></input>");
		
		%>
		
		</form>
		<br/>
		<br/>
		
	</div>
</body>
</html>