<%@page import="java.util.Calendar"%>
<%@page import="java.util.TimeZone"%>
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
<title>buy vehicle</title>
</head>
<body>
	<%
	DBConnection connection = new DBConnection();
	
	String vehiclenumber = request.getParameter("vehicleNumber");
	String vehicleinfo[] = connection.selectSingleVehicle(vehiclenumber);
	
	StringTokenizer strtok = new StringTokenizer(vehicleinfo[5]," ");
	
	String modelyear = "TO_DATE('"+strtok.nextToken()+"', 'yyyy-mm-dd')";
	
	TimeZone timeZone = TimeZone.getTimeZone("Asia/Seoul");
	Calendar cal = Calendar.getInstance(timeZone);
	
	String year = cal.get(Calendar.YEAR)+"";
	String month = String.valueOf(cal.get(Calendar.MONTH)+1);
	String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
	System.out.println(year+" "+month+" "+day);
	String orderdate ="TO_DATE('"+year+"-"+month+"-"+day+"', 'yyyy-mm-dd')";
	
	String id = (String)session.getAttribute("id");
	System.out.println("구매자 아이디 : "+id);
	
	boolean result = connection.buyVehicles(vehiclenumber, orderdate, id, vehicleinfo[2], vehicleinfo[3], vehicleinfo[4], modelyear, vehicleinfo[6], vehicleinfo[7], vehicleinfo[9]);
	if(result)
	{
		session.removeAttribute("VehicleData");
		session.removeValue("VehicleData");
		%>
		<script type="text/javascript">
		alert('구매완료');
		location.href="VehicleTable.jsp";
		</script>
		<% 
	
	}
	else
	{
		%>
		<script type="text/javascript">
		alert('서버에러');
		location.href="VehicleTable.jsp";
		</script>
		<% 
	}
	%>
</body>
</html>