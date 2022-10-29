/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class MoonlightClaws extends Weapon
	{
		
		public function MoonlightClaws()
		{
			var id:String = "MClaws";
			var shortName:String = "MoonlightClaws";
			var name:String = "Moonlight Claws";
			var longName:String = "a pair of moonlight claws";
			var attribute:String = "clawing punch";
			var attack:Number = 0;
			var value:Number = 4000;
			var description:String = "This pair of claws is imbued with magic, which shall be unleashed as a wave of moonlight. The magic within this will grant greated boon when charged with magic.";
			var perk:String = WP_BLEED25;
			var type:String = WT_GAUNTLET;

			super(id, shortName, name, longName, attribute, attack, value, description, perk, type);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 50) boost += 10;
			if (game.player.str >= 25) boost += 10;
			return (5 + boost); 
		}
	}
}