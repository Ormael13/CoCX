/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;
	import classes.Player;
	import classes.PerkLib;
	import classes.StatusEffects;

	public class ThePhalluspear extends Weapon
	{
		
		public function ThePhalluspear()
		{
			super("Phallus", "Phalluspear", "The Phalluspear", "The Phalluspear", "piercing stab", 40, 1300,
				"This spear is a polearm with a dick-shaped point. You can rotate the shaft to reveal or conceal a wicked, poison-dripping blade hidden within the phallus. Pleasure or pain, this weapon can do both.",
				WT_SPEAR, WSZ_LARGE
			);
			withEffect(IELib.ScaleAttack_Spe, 200);
		}
		
		
		override public function afterEquip(doOutput:Boolean):void {
			game.player.createStatusEffect(StatusEffects.ThePhalluspear1,0,0,0,0);
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			while (game.player.hasStatusEffect(StatusEffects.ThePhalluspear1)) game.player.removeStatusEffect(StatusEffects.ThePhalluspear1);
			super.afterUnequip(doOutput);
		}
	}
}
