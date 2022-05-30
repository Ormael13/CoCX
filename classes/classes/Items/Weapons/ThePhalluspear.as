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

	public class ThePhalluspear extends Weapon
	{
		
		public function ThePhalluspear() 
		{
			super("Phallus", "Phalluspear", "The Phalluspear", "The Phalluspear", "piercing stab", 40, 1600,
				"This spear is a polearm with a dick-shaped point. You can rotate the shaft to reveal or conceal a wicked, poison-dripping blade hidden within the phallus. Pleasure or pain, this weapon can do both.",
				"Large", "Spear"
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
		
		override public function playerEquip():Weapon {
			game.player.createStatusEffect(StatusEffects.ThePhalluspear1,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon {
			while (game.player.hasStatusEffect(StatusEffects.ThePhalluspear1)) game.player.removeStatusEffect(StatusEffects.ThePhalluspear1);
			return super.playerRemove();
		}
	}
}