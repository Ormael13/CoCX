package classes.Items.Weapons
{
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.Weapon;

	public class LethiciteWhip extends Weapon {
		
		public function LethiciteWhip() {
			super("L. Whip","L. Whip","flaming whip","a flaming whip once belonged to Lethice","whip-crack", 20, 1600, "This whip once belonged to Lethice who was defeated at your hands. It gives off flames when you crack this whip.");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 20;
			return (20 + boost); 
		}
	}
}