/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.PerkLib;
	import classes.StatusEffects;

	public class SoulDrill extends Weapon {
		
		public function SoulDrill()
		{
			super("SDrill", "SoulDrill", "soul drill", "a soul drill", "pierce", 20, 9600, "Soul Drill - the ultimate solution for 'my drill is my soul' cases on this side of Mareth!  This massive hand drill could be powered by soulforce to spin. The more power you channel into it, the faster it spins.", WT_EXOTIC, WSZ_LARGE);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.statusEffectv1(StatusEffects.SoulDrill1) >= 5) boost += 20;
			if (game.player.statusEffectv1(StatusEffects.SoulDrill1) >= 4) boost += 20;
			if (game.player.statusEffectv1(StatusEffects.SoulDrill1) >= 3) boost += 20;
			if (game.player.statusEffectv1(StatusEffects.SoulDrill1) >= 2) boost += 20;
			if (game.player.statusEffectv1(StatusEffects.SoulDrill1) >= 1) boost += 20;
			return (20 + boost);
		}
		
		override public function get verb():String {
			return game.player.statusEffectv1(StatusEffects.SoulDrill1) >= 1 ? "drill" : "pierce";
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			game.player.createStatusEffect(StatusEffects.SoulDrill1,0,0,0,0);
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.SoulDrill1)) game.player.removeStatusEffect(StatusEffects.SoulDrill1);
			super.afterUnequip(doOutput, slot);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.hasPerk(PerkLib.GigantGrip)) return super.canEquip(doOutput, slot);
			if (doOutput) outputText("You aren't yet skilled enough to handle large weapons with one hand effectively. Unless you want to hurt yourself instead of your enemies when trying to use it...  ");
			return false;
		}
	}
}
