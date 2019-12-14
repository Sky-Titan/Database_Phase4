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
}
