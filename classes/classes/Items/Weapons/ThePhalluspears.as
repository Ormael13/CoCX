/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.PerkLib;
	import classes.StatusEffects;

	public class ThePhalluspears extends Weapon
	{
		
		public function ThePhalluspears() 
		{
			super("Phallus", "Phalluspears", "The Phalluspears", "The Phalluspears", "piercing stab", 40, 2600,
				"Those spears are a polearms with a dick-shaped point. You can rotate the shaft to reveal or conceal a wicked, poison-dripping blade hidden within the phalluses. Pleasure or pain, this weapon can do both.",
				"Dual Large", "Spear"
			);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.spe >= 200) boost += 10;
			if (game.player.spe >= 150) boost += 9;
			if (game.player.spe >= 100) boost += 9;
			if (game.player.spe >= 50) boost += 8;
			return (4 + boost);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			game.player.createStatusEffect(StatusEffects.ThePhalluspear1,0,0,0,0);
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			while (game.player.hasStatusEffect(StatusEffects.ThePhalluspear1)) game.player.removeStatusEffect(StatusEffects.ThePhalluspear1);
			super.afterUnequip(doOutput);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) {
				return super.canEquip(doOutput);
			}
			if (doOutput) outputText("You aren't skilled enough to handle this pair of spears!  ");
			return false;
		}
	}
}
