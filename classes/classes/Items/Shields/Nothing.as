package classes.Items.Shields
{
	import classes.Items.Shield;
	
	public class Nothing extends Shield
	{
		public function Nothing()
		{
			super("noshild", "noshield", "nothing", "nothing", 0, 0, "no shield", "shield");
		}
		
		override public function get isNothing():Boolean {
			return true;
		}
	}
}
