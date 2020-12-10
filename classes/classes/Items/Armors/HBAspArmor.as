/**
 * ...
 * @author Ormael
 */
package classes.Items.Armors
{
	import classes.GlobalFlags.kFLAGS;
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	public class HBAspArmor extends Armor {
		
		public function HBAspArmor() 
		{
			super("HBA Arm","HBA Arm","HBA armor","a HBA armor",10,5,1800,"This suit of armor is more than just platemail - it was reverse engineered from almost intact armor of elf-like offworlders. Outfitted with scavenged Ayo Tech it protective properties would increase as long user is capable to feed it on regular basis with soulforce.","Ayo");
		}
		
		override public function get def():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED] > 0) return 20;
			else return 10;
		}
		
		override public function get mdef():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED] > 0) return 10;
			else return 5;
		}
		
		override public function playerEquip():Armor {
			
			return super.playerEquip();
		}
		
		override public function playerRemove():Armor {
			
			return super.playerRemove();
		}
		
		override public function canUse():Boolean {
			if (game.player.str >= 40 && game.player.tallness >= 72) {
				return false;
			}
			if (game.player.str < 40) outputText("You aren't strong enough to wear this armor!  Unless you likes to move slower than snail and hit weaked than wet noddle!  ");
			else outputText("You aren't tall enough to wear this armor!  ");
			return true;
		}
	}
}