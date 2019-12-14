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
<title>AccountModificationDB</title>
</head>
<body>
<%
	// for docker
			DBConnection connection = new DBConnection();
			NeedMethods methods = new NeedMethods();
			String idString = session.getAttribute("id")+"";
			String pwString = request.getParameter("pw");
			String pwConfirm = request.getParameter("pwConfirm");
			String fnameString = request.getParameter("fname");
			String lnameString = request.getParameter("lname");
			String phoneString = request.getParameter("phonenumber");
			String kindString = request.getParameter("kind");
			System.out.println("수정 "+idString);
			if(!methods.isOnlyNumber(phoneString))//숫자만 있는지 확인
			{
				%>
				<script>
      			alert( '휴대폰 번호는 숫자만 포함해주십시오' );
      			location.href="AccountModification.jsp";
    			</script>
				<% 
			}
			else{
				//추가입력정보
				String bdate = request.getParameter("bdate"); 
				System.out.println(bdate);
				
					
					if(!bdate.equals(""))
						bdate = "TO_DATE('"+bdate+"', 'yyyy-mm-dd')";
					else
						bdate = "null";
					
					String genderString = request.getParameter("gender");
					if(!genderString.equals(""))
						genderString = "'"+genderString+"'";
					else
						genderString = "null";
					
					String jobString = request.getParameter("job");
					if(!jobString.equals(""))	
						jobString = "'"+jobString+"'";
					else
						jobString = "null";
					
					String countryString = request.getParameter("country");
					if(!countryString.equals(""))
						countryString = "'"+countryString+"'";
					else
						countryString = "null";
					
					String cityString = request.getParameter("city");
					if(!cityString.equals(""))
						cityString = "'"+cityString+"'";
					else
						cityString = "null";
					
					String detailAddressString = request.getParameter("detail_address");
					if(!detailAddressString.equals(""))
						detailAddressString = "'"+detailAddressString+"'";
					else
						detailAddressString = "null";
					
					if(!idString.equals("") && !pwString.equals("") && !pwConfirm.equals("") && !fnameString.equals("") 
							&& !lnameString.equals("") && !phoneString.equals(""))//필수 정보 입력 여부 
					{
						
					
							//TODO : DB에 이미 존재하는 회원인지 먼저 확인 후 가입(account에 insert) 요청
							if(!pwConfirm.equals(pwString))
							{
								%>
								<script>
				      			alert( '비밀번호가 같지 않습니다.' );
				      			location.href="AccountModification.jsp";
				    			</script>
								<% 
							}
							else
							{
								boolean result = connection.isMember(idString);
								
									boolean result2 = connection.updateAccount(idString, pwString, fnameString, lnameString, phoneString, kindString, bdate, genderString, jobString, countryString, cityString, detailAddressString);
									if(result2 == true)//회원가입 완료
									{
										//아무것도 안함
										%>
										<script>
						      			alert( '회원정보 수정 완료!' );
						      			location.href="AccountMenu.jsp";
						    			</script>
										<% 
									}
									else//회원가입 실패
									{
										%>
										<script>
						      			alert( '회원정보 수정 실패 - 서버에러' );
						      			location.href="AccountModification.jsp";
						    			</script>
										<% 
									}
										
								
								
							}
							
						
						
					}
					else// 필수 정보 입력 안하면 경고
					{
						%>
						<script>
		      			alert( '필수 정보를 입력해주세요' );
		      			location.href="AccountModification.jsp";
		    			</script>
						<% 
					}
				}
		
				
			
			
			
	%>
</body>
</html>