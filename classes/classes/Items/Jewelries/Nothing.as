package classes.Items.Jewelries
{
	import classes.Items.Jewelry;
	
	public class Nothing extends Jewelry
	{
		public function Nothing()
		{
			super("nojewel", "nojewel", "nothing", "nothing", 0, 0, 0, "no jewelry");
		}
		
		override public function get isNothing():Boolean {
			return true;
		}
	}
}
