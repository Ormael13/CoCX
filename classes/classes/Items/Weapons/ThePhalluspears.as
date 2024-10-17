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

	public class ThePhalluspears extends Weapon
	{
		
		public function ThePhalluspears()
		{
			super("D.Phallus", "Phalluspears", "The Phalluspears", "The Phalluspears", "piercing stab", 40, 2600,
				"These spears are polearms with phallus-shaped tips. The shaft can be rotated to reveal or conceal a wicked, poison-dripping blade hidden within the designs. Whether it's pleasure or pain, these weapons deliver both.",
				WT_SPEAR, WSZ_LARGE, true
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
