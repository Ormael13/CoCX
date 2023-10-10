/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class TwinStormRulers extends Weapon {
		
		public function TwinStormRulers() 
		{
			super("TSRuler", "T.S.Rulers", "Twin Storm Rulers", "a Twin Storm Rulers", "smash", 14, 9600, "It's looking like a pair of greatwords with broken blade still possesing residual power of lightning. Also known as the Giantslayers for bringings giants to their knees.", "Dual Large, Stun10", WT_MACE_HAMMER);
			withBuffs({'psoulskillpower': +0.4});
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if ((game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && game.player.hasPerk(PerkLib.AntyDexterity))) {
				return super.canEquip(doOutput);
			}
			if (!game.player.hasPerk(PerkLib.GigantGrip) && !game.player.hasPerk(PerkLib.AntyDexterity)) {
				if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
				return false;
			}
			if (doOutput) outputText("You aren't skilled in handling large weapons with one hand yet to effectively use those broken greatswords. Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
			return false;
		}
	}
}
