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

	public class UltraHeavyAyoArmor extends Armor {
		
		public function UltraHeavyAyoArmor() {//150 * armor + mres
			super("UHAyoArm","UHAyoArm","ultra heavy ayo armor","an ultra heavy ayo armor",180,30,31500,"This suit of armor is more than typical heavy armor - it have added pieces of Ayo Tech that increase by a large margin it properties as long user is capable to feed it on regular basis with soulforce.","Ultra Heavy Ayo");
		}
		
		override public function get def():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 180;
			else return 108;
		}
		
		override public function get mdef():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 30;
			else return 18;
		}
		
		override public function playerEquip():Armor {
			var oldHPratio:Number = game.player.hp100/100;
			game.player.buff("Ayo Armor").addStats( {"str": -50, "spe": -50} );
			game.player.HP = oldHPratio*game.player.maxHP();
			return super.playerEquip();
		}
		
		override public function playerRemove():Armor {
			var oldHPratio:Number = game.player.hp100/100;
			game.player.buff("Ayo Armor").remove();
			game.player.HP = oldHPratio*game.player.maxHP();
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) {
				game.player.soulforce += game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR];
				if (game.player.soulforce > game.player.maxSoulforce()) game.player.soulforce = game.player.maxSoulforce();
				game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
			}
			return super.playerRemove();
		}
		
		override public function canUse():Boolean {
			if (game.player.str >= 100 && game.player.spe >= 100) return super.canUse();
			outputText("You aren't strong and/or agile enough to wear this armor!  Unless you like to move slower than a snail and hit as weak as a wet noodle?  ");
			return false;
		}
	}
}