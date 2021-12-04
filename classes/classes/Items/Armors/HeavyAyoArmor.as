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

	public class HeavyAyoArmor extends Armor {
		
		public function HeavyAyoArmor() {//100 * armor + mres
			super("HAyoArm","HAyoArm","heavy ayo armor","a heavy ayo armor",120,20,14000,"This suit of armor is more than typical heavy armor - it have added pieces of Ayo Tech that increase by a huge margin it properties as long user is capable to feed it on regular basis with soulforce.","Heavy Ayo");
		}
		
		override public function get def():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 120;
			else return 72;
		}
		
		override public function get mdef():Number { 
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 20;
			else return 12;
		}
		
		override public function playerEquip():Armor {
			var oldHPratio:Number = game.player.hp100/100;
			game.player.buff("Ayo Armor").addStats( {"str": -20, "spe": -20} );
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
			if (game.player.str >= 40 && game.player.spe >= 40) return super.canUse();
			outputText("You aren't strong and agile enough to wear this armor!  Unless you likes to move slower than snail and hit weaked than wet noddle!  ");
			return false;
		}
	}
}