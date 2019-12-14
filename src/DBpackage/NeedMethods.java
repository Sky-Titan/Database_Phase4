package DBpackage;

public class NeedMethods {

	public NeedMethods()
	{
		
	}
	
	//���ڸ� �ִ��� Ȯ��
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
		//����� �̱�
		long result=0;
		
		if(!month.equals("��ü"))
		{
			if(!month.equals(""))
			{
				if(Integer.parseInt(month) < 10)
				{
					month = "0"+month;
				}
			}
			
		}
		
		if(makes.equals("��ü") && year.equals("��ü")) //�´� ���þ������� �����޽���
		{
			result = connection.selectTotalsales();
			return result;
		}
		else if(!makes.equals("��ü") && !year.equals("��ü") && !month.equals("��ü"))//���� ����
		{
			result = connection.selectTotalsalesBy(year, month, makes);
			return result;
		}
		else if(makes.equals("��ü") && !year.equals("��ü") && !month.equals("��ü"))//make ����x
		{
			result = connection.selectTotalsalesByYearMonth(year, month);
			
		}
		else if(!makes.equals("��ü") && !year.equals("��ü") && month.equals("��ü"))// month ����x
		{
			result = connection.selectTotalsalesBy(year, makes);
			
		}
		else if(!makes.equals("��ü") && year.equals("��ü") && month.equals("")) // year,month ����x
		{
			result = connection.selectTotalsalesBy(makes);
			
		}
		else if(makes.equals("��ü") && !year.equals("��ü") && month.equals("��ü")) // make, month ����x
		{
			result = connection.selectTotalsalesByYear(year);
			
		}
		return result;
	}
}
