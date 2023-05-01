/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.PerkLib;
	import classes.StatusEffects;

	public class Chaoseater extends Weapon {
		
		public function Chaoseater()
		{
			super("Chaosea", "Chaoseater", "Chaoseater", "a Chaoseater", "slash", 410, 65600, "It's incredibly large blade with jagged edges on both sides along with the skulls engraved within the middle of the blade. Requires 500 strength to fully unleash it power.", "Massive, MGWrath", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
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
			return (10 + boost);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.GigantGrip) && game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) {
				if (game.player.level < 54) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
				else outputText("You aren't skilled in handling massive weapons, even when using both hands to use this sword.  ");
			}
			return false;
		}
	}
}
