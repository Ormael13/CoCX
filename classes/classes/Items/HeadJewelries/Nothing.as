package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	
	public class Nothing extends HeadJewelry
	{
		public function Nothing()
		{
			super("noheadjewel", "noheadjewel", "nothing", "nothing", 0, 0, 0, "no jewelry", "headacc");
		}
		
		override public function playerRemove():HeadJewelry {
			return null; //There is nothing!
		}
	}
}