/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Undergarments
{
	import classes.Items.Undergarment;
	import classes.PerkLib;

	public class DriderBra extends Undergarment
	{
		
		public function DriderBra()
		{
			super("D. Bra", "Drider silk Bra", "drider bra", "Silky Drider-Weave Bra", UT_TOP, 1800, 2, 3, 4, "This pure-white, delicate-looking bra is made from silk, braided and molded by a skilled Manaweaver. While it’s light and comfortable, always cool on your assets, you can feel power pulsing through each strand of silk. A weblike design cups your assets, with a cutesy fly design in the center, over your nipples. \n\nType: Undergarment (upper)");
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				if (game.player.hasPerk(PerkLib.WizardsFocus))
					game.player.addPerkValue(PerkLib.WizardsFocus, 1, 0.1); //additive - for spidersilk underwear
				else
					game.player.createPerk(PerkLib.WizardsFocus, 0.1, 0, 0, 0);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			if (game.player.perkv1(PerkLib.WizardsFocus) > 0.1)
                game.player.addPerkValue(PerkLib.WizardsFocus, 1, -0.1); //if stacked
            else
			    game.player.removePerk(PerkLib.WizardsFocus); //attempt to remove perk if exists (if not, no perk - no problems)
			super.afterUnequip(doOutput);
		}
		
	}

}
