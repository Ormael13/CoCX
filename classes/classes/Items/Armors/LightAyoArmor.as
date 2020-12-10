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
			super("LAyoArm","LAyoArm","light ayo armor","a light ayo armor",15,1,1800,"This suit of platemail is more than just platemail - it have added pieces of Ayo Tech that increase by a large margin it properties as long user is capable to feed it on regular basis with soulforce.","Ayo");
		}
		
		override public function get def():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED] > 0) return 30;
			else return 15;
		}
		
		override public function get mdef():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED] > 0) return 2;
			else return 1;
		}
		
		override public function playerEquip():Armor {
			
			return super.playerEquip();
		}
		
		override public function playerRemove():Armor {
			
			return super.playerRemove();
		}
		
		override public function canUse():Boolean {
			if (game.player.str >= 40) {
				return false;
			}
			outputText("You aren't strong enough to wear this armor!  Unless you likes to move slower than snail and hit weaked than wet noddle!  ");
			return true;
		}
	}
}