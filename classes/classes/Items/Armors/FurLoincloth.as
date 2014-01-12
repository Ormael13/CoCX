/**
 * Created by aimozg on 11.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Items.ArmorLib;

	public class FurLoincloth extends Armor
	{


		override public function get description():String
		{
			return "A pair of loincloths to cover your crotch and " + wearer.buttDescript() + ".  Typically worn by people named 'Conan'."
		}

		public function FurLoincloth()
		{
			super("FurLoin","FurLoin","a front and back set of loincloths",0,100,"A pair of loincloths to cover your crotch and butt.  Typically worn by people named 'Conan'.","Light");
		}
	}
}
