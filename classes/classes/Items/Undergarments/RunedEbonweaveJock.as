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
			super("R. Jock", "Rune Jock", "rune jock", "runed ebonweave jock", TYPE_LOWERWEAR, 1200, "A pair of comfortable undergarment. \n\nType: Undergarments (Lower)");
		}
		
		override public function playerEquip():Undergarment {
			game.player.createPerk(PerkLib.WellspringOfLust, 0, 0, 0, 0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Undergarment {
			while (game.player.findPerk(PerkLib.WellspringOfLust) >= 0) game.player.removePerk(PerkLib.WellspringOfLust);
			return super.playerRemove();
		}
		
	}

}