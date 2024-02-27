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
			super("TSRuler", "T.S.Rulers", "Twin Storm Rulers", "a pair of Storm Rulers", "smash", 15, 9600, "A pair of greatwords with broken blades, still possessing the residual power of lightning. Also known as the 'Giantslayer', for bringing giants to their knees. Deals increased damage to large enemies.", "Dual Large, Stun10", WT_MACE_HAMMER);
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
