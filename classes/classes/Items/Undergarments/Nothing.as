package classes.Items.Undergarments 
{
	import classes.Items.Undergarment;

	public class Nothing extends Undergarment
	{
		public function Nothing() {
			super("nounder", "nounder", "nothing", "nothing", -1, 0, "nothing", "light");
		}
		
		override public function playerRemove():Undergarment {
			return null; //Player never picks up their underclothes
		}
	}
}