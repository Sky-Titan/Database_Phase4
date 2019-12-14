package DBpackage;

public class NeedMethods {

	public NeedMethods()
	{
		
	}
	
	//숫자만 있는지 확인
	public boolean isOnlyNumber(String text)
	{
		for(int i=65;i<=90;i++)
		{
			if(text.contains(String.format("%c", i)))
			{
				return false;
			}
		}
		for(int i=97;i<=122;i++)
		{
			if(text.contains(String.format("%c", i)))
			{
				return false;
			}
		}
		return true;
	}
	
	public long calculate(String makes, String year, String month) throws Exception
	{
		DBConnection connection = new DBConnection();
		//매출액 뽑기
		long result=0;
		
		if(!month.equals("전체"))
		{
			if(!month.equals(""))
			{
				if(Integer.parseInt(month) < 10)
				{
					month = "0"+month;
				}
			}
			
		}
		
		if(makes.equals("전체") && year.equals("전체")) //셋다 선택안했으면 오류메시지
		{
			result = connection.selectTotalsales();
			return result;
		}
		else if(!makes.equals("전체") && !year.equals("전체") && !month.equals("전체"))//전부 선택
		{
			result = connection.selectTotalsalesBy(year, month, makes);
			return result;
		}
		else if(makes.equals("전체") && !year.equals("전체") && !month.equals("전체"))//make 선택x
		{
			result = connection.selectTotalsalesByYearMonth(year, month);
			
		}
		else if(!makes.equals("전체") && !year.equals("전체") && month.equals("전체"))// month 선택x
		{
			result = connection.selectTotalsalesBy(year, makes);
			
		}
		else if(!makes.equals("전체") && year.equals("전체") && month.equals("")) // year,month 선택x
		{
			result = connection.selectTotalsalesBy(makes);
			
		}
		else if(makes.equals("전체") && !year.equals("전체") && month.equals("전체")) // make, month 선택x
		{
			result = connection.selectTotalsalesByYear(year);
			
		}
		return result;
	}
}
