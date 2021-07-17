/**
 * ...
 * @author Zavos
 */
package classes.Items.Undergarments 
{
	import classes.Items.Undergarment;
	import classes.PerkLib;
	import classes.Player;

	public class RunedEbonweaveThong extends Undergarment
	{
		public static const TYPE_LOWERWEAR:int = 1;
		
		public function RunedEbonweaveThong() 
		{
			super("R.Thong", "RuneThong", "rune thong", "runed ebonweave thong", TYPE_LOWERWEAR, 1200, "This thong is ebonweave, designed to fit snugly around your form. Thanks to the alchemical treatments, this thong is elastic enough to comfortably hold assets of any size. Adorning the front is a rune of lust, glowing with dark magic. \n\nType: Undergarments (Lower)");
		}
		
		override public function playerEquip():Undergarment {
			game.player.createPerk(PerkLib.WellspringOfLust, 0, 0, 0, 0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Undergarment {
			while (game.player.hasPerk(PerkLib.WellspringOfLust)) game.player.removePerk(PerkLib.WellspringOfLust);
			return super.playerRemove();
		}
		
	}

}