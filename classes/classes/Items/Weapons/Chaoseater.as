/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.ItemTags;
	import classes.Player;
	import classes.PerkLib;
	import classes.StatusEffects;

	public class Chaoseater extends Weapon {
		
		public function Chaoseater()
		{
			super("Chaosea", "Chaoseater", "Chaoseater", "a Chaoseater", "slash", 410, 65600, "It's incredibly large blade with jagged edges on both sides along with the skulls engraved within the middle of the blade. Requires 500 strength to fully unleash it power.", "Massive, MGWrath", "Sword");
			withTag(ItemTags.I_LEGENDARY);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) boost += 400;
			else {
				var scal:Number = 10;
				if (game.player.str >= 500) {
					boost += 100;
					scal -= 1;
				}
				if (game.player.str >= 400) {
					boost += 70;
					scal -= 1;
				}
				if (game.player.str >= 300) {
					boost += 40;
					scal -= 1;
				}
				if (game.player.str >= 250) {
					boost += 40;
					scal -= 1;
				}
				if (game.player.str >= 200) {
					boost += 30;
					scal -= 1;
				}
				if (game.player.str >= 150) {
					boost += 30;
					scal -= 1;
				}
				if (game.player.str >= 100) {
					boost += 20;
					scal -= 1;
				}
				if (game.player.str >= 50) {
					boost += 20;
					scal -= 1;
				}
				boost += Math.round(game.player.cor / scal);
			}
			return (10 + boost);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.GigantGrip)) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't skilled enough in handling massive weapons, even when using both hands to use this sword.");
			return false;
		}
	}
}
