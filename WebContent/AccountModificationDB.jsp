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
			System.out.println("���� "+idString);
			if(!methods.isOnlyNumber(phoneString))//���ڸ� �ִ��� Ȯ��
			{
				%>
				<script>
      			alert( '�޴��� ��ȣ�� ���ڸ� �������ֽʽÿ�' );
      			location.href="AccountModification.jsp";
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
				      			location.href="AccountModification.jsp";
				    			</script>
								<% 
							}
							else
							{
								boolean result = connection.isMember(idString);
								
									boolean result2 = connection.updateAccount(idString, pwString, fnameString, lnameString, phoneString, kindString, bdate, genderString, jobString, countryString, cityString, detailAddressString);
									if(result2 == true)//ȸ������ �Ϸ�
									{
										//�ƹ��͵� ����
										%>
										<script>
						      			alert( 'ȸ������ ���� �Ϸ�!' );
						      			location.href="AccountMenu.jsp";
						    			</script>
										<% 
									}
									else//ȸ������ ����
									{
										%>
										<script>
						      			alert( 'ȸ������ ���� ���� - ��������' );
						      			location.href="AccountModification.jsp";
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
		      			location.href="AccountModification.jsp";
		    			</script>
						<% 
					}
				}
		
				
			
			
			
	%>
</body>
</html>