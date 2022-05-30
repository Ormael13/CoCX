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

	public class ArmageddonBlade extends Weapon	{
		
		public function ArmageddonBlade() 
		{
			super("Armaged", "ArmageddonBlade", "Armageddon Blade", "an Armageddon Blade", "slash", 155, 6200, "Re-forged with Divine Power, the Armageddon Blade is the only weapon powerful enough to slay Lethice. Requires 400 strength to fully unleash it power.", "Massive, MGWrath", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 400) boost += 20;
			if (game.player.str >= 350) boost += 20;
			if (game.player.str >= 300) boost += 15;
			if (game.player.str >= 250) boost += 15;
			if (game.player.str >= 200) boost += 10;
			if (game.player.str >= 150) boost += 10;
			if (game.player.str >= 100) boost += 5;
			if (game.player.str >= 50) boost += 5;
			boost += Math.round((100-game.player.cor) / 2);
			return (5 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.GigantGrip)) return super.canUse();
			outputText("You aren't skilled in handling massive weapons, even when using both hands to use this sword.  ");
			return false;
		}
	}
}