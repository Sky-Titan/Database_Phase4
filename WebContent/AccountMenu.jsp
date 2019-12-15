<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>메뉴</title>
</head>
<body>
<div align="Center">
		<%
		if((boolean)session.getAttribute("isAdmin"))
			out.println("<h2>관리자");
		else
			out.println("<h2>고객");
		
		
		session.removeAttribute("make");
		session.removeValue("make");
		session.removeAttribute("model");
		session.removeValue("model");
		
		%>
		메뉴</h2>
		<%!
    public void helloWorld() {
       System.out.println("wow");
    }
%>


		<input type="button" value="회원 정보 수정" onclick="location.href='AccountModification.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="회원 탈퇴" onclick="location.href='DeleteAccount.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="매물 보기" onclick="location.href='VehicleTable.jsp'"/>
		<br/>
		<br/>
		<input type = "button" value="매물 조건별 검색하기" onclick="location.href='ConditionSearch.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="거래내역 보기" onclick="location.href='OrderTable.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="로그아웃" onclick="location.href='Logout.jsp'"/>
		
		

	</div>
</body>
</html>