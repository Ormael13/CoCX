/**
 * ...
 * @author Zavos
 */
package classes.Items.Undergarments
{
	import classes.Items.Undergarment;
	import classes.PerkLib;

	public class RunedEbonweaveThong extends Undergarment
	{
		public function RunedEbonweaveThong()
		{
			super("R.Thong", "RuneThong", "rune thong", "runed ebonweave thong", UT_BOTTOM, 1200, 3, 1, 3, "This thong is ebonweave, designed to fit snugly around your form. Thanks to the alchemical treatments, this thong is elastic enough to comfortably hold assets of any size. Adorning the front is a rune of lust, glowing with dark magic. \n\nType: Undergarments (Lower)");
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
