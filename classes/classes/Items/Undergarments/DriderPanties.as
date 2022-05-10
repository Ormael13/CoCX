/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Undergarments 
{
	import classes.Items.Undergarment;
	import classes.PerkLib;
	import classes.Player;

	public class DriderPanties extends Undergarment
	{
		public static const TYPE_LOWERWEAR:int = 1;
		
		public function DriderPanties() 
		{
			super("D. Pnte", "Drider silk Panties", "drider panties", "Silky Drider-Weave Panties", TYPE_LOWERWEAR, 2100, "This pair of panties is exquisitely made, to the point where you genuinely think they belong in a picture frame. Thin strands of silk cross the front in a weblike pattern, offering just enough solid material to cover your most enticing bits. The rest of it is sheer, letting whoever’s looking see pretty much everything else. Brown-tinted bits of silk form the seams, looking for all the world like the twigs such a web would nestle between. Despite the translucent nature of the fabric, the flex of the material is clear, and each strand, while gentle on your fingers and assets, shows no sign of yielding to a blade. \n\nType: Undergarment (Lower)");
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) {
				return false;
			}
			outputText("You slide the Drider-weave panties up your [legs], the cool fabric light as a feather. As you cover your groin, you can all but feel your mana flowing through your endowments and into the fabric, making it shimmer gently.\n\n");
			return true;
		}
		
		override public function playerEquip():Undergarment {
            if (game.player.hasPerk(PerkLib.WizardsFocus))
				game.player.addPerkValue(PerkLib.WizardsFocus, 1, 0.1); //additive - for spidersilk underwear
            else
                game.player.createPerk(PerkLib.WizardsFocus, 0.2, 0, 0, 0);
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