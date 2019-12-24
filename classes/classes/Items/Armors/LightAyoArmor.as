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

	public final class LightAyoArmor extends Armor {
		
		public function LightAyoArmor() {
			super("LAyoArm","LAyoArm","light ayo armor","a light ayo armor",15,0,1800,"This suit of platemail is more than just platemail - it have added pieces of still enigmatic Ayo Tech that increase by a large margin it properties as long user is capable to feed it on regular basis with soulforce.","Ayo");
		}
		
		override public function get def():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED] > 0) return 30;
			else return 15;
		}
		
		override public function canUse():Boolean {
			if (game.player.tallness >= 80) {
				return false;
			}
			outputText("You aren't tall enough to wear this kimono!  ");
			return true;
		}
	}
}