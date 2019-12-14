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
		<h2>메뉴</h2>
		
		<input type="button" value="회원 정보 수정" onclick="location.href='AccountModification.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="회원 탈퇴" onclick="location.href='AccountDelete.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="매물 보기" onclick="location.href='VehicleTable.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="거래내역 보기" onclick="location.href='OrderTable.jsp'"/>
		<br/>
		<br/>
		<input type="button" value="로그아웃" onclick="location.href='SignIn.html'"/>

	</div>
</body>
</html>