package classes.Items.Necklaces 
{
	import classes.Items.Necklace;
	
	public class Nothing extends Necklace
	{
		public function Nothing()
		{
			super("noneckjewel", "noneckjewel", "nothing", "nothing", 0, 0, 0, "no jewelry", "necklace");
		}
		
		override public function playerRemove():Necklace {
			return null; //There is nothing!
		}
	}
}