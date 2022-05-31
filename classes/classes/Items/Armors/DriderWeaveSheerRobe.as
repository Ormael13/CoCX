/**
 * @author Canadian Snas
 */
package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.Items.UndergarmentLib;
	import classes.PerkLib;
	import classes.Player;
	import classes.StatusEffects;

	public class DriderWeaveSheerRobe extends ArmorWithPerk
	{
		
		public function DriderWeaveSheerRobe() 
		{
			super("DWSRobe","DWSheerRobe","Drider-Weave Sheer Robe","a Drider-Weave Sheer Robe",8,58,13200,"At first glance, this robe looks like a set of standard mage’s robes, with a few small differences. The silk shimmers blue, and when you touch the garment, a golden glow comes from the hems. The sleeves are long, and you can see the top of the sleeves are longer, with a golden metal ‘ring’ on the end.","Light",
				PerkLib.WizardsEnduranceAndSluttySeduction,60,50,0,0,"", false, false);
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) {
				return false;
			}
			outputText("The robes are light, and as you slide them over your head, sliding easily down over your shoulders, you could swear you’re wearing nothing at all. As you slide your middle finger into the metal at the end of the sleeve, it tightens slightly, just enough to make a snug fit. You can feel magic pulsing through the robe, culminating at the clasp. You focus on the shimmering metal, letting your magic flow…The robe lights up, and as you look down at yourself, you can clearly see through the fabric.\n\n");
			if (game.player.upperGarment != UndergarmentLib.NOTHING) outputText("You poke your [uppergarment] through the sheer fabric, then take some of the robe between two fingers.");
			else outputText("Your [breasts] are visible to the world, and as you watch, your nipples stand up at the exposure.");
			if (game.player.lowerGarment == UndergarmentLib.NOTHING) {
				outputText("\n\nYou look between your [legs], and to your ");
				if (game.player.cor < 30) outputText("dismay");
				else if (game.player.cor > 60) outputText("delight");
				else outputText("indifference");
				outputText(", your endowments are on full display.");
			}
			outputText("\n\nYou let the magic fade from your new robes, and they return to normal, looking for all the world like silky wizard’s robes…With a delightful secret. You briefly wonder if Belisa intended to make something so lewd.");
			return true;
		}
	}
}