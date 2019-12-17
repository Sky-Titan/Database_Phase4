package DBpackage;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.StringTokenizer;
import java.util.TimeZone;

public class DBConnection {
	public static final String URL = "jdbc:oracle:thin:@155.230.36.61:1521:orcl";
	public static final String USER_KNU ="s2014105038";
	public static final String USER_PASSWD ="qkrwns2081";
	
	private static Connection conn = null; // Connection object
	private static Statement stmt = null;	// Statement object
	
	public DBConnection()
	{
	
	}
	//������ȣ��
	public static ArrayList<String> selectVehicleNumbers()
	{
		ArrayList<String> result = new ArrayList<>();
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT SERIALNUMBER FROM VEHICLE";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				result.add(rs.getString(1));
			}
			
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	//�ֹ��̷� �ִ� ȸ������ Ȯ��
	public static boolean hasOrdered(String id)
	{
		boolean result=false;
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT * FROM ORDER_LIST WHERE BUYERID='"+id+"'";
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next())
			{
					result = true;
			}
			else
			{
				result=false;
			}
			
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	//�������� ���ΰ�����
	public static String[] selectSingleVehicleAll(String vehiclenumber)
	{
		String[] results=new String[14];
	
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT v.serialnumber, v.mileage, v.modelname, v.detailedmodelname, v.price, v.model_year, v.fuelname, v.colorname, v.capacity, v.ishybrid, m.makename, dm.categoryname, dm.fuelefficiency, dm.transmissionname FROM VEHICLE V, DETAILED_MODEL DM, MODEL M WHERE V.SERIALNUMBER='"+vehiclenumber+"' AND V.MODELNAME = M.MODELNAME AND V.DETAILEDMODELNAME = DM.DETAILEDMODELNAME AND V.MODELNAME = DM.MODELNAME AND V.ISOPEN ='1' ORDER BY TO_NUMBER(v.serialnumber) ASC";//����ó���Ⱦֵ鸸 �ҷ���;
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				for(int i=0;i<results.length;i++)
				{
					results[i] = rs.getString(i+1);
					if(i==5)
					{
						StringTokenizer strtok = new StringTokenizer(results[i]);
						results[i] = strtok.nextToken();
					}
					if(i==9)
					{
						if(results[i].equals("1"))
							results[i]="O";
						else
							results[i]="X";	
					}
					
				}
			}
			
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return results;
		
	}
	
	public static String[] selectSingleVehicle(String vehiclenumber)//�ش� id ���� ���� �� ��й�ȣ ������
	{
		String[] results=new String[11];
	
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT * FROM VEHICLE WHERE serialNUMBER = '"+vehiclenumber+"'";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				for(int i=0;i<results.length;i++)
				{
					results[i] = rs.getString(i+1);
				}
			}
			
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return results;
		
	}
	
	public static boolean isVehicle(String vehiclenumber)
	{
		boolean result=false;
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT * FROM vehicle WHERE VEHICLENUMBER='"+vehiclenumber+"'";
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next())
			{
					result = true;
			}
			else
			{
				result=false;
			}
			
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	public static boolean isMyPhoneNumber(String id,String phonenumber)
	{
		boolean result=false;
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT PHONENUMBER FROM ACCOUNT WHERE id ='"+id+"'";
			ResultSet rs = stmt.executeQuery(sql);
			System.out.println("wow");
			if(rs.next())
			{
				if(rs.getString(1).equals(phonenumber))
					result = true;
				else
					result = false;
			}
			
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}

	public static boolean isPhoneNumber(String phonenumber)
	{
		boolean result=false;
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT * FROM ACCOUNT WHERE phonenumber = '"+phonenumber+"'";
			ResultSet rs = stmt.executeQuery(sql);
			System.out.println("wow");
			if(!rs.next())//�ش� ȸ�� �������� ����
			{
				result = false;//�������
			}
			else {
				result = true;//������ 
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	// 2-C ȸ���� �α��� ���� Ư�� �������� ���� �˻� ����
    // input : category color fuelname modelname detailedmodelname trasmissionname
    // output : all option of vehicle
	public static String[][] voptionBy(boolean isAdmin,ArrayList<String> category, ArrayList<String> color, ArrayList<String> capacity, ArrayList<String> fuelname, ArrayList<String> modelname, ArrayList<String>detailedmodelname, ArrayList<String> transmissionname)
	{
		connect();
		
		String[][] result=null;
		String middle="";
		
		ArrayList[] list = new ArrayList[7];
		list[0] = category;
		list[1] = color;
		list[2] = capacity;
		list[3] = fuelname;
		list[4] = modelname;
		list[5] = detailedmodelname;
		list[6] = transmissionname;
		try
		{
			String sql="";
			// print makename X
			int count=0;
			middle+=" ( ";
			for(int i=0;i<7;i++)
			{
				if(list[i].size()==0)
					continue;
				else
					count++;
				if(count>1)
					middle +=" AND ";

				middle+=" ( ";
				String valuename="";
				if(i==0)
					valuename = " Dm.CATEGORYNAME ";
				else if(i==1)
					valuename = " V.COLORNAME ";
				else if(i==2)
					valuename = " V.CAPACITY ";
				else if(i==3)
					valuename = " V.FUELNAME ";
				else if(i==4)
					valuename = " V.MODELNAME ";
				else if(i==5)
					valuename = " V.DETAILEDMODELNAME ";
				else if(i==6)
					valuename = " Dm.TRANSMISSIONNAME ";
				for(int j=0;j<list[i].size();j++)
				{
					if(j!=0)
						middle += " OR ";
					if(i!=2)
						middle += valuename+"='"+list[i].get(j)+"'";
					else
						middle += valuename+"="+list[i].get(j);
				}
				middle+=" ) ";
			}
			if(!isAdmin)
				middle+=" ) AND ";
			else
				middle+=" ) ";
			
			if(!isAdmin)//���϶�
				sql = "SELECT v.serialnumber, v.mileage, v.modelname, v.detailedmodelname, v.price, v.model_year, v.fuelname, v.colorname, v.capacity, v.ishybrid, m.makename, dm.categoryname, dm.fuelefficiency, dm.transmissionname FROM VEHICLE V, DETAILED_MODEL DM, MODEL M WHERE V.MODELNAME = M.MODELNAME AND V.DETAILEDMODELNAME = DM.DETAILEDMODELNAME AND V.MODELNAME = DM.MODELNAME AND "+middle+"  V.ISOPEN ='1' ORDER BY TO_NUMBER(v.serialnumber) ASC";//����ó���Ⱦֵ鸸 �ҷ���
			else//�������϶� ��ü �ٺҷ���
				sql = "SELECT v.serialnumber, v.mileage, v.modelname, v.detailedmodelname, v.price, v.model_year, v.fuelname, v.colorname, v.capacity, v.ishybrid, v.isopen, m.makename, dm.categoryname, dm.fuelefficiency, dm.transmissionname FROM VEHICLE V, DETAILED_MODEL DM, MODEL M WHERE V.MODELNAME = M.MODELNAME AND V.DETAILEDMODELNAME = DM.DETAILEDMODELNAME AND V.MODELNAME = DM.MODELNAME AND "+middle+ " ORDER BY TO_NUMBER(v.serialnumber) ASC";
			
		/*	if(!isAdmin)
					sql = "SELECT V.serialnumber, V.mileage, V.modelname, V.detailedmodelname, " + 
			              "V.price, V.model_year, V.fuelname, V.colorname, V.capacity, V.ishybrid, " +
				          "m.makename, d.categoryname, d.fuelefficiency, d.transmissionname " + 
				          "from vehicle V, detailed_model D, model M " + 
				          "where V.modelname = D.modelname AND " + 
				          "V.detailedmodelname = D.detailedmodelname AND " + 
				          "D.modelname = M.modelname AND " + middle +
				          " V.isopen = '1' ORDER BY TO_NUMBER(v.serialnumber) ASC";
			else
					sql = "SELECT V.serialnumber, V.mileage, V.modelname, V.detailedmodelname, " + 
				          "V.price, V.model_year, V.fuelname, V.colorname, V.capacity, V.ishybrid, " +
				          "V.isopen, m.makename, d.categoryname, d.fuelefficiency, d.transmissionname " + 
				          "from vehicle V, detailed_model D, model M " + 
				          "where V.modelname = D.modelname AND " + 
				          "V.detailedmodelname = D.detailedmodelname AND " + 
				          "D.modelname = M.modelname AND " + middle +
				          " ORDER BY TO_NUMBER(v.serialnumber) ASC"; */
			
			System.out.println("sql�� : "+sql);
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			int column = rsmd.getColumnCount();
			
		//	if(!isAdmin)//����嶧
		//		column-=1;
			
			result = new String[rs.getRow()][column];
			rs.beforeFirst();
			while(rs.next())
			{
			
				for(int j=0;j<column;j++)
				{
					//System.out.println(rs.getString(j+1));
					if(j==5)
					{
						StringTokenizer strtok = new StringTokenizer(rs.getString(j+1)," ");
						result[i][j] = strtok.nextToken();
					}
					else if(j==9)
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}	
					else
					{
						result[i][j] = rs.getString(j+1);
					}
					
					if(j==10 && isAdmin==true)//�������δ� �������϶���
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}
					
					
				}
				i++;
			
			
			}
            /*
			if(res > 0){ result=true; }
			else	result=false;
            */
			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	// 3-D (search total_sales by year, month, makename)
    // input : year, month, makename
    // output : one total_sales
	public static long selectTotalsalesBy(String year, String month, String makename)
	{
		connect();
		
		long totalSales=0;

		try
		{
			TimeZone timeZone = TimeZone.getTimeZone("Asia/Seoul");
			Calendar cal = Calendar.getInstance(timeZone);
			cal.set(Integer.parseInt(year), Integer.parseInt(month)-1, 1);
			int end_day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            // select
			String sql = "select sum(O.price) as total_sales " +
                "from order_list O, detailed_model D, model M " +
                "where O.modelname = D.modelname AND " +
                "O.detailedmodelname = D.detailedmodelname AND " +
                "D.modelname = M.modelname AND " +
                "M.makename = '" + makename + "' AND " +
                "orderdate >= to_date('" + year + month + "01', 'yyyy-mm-dd') AND " +
                "orderdate <= to_date('" + year + month + end_day+"', 'yyyy-mm-dd') " +
                "group by M.makename";
			ResultSet rs = stmt.executeQuery(sql);
			
            // return value
			if(rs.next())
            {
				totalSales = rs.getLong(1);
            }

            /*
			if(res > 0){ 
				result=true;
				System.out.println("Tuple was successfully updated.");
			}else
				result=false;
            */

			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return totalSales;
	}

    // input : makename
    // output : one total_sales
	public static long selectTotalsales()
	{
		connect();
		
		long totalSales=0;

		try
		{
            // select
			System.out.println("make�θ�!!");
			String sql = "select sum(O.price) as total_sales " +
                "from order_list O";
			ResultSet rs = stmt.executeQuery(sql);
			
            // return value

			if(rs.next())
            totalSales = rs.getLong(1);

            /*
			if(res > 0){ 
				result=true;
				System.out.println("Tuple was successfully updated.");
			}else
				result=false;
            */

			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return totalSales;
	}
	
	public static long selectTotalsalesBy(String makename)
	{
		connect();
		
		long totalSales=0;

		try
		{
            // select
			System.out.println("make�θ�!!");
			String sql = "select sum(O.price) as total_sales " +
                "from order_list O, detailed_model D, model M " +
                "where O.modelname = D.modelname AND " +
                "O.detailedmodelname = D.detailedmodelname AND " +
                "D.modelname = M.modelname AND " +
                "M.makename = '" + makename + "' " +
                "group by M.makename";
			ResultSet rs = stmt.executeQuery(sql);
			
            // return value

			if(rs.next())
            totalSales = rs.getLong(1);

            /*
			if(res > 0){ 
				result=true;
				System.out.println("Tuple was successfully updated.");
			}else
				result=false;
            */

			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return totalSales;
	}

    // input : year
    // output : one total_sales
	public static long selectTotalsalesByYear(String year)
	{
		connect();
		
		long totalSales=0;

		try
		{
            // select
			System.out.print("�⵵�� ��� �̱�"+year);
			String sql = "select sum(O.price) as total_sales " + 
					"                from order_list O, detailed_model D, model M " + 
					"                where O.modelname = D.modelname AND " + 
					"                O.detailedmodelname = D.detailedmodelname AND " + 
					"                D.modelname = M.modelname AND " + 
					"                orderdate >= to_date('"+year+"0101', 'yyyy-mm-dd') AND " + 
					"                orderdate <= to_date('"+year+"1231', 'yyyy-mm-dd')";
			ResultSet rs = stmt.executeQuery(sql);
			
            // return value
			if(rs.next())
            totalSales = rs.getLong(1);
			System.out.print(" ��� :"+totalSales);
            /*
			if(res > 0){ 
				result=true;
				System.out.println("Tuple was successfully updated.");
			}else
				result=false;
            */

			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return totalSales;
	}

    // input : year, month
    // output : one total_sales
	public static long selectTotalsalesByYearMonth(String year, String month)
	{
		connect();
		
		long totalSales=0;

		try
		{
			TimeZone timeZone = TimeZone.getTimeZone("Asia/Seoul");
			Calendar cal = Calendar.getInstance(timeZone);
			cal.set(Integer.parseInt(year), Integer.parseInt(month)-1, 1);
			int end_day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
            // select
			String sql = "select sum(O.price) as total_sales " +
                "from order_list O, detailed_model D, model M " +
                "where O.modelname = D.modelname AND " +
                "O.detailedmodelname = D.detailedmodelname AND " +
                "D.modelname = M.modelname AND " +
                "orderdate >= to_date('" + year + month + "01', 'yyyy-mm-dd') AND " +
                "orderdate <= to_date('" + year + month + end_day+"', 'yyyy-mm-dd')";
			ResultSet rs = stmt.executeQuery(sql);
			
            // return value
			if(rs.next())
            totalSales = rs.getLong(1);

            /*
			if(res > 0){ 
				result=true;
				System.out.println("Tuple was successfully updated.");
			}else
				result=false;
            */

			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return totalSales;
	}

    // input : year, makename
    // output : one total_sales
	public static long selectTotalsalesBy(String year, String makename)
	{
		connect();
		
		long totalSales=0;

		try
		{
            // select
			String sql = "select sum(O.price) as total_sales " +
                "from order_list O, detailed_model D, model M " +
                "where O.modelname = D.modelname AND " +
                "O.detailedmodelname = D.detailedmodelname AND " +
                "D.modelname = M.modelname AND " +
                "orderdate >= to_date('" + year + "0101', 'yyyy-mm-dd') AND " +
                "orderdate <= to_date('" + year +"1231', 'yyyy-mm-dd') AND " +
                "M.makename = '" + makename + "' " +
                "group by M.makename";
			ResultSet rs = stmt.executeQuery(sql);
			
            // return value
			if(rs.next())
            totalSales = rs.getLong(1);

            /*
			if(res > 0){ 
				result=true;
				System.out.println("Tuple was successfully updated.");
			}else
				result=false;
            */

			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return totalSales;
	}
	
	// 2-E (vehicle->order_list)
	public static boolean buyVehicles(String serialnumber, String orderdate, String buyerId, String model, String detailed_model, String price, String model_year, String fuel, String color, String ishybrid)
	{
		connect();
		
		boolean result = false;

		try
		{
            // delete from vehicle
			String sql = "DELETE FROM VEHICLE WHERE SerialNumber = '"+serialnumber+"'";
			int res = stmt.executeUpdate(sql);
			
			sql = "select MAX(TO_NUMBER(ORDERNUMBER)) FROM ORDER_LIST";
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
            // find OrderNumber
			
            int ordernumber = rs.getInt(1)+1;
            System.out.println("ordernumber"+ordernumber);
            // insert into order_list
			sql = "INSERT INTO order_list VALUES('"+ordernumber+"', "+orderdate+", '"+buyerId+"', '"+model+"', '"+detailed_model+"', "+price+", "+model_year+", '"+fuel+"', '"+color+"', '"+ishybrid+"')";
			System.out.println(sql);
			res = stmt.executeUpdate(sql);

			if(res > 0){ 
				result=true;
				System.out.println("Tuple was successfully updated.");
			}else
				result=false;

			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	// 2-B (classify makename)
	public static String[][] selectVehicles(String makename, boolean isAdmin)
	{
		String[][] result = null;
			
		connect();
			
		try
		{
			String sql;
	        // print makename X
			if(!isAdmin)
				sql = "SELECT V.serialnumber, V.mileage, V.modelname, V.detailedmodelname, " + 
	                  "V.price, V.model_year, V.fuelname, V.colorname, V.capacity, V.ishybrid, " +
	                  "m.makename, d.categoryname, d.fuelefficiency, d.transmissionname " + 
	                  "from vehicle V, detailed_model D, model M " + 
	                  "where V.modelname = D.modelname AND " + 
	                  "V.detailedmodelname = D.detailedmodelname AND " + 
	                  "D.modelname = M.modelname AND " + 
	                  "M.makename = '" + makename + "' AND " +
	                  "V.isopen = '1' ORDER BY TO_NUMBER(v.serialnumber) ASC";
			else
				sql = "SELECT V.serialnumber, V.mileage, V.modelname, V.detailedmodelname, " + 
	                  "V.price, V.model_year, V.fuelname, V.colorname, V.capacity, V.ishybrid, " +
	                  "V.isopen, m.makename, d.categoryname, d.fuelefficiency, d.transmissionname " + 
	                  "from vehicle V, detailed_model D, model M " + 
	                  "where V.modelname = D.modelname AND " + 
	                  "V.detailedmodelname = D.detailedmodelname AND " + 
	                  "D.modelname = M.modelname AND " + 
	                  "M.makename = '" + makename+"' ORDER BY TO_NUMBER(v.serialnumber) ASC"; 
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
				
			rs.last();
			int column = rsmd.getColumnCount();
				
		//	if(!isAdmin)
		//		column-=1;
				
			result = new String[rs.getRow()][column];
			rs.beforeFirst();
			while(rs.next())
			{
			
				for(int j=0;j<column;j++)
				{
					//System.out.println(rs.getString(j+1));
					if(j==5)
					{
						StringTokenizer strtok = new StringTokenizer(rs.getString(j+1)," ");
						result[i][j] = strtok.nextToken();
					}
					else if(j==9)
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}	
					else
					{
						result[i][j] = rs.getString(j+1);
					}
						
					if(j==10 && isAdmin==true)
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}
				}
				i++;
	               //System.out.println(result[i][j]);
			}
					
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
			
		disconnect();
		
		return result;
	}
	// 2-F (classify modelname&detailedmodelname)
	public static String[][] selectVehiclesByModelname(String modelname, boolean isAdmin)
	{
		String[][] result = null;
		
		connect();
		
		try
		{
			String sql;
	           // print makename X
			if(!isAdmin)
				sql = "SELECT DISTINCT V.serialnumber, V.mileage, V.modelname, V.detailedmodelname, " + 
	                  "V.price, V.model_year, V.fuelname, V.colorname, V.capacity, V.ishybrid, " +
	                  "m.makename, d.categoryname, d.fuelefficiency, d.transmissionname " + 
	                  "from vehicle V, detailed_model D, model M  " + 
	                  "where V.modelname = '" + modelname + "' AND " +
	                  " D.detailedmodelname = V.detailedmodelname AND D.modelname = V.modelname AND M.MODELNAME=V.MODELNAME AND " +
	                  "V.isopen = '1' ORDER BY TO_NUMBER(v.serialnumber) ASC";
			else
				sql = "SELECT DISTINCT V.serialnumber, V.mileage, V.modelname, V.detailedmodelname, " + 
	                   "V.price, V.model_year, V.fuelname, V.colorname, V.capacity, V.ishybrid, " +
	                   "V.isopen , m.makename, d.categoryname, d.fuelefficiency, d.transmissionname " + 
	                   "from vehicle V , detailed_model D, model M  " + 
	                   "where V.modelname = '" + modelname + "' AND " +
	                   "D.detailedmodelname = V.detailedmodelname AND D.modelname = V.modelname AND M.MODELNAME=V.MODELNAME ORDER BY TO_NUMBER(v.serialnumber) ASC"; 
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			int column = rsmd.getColumnCount();
			
		//	if(!isAdmin)
		//		column-=1;
					
			result = new String[rs.getRow()][column];
			rs.beforeFirst();
			while(rs.next())
			{
			
				for(int j=0;j<column;j++)
				{
					//System.out.println(rs.getString(j+1));
					if(j==5)
					{
						StringTokenizer strtok = new StringTokenizer(rs.getString(j+1)," ");
						result[i][j] = strtok.nextToken();
					}
					else if(j==9)
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else								
							result[i][j] = "X";
					}	
					else
					{
						result[i][j] = rs.getString(j+1);
					}
					
					if(j==10 && isAdmin==true)
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}
				}
				i++;
		              //System.out.println(result[i][j]);
			}
					
			rs.close();
				
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return result;
	}
	
	// 2-F (classify modelname&detailedmodelname)
	public static String[][] selectVehiclesByModelname(String modelname, String detailedmodelname, boolean isAdmin)
	{
		String[][] result = null;
		
		connect();
		
		try
		{
			String sql;
	           // print makename X
			if(!isAdmin)
				sql = "SELECT V.serialnumber, V.mileage, V.modelname, V.detailedmodelname, " + 
	                  "V.price, V.model_year, V.fuelname, V.colorname, V.capacity, V.ishybrid, " +
	                  "m.makename, d.categoryname, d.fuelefficiency, d.transmissionname " + 
	                  "from vehicle V, detailed_model D, model M  " + 
	                  "where V.modelname = '" + modelname + "' AND " +
	                  "V.detailedmodelname = '" + detailedmodelname + "' AND D.detailedmodelname = V.detailedmodelname AND D.MODELNAME=V.MODELNAME AND M.modelname = V.modelname AND " +
	                  "V.isopen = '1' ORDER BY TO_NUMBER(v.serialnumber) ASC";
			else
				sql = "SELECT V.serialnumber, V.mileage, V.modelname, V.detailedmodelname, " + 
	                   "V.price, V.model_year, V.fuelname, V.colorname, V.capacity, V.ishybrid, " +
	                   "V.isopen , m.makename, d.categoryname, d.fuelefficiency, d.transmissionname " + 
	                   "from vehicle V , detailed_model D, model M  " + 
	                   "where V.modelname = '" + modelname + "' AND " +
	                   "V.detailedmodelname = '" + detailedmodelname+ "' AND D.detailedmodelname = V.detailedmodelname AND D.MODELNAME=V.MODELNAME AND M.modelname = V.modelname ORDER BY TO_NUMBER(v.serialnumber) ASC"; 
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			int column = rsmd.getColumnCount();
			
		//	if(!isAdmin)
		//		column-=1;
				
			result = new String[rs.getRow()][column];
			rs.beforeFirst();
			while(rs.next())
			{
			
				for(int j=0;j<column;j++)
				{
					//System.out.println(rs.getString(j+1));
					if(j==5)
					{
						StringTokenizer strtok = new StringTokenizer(rs.getString(j+1)," ");
						result[i][j] = strtok.nextToken();
					}
					else if(j==9)
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else								
							result[i][j] = "X";
					}	
					else
					{
						result[i][j] = rs.getString(j+1);
					}
					
					if(j==10 && isAdmin==true)
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}
				}
				i++;
	               //System.out.println(result[i][j]);
			}
				
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return result;
	}
	public static String[] selectCategories()
	{
		String[] result=null;
		
		connect();
		
		try
		{
			String sql;
			
			sql = "SELECT Categoryname FROM CATEGORY";
			
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()+1];
			result[i++] = "��ü";
			rs.beforeFirst();
			while(rs.next())
			{
				result[i] = rs.getString(1);
				i++;
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	public static String[] selectMakes()
	{
		String[] result=null;
		
		connect();
		
		try
		{
			String sql;
			
			sql = "SELECT MAKENAME FROM MAKE";
			
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()+1];
			result[i++] = "��ü";
			rs.beforeFirst();
			while(rs.next())
			{
				result[i] = rs.getString(1);
				i++;
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	//���� ��������
	public static boolean updateVehicles(String serialnumber, String mileage, String model, String detailed_model, String price, String model_year, String fuel, String color, String capacity
			,String ishybrid, String isopen)
	{
		connect();
		
		boolean result = false;
		//������ Ȯ��
		try
		{
			
			String sql = "UPDATE VEHICLE SET MILEAGE = "+mileage+", MODELNAME='"+model+"', DETAILEDMODELNAME='"+detailed_model+"', PRICE="+price+", MODEL_YEAR="+model_year+", FUELNAME='"+fuel+"', COLORNAME='"+color+"', CAPACITY="+capacity+", ISHYBRID='"+ishybrid+"', ISOPEN='"+isopen+"'"
					+ " WHERE SERIALNUMBER = '"+serialnumber+"'";
			int res = stmt.executeUpdate(sql);
			
			if(res > 0) 
			{
				result=true;
				System.out.println("Tuple was successfully updated.");
			}
			else
			{
				result=false;
			}
			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	//���� �Ź����
	public static boolean insertVehicles(String serialnumber, String mileage, String model, String detailed_model, String price, String model_year, String fuel, String color, String capacity
			,String ishybrid, String isopen)
	{
		connect();
		
		boolean result = false;
		//������ Ȯ��
		try
		{
			
			String sql = "INSERT INTO VEHICLE VALUES('"+serialnumber+"', "+mileage+", '"+model+"', '"+detailed_model+"', "+price+", "+model_year+", '"+fuel+"', '"+color+"', "+capacity+", '"+ishybrid+"', '"+isopen+"')";
			int res = stmt.executeUpdate(sql);
			
			if(res > 0) 
			{
				result=true;
				System.out.println("Tuple was successfully inserted.");
			}
			else
			{
				result=false;
			}
			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	//��ⷮ ��ü����Ʈ�ҷ�����
	public static String[] selectCapacity()
	{
		String[] result=null;
		connect();
		
		try
		{
			String sql;
			
			sql = "SELECT CAPACITY FROM ENGINE_DISPLACEMENT";
			
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()];
			rs.beforeFirst();
			while(rs.next())
			{
				result[i] = rs.getString(1);
				i++;
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	public static String[] selectTransmission()
	{
		String[] result=null;
		connect();
		
		try
		{
			String sql;
			
			sql = "SELECT TRANSMISSIONNAME FROM TRANSMISSION";
			
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()];
			rs.beforeFirst();
			while(rs.next())
			{
				result[i] = rs.getString(1);
				i++;
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	//���� ��ü����Ʈ�ҷ�����
	public static String[] selectColor()
	{
		String[] result=null;
		connect();
		
		try
		{
			String sql;
			
			sql = "SELECT COLORNAME FROM COLOR";
			
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()];
			rs.beforeFirst();
			while(rs.next())
			{
				result[i] = rs.getString(1);
				i++;
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	//���� ��ü����Ʈ�ҷ�����
	public static String[] selectFuel()
	{
		String[] result=null;
		connect();
		
		try
		{
			String sql;
			
			sql = "SELECT FUELNAME FROM FUEL";
			
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()];
			rs.beforeFirst();
			while(rs.next())
			{
				result[i] = rs.getString(1);
				i++;
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	//���θ� ��ü����Ʈ�ҷ�����
	public static String[] selectDetailedModel(String modelname)
	{
		String[] result=null;
		connect();
		
		try
		{
			String sql;
			
			sql = "SELECT DETAILEDMODELNAME FROM DETAILED_MODEL WHERE MODELNAME = '"+modelname+"'";
			
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()];
			rs.beforeFirst();
			while(rs.next())
			{
				result[i] = rs.getString(1);
				i++;
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();	
		return result;
	}
	
	//�� ��ü����Ʈ�ҷ�����
	public static String[] selectModel()
	{
		String[] result=null;
		connect();
		
		try
		{
			String sql;
			
			sql = "SELECT MODELNAME FROM MODEL";
			
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()];
			rs.beforeFirst();
			while(rs.next())
			{
				result[i] = rs.getString(1);
				i++;
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	//�� ��ü����Ʈ�ҷ�����
		public static String[] selectModel(String make)
		{
			String[] result=null;
			connect();
			
			try
			{
				String sql;
				
				sql = "SELECT MODELNAME FROM MODEL WHERE MAKENAME = '"+make+"'";
				
				
				ResultSet rs = stmt.executeQuery(sql);
				int i=0;
				ResultSetMetaData rsmd = rs.getMetaData();
				
				rs.last();
				
				result = new String[rs.getRow()];
				rs.beforeFirst();
				while(rs.next())
				{
					result[i] = rs.getString(1);
					i++;
				}
				rs.close();
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			disconnect();
			return result;
		}
		//�ŷ������ҷ�����
		public static String[][] selectOrderlist()
		{
			String[][] result = null;
			
			connect();
			
			try
			{
				String sql;
			
					sql = "SELECT * FROM ORDER_LIST";
		
				
				ResultSet rs = stmt.executeQuery(sql);
				int i=0;
				ResultSetMetaData rsmd = rs.getMetaData();
				
				rs.last();
				
				result = new String[rs.getRow()][rsmd.getColumnCount()];
				rs.beforeFirst();
				while(rs.next())
				{
					for(int j=0;j<rsmd.getColumnCount();j++)
					{
						if(j==6 || j==1)
						{
							//System.out.println(rs.getString(j+1));
							StringTokenizer strtok = new StringTokenizer(rs.getString(j+1)," ");
							result[i][j] = strtok.nextToken();
						}
						else if(j==9)
						{
							//System.out.println(rs.getString(j+1));
							if(rs.getString(j+1).equals("1"))
								result[i][j] = "O";
							else
								result[i][j] = "X";
						}
						else
						{
							//System.out.println(rs.getString(j+1));
							result[i][j] = rs.getString(j+1);
						}
					}
					i++;
				}
				rs.close();
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			disconnect();
			
			return result;
		}
	//�ŷ������ҷ�����
	public static String[][] selectOrderlist(String id)
	{
		String[][] result = null;
		
		connect();
		
		try
		{
			String sql;
		
				sql = "SELECT * FROM ORDER_LIST WHERE BUYERID ='"+id+"'";
			
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			
			result = new String[rs.getRow()][rsmd.getColumnCount()];
			rs.beforeFirst();
			while(rs.next())
			{
				for(int j=0;j<rsmd.getColumnCount();j++)
				{
					if(j==6 || j==1)
					{
						//System.out.println(rs.getString(j+1));
						StringTokenizer strtok = new StringTokenizer(rs.getString(j+1)," ");
						result[i][j] = strtok.nextToken();
					}
					else if(j==9)
					{
						//System.out.println(rs.getString(j+1));
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}
					else
					{
						//System.out.println(rs.getString(j+1));
						result[i][j] = rs.getString(j+1);
					}
				}
				i++;
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return result;
	}
	
	//�Ź��ҷ���
	public static String[][] selectVehicles(boolean isAdmin)
	{
		String[][] result = null;
		
		connect();
		
		try
		{
			String sql;
			if(!isAdmin)//���϶�
				sql = "SELECT v.serialnumber, v.mileage, v.modelname, v.detailedmodelname, v.price, v.model_year, v.fuelname, v.colorname, v.capacity, v.ishybrid, m.makename, dm.categoryname, dm.fuelefficiency, dm.transmissionname FROM VEHICLE V, DETAILED_MODEL DM, MODEL M WHERE V.MODELNAME = M.MODELNAME AND V.DETAILEDMODELNAME = DM.DETAILEDMODELNAME AND V.MODELNAME = DM.MODELNAME AND V.ISOPEN ='1' ORDER BY TO_NUMBER(v.serialnumber) ASC";//����ó���Ⱦֵ鸸 �ҷ���
			else//�������϶� ��ü �ٺҷ���
				sql = "SELECT v.serialnumber, v.mileage, v.modelname, v.detailedmodelname, v.price, v.model_year, v.fuelname, v.colorname, v.capacity, v.ishybrid, v.isopen, m.makename, dm.categoryname, dm.fuelefficiency, dm.transmissionname FROM VEHICLE V, DETAILED_MODEL DM, MODEL M WHERE V.MODELNAME = M.MODELNAME AND V.DETAILEDMODELNAME = DM.DETAILEDMODELNAME AND V.MODELNAME = DM.MODELNAME ORDER BY TO_NUMBER(v.serialnumber) ASC";
			ResultSet rs = stmt.executeQuery(sql);
			int i=0;
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			int column = rsmd.getColumnCount();
			
		//	if(!isAdmin)//����嶧
		//		column-=1;
			
			result = new String[rs.getRow()][column];
			rs.beforeFirst();
			while(rs.next())
			{
			
				for(int j=0;j<column;j++)
				{
					
					if(j==5)
					{
						StringTokenizer strtok = new StringTokenizer(rs.getString(j+1)," ");
						result[i][j] = strtok.nextToken();
					}
					else if(j==9)
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}	
					else
					{
						result[i][j] = rs.getString(j+1);
					}
					
					if(j==10 && isAdmin==true)//�������δ� �������϶���
					{
						if(rs.getString(j+1).equals("1"))
							result[i][j] = "O";
						else
							result[i][j] = "X";
					}
					
					
				}
				i++;
			}
				
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return result;
	}
	
	//Ư�� ���� ������ �ҷ���
	public static String[] selectVehicles(boolean isAdmin, String serialnumber)
	{
		String[] result = null;
		
		connect();
		
		try
		{
			String sql = "SELECT * FROM VEHICLE WHERE SERIALNUMBER = '"+serialnumber+"'";
			ResultSet rs = stmt.executeQuery(sql);
		
			ResultSetMetaData rsmd = rs.getMetaData();
			
			rs.last();
			int column = rsmd.getColumnCount();
			
			if(!isAdmin)//����嶧
				column-=1;
				
			result = new String[column];
			rs.beforeFirst();
			while(rs.next())
			{
					
				for(int j=0;j<column;j++)
				{
					//System.out.println(rs.getString(j+1));
					
					if(j==5)
					{
						StringTokenizer strtok = new StringTokenizer(rs.getString(j+1)," ");
						result[j] = strtok.nextToken();
					}
					else if(j==9)
					{
						if(rs.getString(j+1).equals("1"))
							result[j] = "O";
						else
							result[j] = "X";
					}
					else
					{
						result[j] = rs.getString(j+1);
					}
					
					if(j==10 && isAdmin==true)//�������δ� �������϶���
					{
						if(rs.getString(j+1).equals("1"))
							result[j] = "O";
						else
							result[j] = "X";
					}
					
					
					
				}
				
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
			
		return result;
	}	
	
	//���� ������ admin ���� ����
	public static int countAdminAccount()
	{
		int result=0;
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT COUNT(*) FROM ACCOUNT WHERE KIND = 'Admin'";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				result = rs.getInt(1);
			}
			rs.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return result;
	}
	
	//ȸ������ �ҷ�����
	public static String[] selectAccountInfo(String id)
	{
		String[] results = {"","","","","","","","","","","",""};
		int count=0;
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT * FROM ACCOUNT WHERE ID = '"+id+"'";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				// Fill out your code
				results[0] = rs.getString(1);//���̵�
				for(int i=0;i<results.length;i++)
				{	
					if(i!=6)//���ϸ� ����
					{
						results[i] = rs.getString(i+1);
						System.out.println(results[i]);
					}
				}
			}
			rs.close();
			
			sql = "SELECT TO_CHAR(BDATE,'YYYY-MM-DD') FROM ACCOUNT WHERE ID = '"+id+"'";
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				// Fill out your code
				results[6] = rs.getString(1);//����
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return results;
	}
	
	//ȸ��Ż��
	public static boolean deleteAccount(String id)
	{
		connect();
		
		boolean result = false;
		//������ Ȯ��
		try
		{
			
			String sql = "DELETE FROM ACCOUNT WHERE ID = '"+id+"'";
			int res = stmt.executeUpdate(sql);
			
			if(res > 0) 
			{
				result=true;
				System.out.println("Tuple was successfully inserted.");
			}
			else
			{
				result=false;
			}
			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	//������ �������� Ȯ��
	public static boolean isAdmin(String id)
	{
		boolean result=false;
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT KIND FROM ACCOUNT WHERE ID = '"+id+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				if(rs.getString(1).equals("Admin"))
					result = true;
				else
					result = false;
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	public static boolean isMember(String id) //�ش� id �����ϴ��� Ȯ��
	{
		boolean result=false;
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT ID, PASSWORD FROM ACCOUNT WHERE ID = '"+id+"'";
			ResultSet rs = stmt.executeQuery(sql);
			System.out.println("wow");
			if(!rs.next())//�ش� ȸ�� �������� ����
			{
				result = false;//������� (���԰���)
			}
			else {
				result = true;//������ (���ԺҰ���)
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
	}
	
	//ȸ������ ����
	public static boolean updateAccount(String id, String pw, String fname, String lname, String phone, String kind,
				String bdate, String gender, String job, String country, String city, String detail_address)
	{
		connect();
			
		boolean result = false;
		//������ Ȯ��
		try
		{
			
			String sql = "UPDATE ACCOUNT SET PASSWORD = '"+pw+"', FNAME = '"+fname+"', LNAME = '"+lname+"', KIND = '"+kind+"', PHONENUMBER = '"+phone+"', "
					+"BDATE ="+bdate+", GENDER ="+gender+", JOB ="+job+", COUNTRY = "+country+", CITY = "+city+", DETAILADDRESS ="+detail_address+" "
					+ " WHERE ID = '"+id+"'";
			int res = stmt.executeUpdate(sql);
			
			if(res > 0) 
			{
				result=true;
				System.out.println("Tuple was successfully inserted.");
			}
			else
			{
				result=false;
			}
			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
			
	}
	
	//account ���̺� tuple �߰�(ȸ������)
	public static boolean signUpDB(String id, String pw, String fname, String lname, String phone, String kind,
			String bdate, String gender, String job, String country, String city, String detail_address)
	{
		connect();
		
		boolean result = false;
		//������ Ȯ��
		try
		{
			
			String sql = "INSERT INTO ACCOUNT VALUES('"+id+"', '"+kind+"', '"+fname+"', '"+lname+"', '"+pw+"', '"+phone+"',"
					+ " "+bdate+", "+gender+", "+job+", "+country+", "+city+", "+detail_address+")";
			int res = stmt.executeUpdate(sql);
			
			if(res > 0) 
			{
				result=true;
				System.out.println("Tuple was successfully inserted.");
			}
			else
			{
				result=false;
			}
			conn.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		return result;
		
	}
	
	public static String[] signInDB(String id)//�ش� id ���� ���� �� ��й�ȣ ������
	{
		String[] results = {"",""};
	
		connect();
		//������ Ȯ��
		try
		{
			String sql = "SELECT ID, PASSWORD FROM ACCOUNT WHERE ID = '"+id+"'";
			ResultSet rs = stmt.executeQuery(sql);
			System.out.println("wow");
			if(!rs.next())//�ش� ȸ�� �������� ����
			{
				System.out.println("dkdkdkdk");
				results[0] = null;
				results[1] = null;
			}
			else {
				// Fill out your code
				results[0] = rs.getString(1);//���̵�
				results[1] = rs.getString(2);//��й�ȣ
				System.out.println(results[0]+" "+results[1]);
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		disconnect();
		
		return results;
		
	}
	
	private static void connect()
	{
		try {
			// Load a JDBC driver for Oracle DBMS
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// Get a Connection object 
			System.out.println("Success!");
		}catch(ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}

		// Make a connection
		try{
			conn = DriverManager.getConnection(URL, USER_KNU, USER_PASSWD); 
		}catch(SQLException ex) {
			System.err.println("Cannot get a connection: " + ex.getMessage());
			System.exit(1);
		}
		
		try {
			conn.setAutoCommit(false); // auto-commit disabled  
			conn.setTransactionIsolation(java.sql.Connection.TRANSACTION_SERIALIZABLE);	// set transaction isolation level serializable
			// Create a statement object
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	private static void disconnect()
	{
		// Release database resources.
		try {
			// Close the Statement object.
			stmt.close(); 
			// Close the Connection object.
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
