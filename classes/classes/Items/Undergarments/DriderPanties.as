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
			super("D. Bra", "Drider silk Panties", "Drider Panties", "Silky Drider-Weave Panties", TYPE_LOWERWEAR, 1400, "This pair of panties is exquisitely made, to the point where you genuinely think they belong in a picture frame. Thin strands of silk cross the front in a weblike pattern, offering just enough solid material to cover your most enticing bits. The rest of it is sheer, letting whoever’s looking see pretty much everything else. Brown-tinted bits of silk form the seams, looking for all the world like the twigs such a web would nestle between. Despite the translucent nature of the fabric, the flex of the material is clear, and each strand, while gentle on your fingers and assets, shows no sign of yielding to a blade. \n\nType: Undergarment (Lower)");
		}
		
		override public function playerEquip():Undergarment {
			game.player.createPerk(PerkLib.WizardsFocus, 0.2, 0, 0, 0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Undergarment {
			while (game.player.hasPerk(PerkLib.WizardsFocus)) game.player.removePerk(PerkLib.WizardsFocus);
			return super.playerRemove();
		}
		
	}

}