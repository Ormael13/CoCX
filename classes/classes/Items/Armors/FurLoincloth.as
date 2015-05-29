/**
 * Created by aimozg on 11.01.14.
 */
//Not used in game
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Items.ArmorLib;

	public final class FurLoincloth extends Armor
	{
		public function FurLoincloth()
		{
			super("FurLoin","FurLoin","revealing fur loincloths","a front and back set of loincloths",0,100,"A pair of loincloths to cover your crotch and butt.  Typically worn by people named 'Conan'.","Light");
		}
		
		override public function get description():String
		{
			return "A pair of loincloths to cover your crotch and " + game.player.buttDescript() + ".  Typically worn by people named 'Conan'. \n\nType: Clothing \nDefense: 0 \nBase value: 100"
		}
	}
}
