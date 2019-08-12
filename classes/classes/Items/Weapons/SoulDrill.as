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
			super("SDrill", "SoulDrill", "soul drill", "a soul drill", "pierce", 20, 9600, "Soul Drill - the best solution for 'my drill is my soul' cases on this side of Mareth!  This huge hand drill could be powered by soulforce to spin. Thge more you power it up the faster it spin.", "Large");
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
		
		override public function playerEquip():Weapon {
			game.player.createStatusEffect(StatusEffects.SoulDrill1,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon {
			while (game.player.hasStatusEffect(StatusEffects.SoulDrill1)) game.player.removeStatusEffect(StatusEffects.SoulDrill1);
			return super.playerRemove();
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.TitanGrip) >= 0) return true;
			outputText("You aren't skilled in handling large weapons with one hand yet to effectively use this drill. Unless you want to hurt yourself instead enemies when trying to use it...  ");
			return false;
		}
	}
}