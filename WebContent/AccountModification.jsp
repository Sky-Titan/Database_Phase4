<%@page import="java.sql.*"%>
<%@ page import="DBpackage.*" %>
<%@page import="java.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원정보수정</title>
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

<script type="text/javascript">
	
	function checkBlank()
	{
		var frm = document.forms["accountmodify"];
			
			frm.submit();
			
		
	}
	</script>
	<%
	DBConnection connection = new DBConnection();
	
	//회원정보 불러오기
	String accountInfo[];
	String id = session.getAttribute("id")+"";
	accountInfo = connection.selectAccountInfo(id);
	%>
	<div align="Center">
	<h2>회원정보 수정</h2>
	<h3>*은 필수적으로 입력해야합니다.</h3>
	
	<form action="AccountModificationDB.jsp" method="POST" name="accountmodify">
	
		비밀번호 : (*)
		<br/>
		<br/>
		<input type="password" name="pw" size = "15" value="<% out.print(accountInfo[4]); %>"/>
		<br/>
		<br/>
		비밀번호 확인 : (*)
		<br/>
		<br/>
		<input type="password" name="pwConfirm" size = "15" value="<% out.print(accountInfo[4]); %>"/>
		<br/>
		<br/>
		계정종류 : (*)
		<br/>
		<br/>
		<select name="kind">
		 <%
		 if(accountInfo[1].equals("Admin"))
		 {
		 %>
			<option value="Admin" selected>관리자</option>
			<option value="Customer">고객</option>
		<% 
		 }
		 else
		 {
		%>
			<option value="Admin">관리자</option>
			<option value="Customer" selected>고객</option>
		<% 
		 }
		%>
		</select>
		<br/>
		<br/>
		이름 : (*)
		<br/>
		<br/>
		<input type="text" name="fname" size = "15" value="<% out.print(accountInfo[2]); %>"/>
		<br/>
		<br/>
		성 : (*)
		<br/>
		<br/>
		<input type="text" name="lname" size = "15" value="<% out.print(accountInfo[3]); %>"/>
		<br/>
		<br/>
		휴대폰번호 : (*)
		<br/>
		'-'없이 입력
		<br/>
		<br/>
		<input type="text" name="phonenumber" size="20" value="<% out.print(accountInfo[5]); %>"/>
		<br/>
		<br/>
		생년월일 :
		<br/>
		<br/>
		<input type="date" name="bdate" min="1950-01-01" max="2000-12-31" value="<% 
		if(accountInfo[6]!=null)
			out.print(accountInfo[6]);
		else
			out.print("");
		%>"/>
		<br/>
		<br/>
		성별 :
		<br/>
		<br/>
		<select name="gender" >
			<option value="" <% if(accountInfo[7]!=null && accountInfo[7].equals("")) { %>selected<%} %>>선택안함</option>
			<option value="Male" <% if(accountInfo[7]!=null &&accountInfo[7].equals("Male")) { %>selected<%} %>>남</option>
			<option value="Female" <%if(accountInfo[7]!=null &&accountInfo[7].equals("Female")) { %>selected<%} %>>여</option>
		</select>
		<br/>
		<br/>
		직업 :
		<br/>
		<br/>
		<input type="text" name="job" size = "15" value="<% 
		if(accountInfo[8]!=null)
			out.print(accountInfo[8]);
		else
			out.print("");
		%>"/>
		<br/>
		<br/>
		국가 :
		<br/>
		<br/>
		<input type="text" name="country" size = "15" value="<% 
		if(accountInfo[9]!=null)
			out.print(accountInfo[9]);
		else
			out.print("");
		%>"
		/>
		<br/>
		<br/>
		도시 :
		<br/>
		<br/>
		<input type="text" name="city" size = "15" value="<% 
		if(accountInfo[10]!=null)
			out.print(accountInfo[10]);
		else
			out.print("");
		%>"/>
		<br/>
		<br/>
		주소 :
		<br/>
		<br/>
		<input type="text" name="detail_address" size = "15" value="<% 
		if(accountInfo[11]!=null)
			out.print(accountInfo[11]);
		else
			out.print("");
		%>"/>
	
	</form>
	<br/>

		<button onclick="checkBlank();" style="width:80pt"><b>완료</b></button>
		<button onclick="location.href='AccountMenu.jsp';" style="width:80pt"><b>취소</b></button>
	</div>
</body>
</html>