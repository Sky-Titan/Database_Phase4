<%@page import="java.util.StringTokenizer"%>
<%@page import="sun.util.locale.StringTokenIterator"%>
<%@page import="java.sql.*"%>
<%@page import="java.*"%>

<%@ page import="DBpackage.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>SignUpDB</title>
</head>
<body>
	<%
	// for docker
			DBConnection connection = new DBConnection();
			NeedMethods methods = new NeedMethods();
			String idString = request.getParameter("id");
			String pwString = request.getParameter("pw");
			String pwConfirm = request.getParameter("pwConfirm");
			String fnameString = request.getParameter("fname");
			String lnameString = request.getParameter("lname");
			String phoneString = request.getParameter("phonenumber");
			String kindString = request.getParameter("kind");
			
			if(!methods.isOnlyNumber(phoneString))//���ڸ� �ִ��� Ȯ��
			{
				%>
				<script>
      			alert( '�޴��� ��ȣ�� ���ڸ� �������ֽʽÿ�' );
      			location.href="SignUp.html";
    			</script>
				<% 
			}
			else{
				//�߰��Է�����
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
							&& !lnameString.equals("") && !phoneString.equals(""))//�ʼ� ���� �Է� ���� 
					{
						
					
							//TODO : DB�� �̹� �����ϴ� ȸ������ ���� Ȯ�� �� ����(account�� insert) ��û
							if(!pwConfirm.equals(pwString))
							{
								%>
								<script>
				      			alert( '��й�ȣ�� ���� �ʽ��ϴ�.' );
				      			location.href="SignUp.html";
				    			</script>
								<% 
							}
							else
							{
								boolean result = connection.isMember(idString);
								if(result==false)//ȸ�� ���� x - ���԰���
								{
									boolean result2 = connection.signUpDB(idString, pwString, fnameString, lnameString, phoneString, kindString, 
											bdate, genderString, jobString, countryString, cityString, detailAddressString);
									if(result2 == true)//ȸ������ �Ϸ�
									{
										//�ƹ��͵� ����
										%>
										<script>
						      			alert( 'ȸ������ ����! �α��� ���ֽʽÿ�' );
						      			location.href="SignIn.html";
						    			</script>
										<% 
									}
									else//ȸ������ ����
									{
										%>
										<script>
						      			alert( 'ȸ������ ���� - ��������' );
						      			location.href="SignUp.html";
						    			</script>
										<% 
									}
										
								}
								else
								{
									%>
									<script>
					      			alert( '�ش� id�� �̹� �����մϴ�.' );
					      			location.href="SignUp.html";
					    			</script>
									<% 
								}	
							}
							
						
						
					}
					else// �ʼ� ���� �Է� ���ϸ� ���
					{
						%>
						<script>
		      			alert( '�ʼ� ������ �Է����ּ���' );
		      			location.href="SignUp.html";
		    			</script>
						<% 
					}
				}
		
				
			
			
			
	%>
	
</body>
</html>