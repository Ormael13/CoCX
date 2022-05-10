/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Undergarments 
{
	import classes.Items.Undergarment;
	import classes.PerkLib;
	import classes.Player;

	public class DriderBra extends Undergarment
	{
		public static const TYPE_UPPERWEAR:int = 0;
		
		public function DriderBra() 
		{
			super("D. Bra", "Drider silk Bra", "drider bra", "Silky Drider-Weave Bra", TYPE_UPPERWEAR, 1800, "This pure-white, delicate-looking bra is made from silk, braided and molded by a skilled Manaweaver. While it’s light and comfortable, always cool on your assets, you can feel power pulsing through each strand of silk. A weblike design cups your assets, with a cutesy fly design in the center, over your nipples. \n\nType: Undergarment (upper)");
		}
		
		override public function playerEquip():Undergarment {
            if (game.player.hasPerk(PerkLib.WizardsFocus))
				game.player.addPerkValue(PerkLib.WizardsFocus, 1, 0.1); //additive - for spidersilk underwear
            else
                game.player.createPerk(PerkLib.WizardsFocus, 0.1, 0, 0, 0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Undergarment {
			if (game.player.perkv1(PerkLib.WizardsFocus) > 0.1)
                game.player.addPerkValue(PerkLib.WizardsFocus, 1, -0.1); //if stacked
            else
			    game.player.removePerk(PerkLib.WizardsFocus); //attempt to remove perk if exists (if not, no perk - no problems)
			return super.playerRemove();
		}
		
	}

}