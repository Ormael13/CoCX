/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.Weapon;

	public class DualLethiciteWhip extends Weapon {
		
		public function DualLethiciteWhip() 
		{
			super("DL.Whip","DL.Whip","twin flaming whips","a dual flaming whips once belonging to Lethice","whip-crack", 20, 3200, "Those whips once belonged to Lethice who was defeated at your hands. It gives off flames when you crack those whips.", "Dual, Whipping", "Whip");
			withBuffs({'teasedmg': 50});
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 20;
			return (20 + boost); 
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if(doOutput)outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}
