package classes.Items.Jewelries 
{
	import classes.ItemType;
	import classes.Items.Jewelry;
	import classes.Player;
	
	public class Nothing extends Jewelry
	{
		public function Nothing()
		{
			super("nojewel", "nojewel", "nothing", "nothing", 0, 0, 0, "no jewelry", "ring");
		}
		
		override public function playerRemove():Jewelry {
			return null; //There is nothing!
		}
	}
}