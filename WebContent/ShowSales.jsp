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
<title>매출액보기</title>
</head>
<body>
	<div align="center">
	<h2>매출액 보기</h2>
	
	<script type="text/javascript">
	function month_making(years)
	{
		
		if(years.value!="All")
		{
			var months = document.getElementById("months");
		
			var d = ["All","1","2","3","4","5","6","7","8","9","10","11","12"];
			months.options.length = 0;
			for(x in d)
			{
				var opt = document.createElement("option");
				opt.value = d[x];
				if(x==0)
					opt.innerHTML = "전체";
				else
					opt.innerHTML = d[x];
				
		    	months.appendChild(opt);
			}
		}
		else
		{
			var months = document.getElementById("months");
			
			var d = [""];
			months.options.length = 0;
			for(x in d)
			{
				var opt = document.createElement("option");
				opt.value = d[x];
		    	opt.innerHTML = d[x];
		    	months.appendChild(opt);
			}
		}

	}
	
	</script>
	<form action="SalesResult.jsp" method="POST">
	
		<%
		String make_session = session.getAttribute("makes")+"";
		String year_session = session.getAttribute("years")+"";
		String month_session = session.getAttribute("months")+"";
		
	
		
		DBConnection connection = new DBConnection();
		
		String[] make_data=connection.selectMakes();
		%>
		제조사 :
		<br/>
		<br/>
		<select name="makes" id="makes">
		<%
		
		
		if(make_session!=null && make_session.equals("All"))
		{
			out.println("<option value=\"All\" selected>"+make_data[0]+"</option>");
			session.removeAttribute("makes");
		}
		else
			out.println("<option value=\"All\">"+make_data[0]+"</option>");
		for(int i=1; i < make_data.length;i++)
		{
			if(make_session!=null && make_session.equals(make_data[i]))
			{
				out.println("<option value=\""+make_data[i]+"\" selected>"+make_data[i]+"</option>");
				session.removeAttribute("makes");
			}
			else
				out.println("<option value=\""+make_data[i]+"\">"+make_data[i]+"</option>");
		}
		%>
		</select>
		<br/>
		<br/>
		연도별 : 
		<br/>
		<br/>
		<select name="years" id="years" onchange="month_making(this)">
		<%
		out.println("<option value=\"All\" selected>전체</option>");
		for(int i=2010; i <= 2019;i++)
		{
			out.println("<option value=\""+i+"\">"+i+"</option>");
		}
		%>
		</select>
		<script type="text/javascript">
		var val = <%=year_session%>;
		var year_select = document.getElementById("years");
		for( i=0,j=year_select.length; i<j; i++ )
		{
			if( year_select.options[i].value == val )
			{
				year_select.options[i].selected = true;
				<%
				session.removeAttribute("years");
				%>
				break;
			}
		}
		</script>
		
		<br/>
		<br/>
		월별 : 
		<br/>
		<br/>
		<select name="months" id="months">
		<%
		System.out.println("year session : "+year_session+" month session : "+month_session);
		
		if(!month_session.equals("no"))
		{	
			if(month_session.equals("All"))
			{
				out.println("<option value=\"All\" selected>전체</option>");
				session.removeAttribute("months");
			}
			else
				out.println("<option value=\"All\">전체</option>");
			for(int i=1;i<=12;i++)
			{
				if(month_session.equals(i+""))
				{
					out.println("<option value=\""+i+"\" selected>"+i+"</option>");
					session.removeAttribute("months");
				}
				else
					out.println("<option value=\""+i+"\">"+i+"</option>");
			}
		}
		else
		{
			
			System.out.println(month_session);
			out.println("<option value=\"\"></option>");
			
		}
		%>
		
		</select>
		<br/>
		<br/>
		결과 : 
		<br/>
		<br/>
		<%
		String result = session.getAttribute("result")+"";
		if(result!=null)
		{
			out.println("<input type = \"number\" name = \"result\" readonly=\"readonly\" value=\""+result+"\"/>");
			session.removeAttribute("result");
		}
		else
		{
			out.println("<input type = \"number\" name = \"result\" readonly=\"readonly\" value=\"\"/>");
		}
		%>
		
		<br/>
		<br/>
		<input type="submit" name="complete" value="완료" />
		<br/>
		<br/>
		<input type="button" name="back" value="뒤로가기" onclick="history.back(-1);"/>
	</form>
	
	</div>
</body>
</html>