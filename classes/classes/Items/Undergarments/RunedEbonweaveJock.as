/**
 * ...
 * @author Zavos
 */
package classes.Items.Undergarments 
{
	import classes.Items.Undergarment;
	import classes.PerkLib;
	import classes.Player;

	public class RunedEbonweaveJock extends Undergarment
	{
		public static const TYPE_LOWERWEAR:int = 1;
		
		public function RunedEbonweaveJock() 
		{
			super("R. Jock", "Rune Jock", "rune jock", "runed ebonweave jock", TYPE_LOWERWEAR, 1200, "This jock is ebonweave, made from refined ebonbloom petals. This jock is comfortable and elastic, providing support while comfortably containing assets of any size. Adorning the front is a rune of lust, glowing with dark magic. \n\nType: Undergarment (Lower)");
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