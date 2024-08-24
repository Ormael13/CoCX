/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class HarkonnenII extends WeaponRange {
		
		public function HarkonnenII() 
		{
			super("Harkon2", "HarkonnenII", "Harkonnen II", "a Harkonnen II", "shot", 260, 10460, "This pair of 30mm auto cannons belt-fed from two large ammunition boxes carried on her back use 'true damage' shells.", WT_DUAL_2H_FIREARMS)
			withBuffs({'rangedaccuracy':-100});
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if ((game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && game.player.hasPerk(PerkLib.AntyDexterity))) {
				return super.canEquip(doOutput, slot);
			}
			if (!game.player.hasPerk(PerkLib.GigantGrip) && !game.player.hasPerk(PerkLib.AntyDexterity)) {
				if (doOutput) outputText("You aren't skilled enough to handle this pair of firearms!  ");
				return false;
			}
			if (doOutput) outputText("You aren't skilled in handling large firearms with one hand yet to effectively use those cannons. Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
			return false;
		}
	}
}
