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
				"This spear features a polearm with a phallus-shaped tip. The shaft can be rotated to reveal or conceal a wicked, poison-dripping blade hidden within the design. Whether it's pleasure or pain, this weapon delivers both.",
				WT_SPEAR, WSZ_LARGE
			);
			withEffect(IELib.ScaleAttack_Spe, 200);
		}
		
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			game.player.createStatusEffect(StatusEffects.ThePhalluspear1,0,0,0,0);
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.ThePhalluspear1)) game.player.removeStatusEffect(StatusEffects.ThePhalluspear1);
			super.afterUnequip(doOutput, slot);
		}
	}
}
