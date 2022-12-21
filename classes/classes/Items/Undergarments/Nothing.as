package classes.Items.Undergarments
{
	import classes.Items.Undergarment;

	public class Nothing extends Undergarment
	{
		public function Nothing() {
			super("nounder", "nounder", "nothing", "nothing", UT_ANY, 0, 0, 0, 0, "nothing", "light");
		}
		
		override public function get isNothing():Boolean {
			return true;
		}
	}
}
