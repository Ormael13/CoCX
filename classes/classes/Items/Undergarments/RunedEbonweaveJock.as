/**
 * ...
 * @author Zavos
 */
package classes.Items.Undergarments
{
	import classes.Items.Undergarment;
	import classes.PerkLib;

	public class RunedEbonweaveJock extends Undergarment
	{
		
		public function RunedEbonweaveJock()
		{
			super("R. Jock", "Rune Jock", "rune jock", "runed ebonweave jock", UT_BOTTOM, 1200, 3, 1, 3, "This jock is ebonweave, made from refined ebonbloom petals. This jock is comfortable and elastic, providing support while comfortably containing assets of any size. Adorning the front is a rune of lust, glowing with dark magic. \n\nType: Undergarment (Lower)");
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.createPerk(PerkLib.WellspringOfLust, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			while (game.player.hasPerk(PerkLib.WellspringOfLust)) game.player.removePerk(PerkLib.WellspringOfLust);
			super.afterUnequip(doOutput);
		}
		
	}

}
